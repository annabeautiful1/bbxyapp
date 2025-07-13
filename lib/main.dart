import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';

import 'core/app_config.dart';
import 'services/auth_service.dart';
import 'services/oss_service.dart';
import 'providers/theme_provider.dart';
import 'providers/locale_provider.dart';
import 'pages/splash_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/windows_login_page.dart';
import 'pages/home_page.dart';
import 'common/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化Windows窗口管理器
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1200, 800),
      minimumSize: Size(800, 600),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  // 初始化OSS服务
  await OssService.instance.initialize();

  runApp(
    ProviderScope(
      child: const BBXYApp(),
    ),
  );
}

class BBXYApp extends ConsumerWidget {
  const BBXYApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.primaryColor,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppConfig.primaryColor,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,
      locale: locale,
      home: Platform.isWindows ? const WindowsAppWrapper() : const SplashPage(),
    );
  }
}

class WindowsAppWrapper extends ConsumerWidget {
  const WindowsAppWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WindowManagerWrapper(
      child: const AppRouter(),
    );
  }
}

class AppRouter extends ConsumerStatefulWidget {
  const AppRouter({super.key});

  @override
  ConsumerState<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends ConsumerState<AppRouter> {
  bool _isInitialized = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // 检查登录状态
      final authService = AuthService.instance;
      final isLoggedIn = await authService.isLoggedIn();

      setState(() {
        _isLoggedIn = isLoggedIn;
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('初始化应用失败: $e');
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SplashPage();
    }

    // Windows平台使用专用登录页面
    return _isLoggedIn
        ? const HomePage()
        : (Platform.isWindows ? const WindowsLoginPage() : const LoginPage());
  }
}
