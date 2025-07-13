import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../core/app_config.dart';

class OSSService {
  static final OSSService _instance = OSSService._internal();
  factory OSSService() => _instance;
  OSSService._internal();

  String? _bestDomain;
  Timer? _domainCheckTimer;
  final Map<String, int> _domainLatencies = {};

  /// 获取最佳域名
  Future<String?> getBestDomain() async {
    // 检查缓存
    if (_bestDomain != null && _shouldUseCachedDomain()) {
      return _bestDomain;
    }

    // 检测所有域名延迟
    await _checkAllDomains();

    // 返回最佳域名
    return _bestDomain;
  }

  /// 检查是否应该使用缓存的域名
  bool _shouldUseCachedDomain() {
    final prefs = SharedPreferences.getInstance();
    return prefs.then((p) {
      final lastCheck = p.getInt(AppConfig.storageKeyLastDomainCheck) ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;
      return now - lastCheck < AppConfig.domainCheckInterval;
    }) as bool;
  }

  /// 检测所有域名的延迟
  Future<void> _checkAllDomains() async {
    final futures =
        AppConfig.ossDomains.map((domain) => _checkDomainLatency(domain));

    try {
      await Future.wait(futures);

      // 选择延迟最小的域名
      if (_domainLatencies.isNotEmpty) {
        final sortedDomains = _domainLatencies.entries.toList()
          ..sort((a, b) => a.value.compareTo(b.value));

        _bestDomain = sortedDomains.first.key;

        // 保存到本地存储
        await _saveBestDomain(_bestDomain!);

        print('OSS: 选择最佳域名: $_bestDomain (${sortedDomains.first.value}ms)');
      }
    } catch (e) {
      print('OSS: 域名检测失败: $e');
      // 使用默认域名
      _bestDomain = AppConfig.ossDomains.first;
    }
  }

  /// 检测单个域名的延迟
  Future<void> _checkDomainLatency(String domain) async {
    final stopwatch = Stopwatch()..start();

    try {
      final response = await http.head(
        Uri.parse(domain),
        headers: {'User-Agent': AppConfig.userAgent},
      ).timeout(Duration(milliseconds: AppConfig.domainTimeoutMs));

      stopwatch.stop();

      if (response.statusCode == 200 || response.statusCode == 302) {
        _domainLatencies[domain] = stopwatch.elapsedMilliseconds;
        print('OSS: $domain 延迟: ${stopwatch.elapsedMilliseconds}ms');
      }
    } catch (e) {
      stopwatch.stop();
      print('OSS: $domain 检测失败: $e');
      // 不添加到延迟列表中，表示该域名不可用
    }
  }

  /// 保存最佳域名到本地存储
  Future<void> _saveBestDomain(String domain) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.storageKeyBestDomain, domain);
    await prefs.setInt(
      AppConfig.storageKeyLastDomainCheck,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// 从本地存储加载最佳域名
  Future<void> _loadBestDomain() async {
    final prefs = await SharedPreferences.getInstance();
    _bestDomain = prefs.getString(AppConfig.storageKeyBestDomain);
  }

  /// 启动定时检测
  void startPeriodicCheck() {
    _domainCheckTimer?.cancel();
    _domainCheckTimer = Timer.periodic(
      Duration(milliseconds: AppConfig.domainCheckInterval),
      (_) => _checkAllDomains(),
    );
  }

  /// 停止定时检测
  void stopPeriodicCheck() {
    _domainCheckTimer?.cancel();
    _domainCheckTimer = null;
  }

  /// 手动刷新域名检测
  Future<String?> refreshDomains() async {
    _domainLatencies.clear();
    await _checkAllDomains();
    return _bestDomain;
  }

  /// 获取所有域名的延迟信息
  Map<String, int> getDomainLatencies() {
    return Map.from(_domainLatencies);
  }

  /// 初始化服务
  Future<void> initialize() async {
    await _loadBestDomain();
    startPeriodicCheck();

    // 如果没有缓存的域名，立即检测
    if (_bestDomain == null) {
      await _checkAllDomains();
    }
  }

  /// 销毁服务
  void dispose() {
    stopPeriodicCheck();
  }
}
