import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_config.dart';
import '../models/user.dart';
import 'oss_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final Dio _dio = Dio();
  final OSSService _ossService = OSSService();

  /// 初始化服务
  Future<void> initialize() async {
    _dio.options.timeout = Duration(milliseconds: AppConfig.apiTimeout);
    _dio.options.headers['User-Agent'] = AppConfig.userAgent;

    // 添加请求拦截器
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // 获取最佳域名
        final bestDomain = await _ossService.getBestDomain();
        if (bestDomain != null) {
          options.baseUrl = AppConfig.getApiUrl(bestDomain);
        }

        // 添加认证token
        final token = await getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        // 处理401错误，清除token
        if (error.response?.statusCode == 401) {
          await clearToken();
        }
        handler.next(error);
      },
    ));
  }

  /// 用户登录
  Future<User?> login(String email, String password,
      {String? twoFactorCode}) async {
    try {
      final response = await _dio.post('/auth/login', data: {
        'email': email,
        'password': password,
        if (twoFactorCode != null) '2fa_code': twoFactorCode,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        final userInfo = data['user'];

        // 保存token
        await saveToken(token);

        // 保存用户信息
        final user = User.fromJson(userInfo);
        await saveUser(user);

        return user;
      }
    } catch (e) {
      print('登录失败: $e');
      rethrow;
    }
    return null;
  }

  /// 用户注册
  Future<User?> register(String email, String password,
      {String? inviteCode}) async {
    try {
      final response = await _dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        if (inviteCode != null) 'invite_code': inviteCode,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['token'];
        final userInfo = data['user'];

        // 保存token
        await saveToken(token);

        // 保存用户信息
        final user = User.fromJson(userInfo);
        await saveUser(user);

        return user;
      }
    } catch (e) {
      print('注册失败: $e');
      rethrow;
    }
    return null;
  }

  /// 获取用户信息
  Future<User?> getUserInfo() async {
    try {
      final response = await _dio.get('/user/profile');

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        await saveUser(user);
        return user;
      }
    } catch (e) {
      print('获取用户信息失败: $e');
      rethrow;
    }
    return null;
  }

  /// 退出登录
  Future<void> logout() async {
    try {
      await _dio.post('/auth/logout');
    } catch (e) {
      print('退出登录失败: $e');
    } finally {
      await clearToken();
      await clearUser();
    }
  }

  /// 保存token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.storageKeyToken, token);
  }

  /// 获取token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConfig.storageKeyToken);
  }

  /// 清除token
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.storageKeyToken);
  }

  /// 保存用户信息
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConfig.storageKeyUser, jsonEncode(user.toJson()));
  }

  /// 获取用户信息
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(AppConfig.storageKeyUser);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  /// 清除用户信息
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.storageKeyUser);
  }

  /// 检查是否已登录
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  /// 发送验证码
  Future<bool> sendVerificationCode(String email) async {
    try {
      final response = await _dio.post('/auth/send-code', data: {
        'email': email,
      });
      return response.statusCode == 200;
    } catch (e) {
      print('发送验证码失败: $e');
      return false;
    }
  }

  /// 重置密码
  Future<bool> resetPassword(
      String email, String code, String newPassword) async {
    try {
      final response = await _dio.post('/auth/reset-password', data: {
        'email': email,
        'code': code,
        'password': newPassword,
      });
      return response.statusCode == 200;
    } catch (e) {
      print('重置密码失败: $e');
      return false;
    }
  }
}
