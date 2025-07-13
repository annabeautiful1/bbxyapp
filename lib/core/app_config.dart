import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'BBXYApp';
  static const String appVersion = '1.0.0';
  static const Color primaryColor = Color(0xFF6366F1);

  // SSPanel API 配置
  static const String apiVersion = 'v1';
  static const int apiTimeout = 30000;
  static const int maxRetries = 3;

  // OSS 域名配置 - 自动选择最佳域名
  static const List<String> ossDomains = [
    'https://bbxy.xn--cesw6hd3s99f.com',
    'https://cn1.cardsakura.buzz',
    'https://cn1.bbxy.fun',
    'https://bbxy.buzz',
  ];

  // 域名发布页面
  static const List<String> publishDomains = [
    'https://bbxy88.com',
    'https://bbxy88.top',
    'https://bbxy88.xyz',
  ];

  // API 路径
  static const String apiPath = '/api/v1';

  // 应用配置
  static const bool debugMode = true;
  static const String userAgent = 'BBXYApp/$appVersion';

  // 存储键名
  static const String storageKeyToken = 'auth_token';
  static const String storageKeyUser = 'user_info';
  static const String storageKeyTheme = 'theme_mode';
  static const String storageKeyLocale = 'locale';
  static const String storageKeyBestDomain = 'best_domain';
  static const String storageKeyLastDomainCheck = 'last_domain_check';

  // 域名检测配置
  static const int domainCheckInterval = 300000; // 5分钟
  static const int domainTimeoutMs = 5000; // 5秒超时

  // 获取完整的API地址
  static String getApiUrl(String baseUrl) {
    return '$baseUrl$apiPath';
  }

  // 获取订阅链接地址
  static String getSubscriptionUrl(String baseUrl) {
    return '$baseUrl/link/';
  }
}
