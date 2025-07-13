# BBXYApp

## 📱 项目简介

BBXYApp 是一个基于 FlClash 重写的 SSPanel 四端代理管理应用，支持 Android、iOS、Windows、macOS 四个平台。项目采用 Flutter 框架开发，集成了 SSPanel 后端 API，提供完整的代理服务管理功能。

## ✨ 主要特性

### 🌟 核心功能
- **多平台支持**: Android、iOS、Windows、macOS 四端统一体验
- **SSPanel 集成**: 完整的 SSPanel 后端 API 对接
- **FlClash 内核**: 基于 FlClash 的代理核心，稳定可靠
- **用户认证**: 完整的用户登录、注册、找回密码功能
- **节点管理**: 支持多节点管理和自动选择最优节点
- **流量统计**: 实时流量监控和使用统计
- **订阅管理**: 支持多订阅源管理和自动更新

### 🎨 用户界面
- **Material Design 3**: 现代化的 UI 设计
- **多主题支持**: 浅色/深色主题切换
- **响应式设计**: 适配不同屏幕尺寸
- **Windows 专用界面**: 针对 Windows 平台优化的登录界面

### 🔧 技术特性
- **OSS 域名自动选择**: 4个域名自动选择最优连接
- **状态管理**: 使用 Riverpod 进行状态管理
- **本地存储**: SharedPreferences 数据持久化
- **网络请求**: Dio HTTP 客户端
- **代码生成**: 使用 build_runner 自动生成代码

## 🏗️ 项目架构

```
lib/
├── core/                   # 核心配置
│   └── app_config.dart    # 应用配置
├── services/              # 服务层
│   ├── auth_service.dart  # 认证服务
│   └── oss_service.dart   # OSS服务
├── models/                # 数据模型
│   └── user.dart         # 用户模型
├── providers/             # 状态管理
│   ├── theme_provider.dart
│   └── locale_provider.dart
├── pages/                 # 页面
│   ├── splash_page.dart   # 启动页
│   ├── auth/             # 认证页面
│   │   ├── login_page.dart
│   │   ├── windows_login_page.dart
│   │   └── register_page.dart
│   └── home_page.dart     # 主页
├── common/               # 通用组件
│   └── window_manager.dart
└── main.dart             # 应用入口
```

## 🚀 快速开始

### 环境要求
- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code
- Git

### 安装依赖
```bash
flutter pub get
```

### 代码生成
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 运行应用

#### Android
```bash
flutter run -d android
```

#### Windows
```bash
flutter run -d windows
```

#### macOS
```bash
flutter run -d macos
```

#### iOS
```bash
flutter run -d ios
```

## 🔧 配置说明

### OSS 域名配置
项目支持 4 个 OSS 域名自动选择：
- `api1.baibianxiaoying.top`
- `api2.baibianxiaoying.top`
- `api3.baibianxiaoying.top`
- `api4.baibianxiaoying.top`

### 主题配置
- 支持浅色/深色主题
- 支持 Material Design 3
- 自定义主色调

## 📦 构建发布

### GitHub Actions 自动构建
项目配置了完整的 GitHub Actions 工作流，支持：
- 多平台自动构建 (Android/Windows/macOS/Linux)
- 自动发布到 GitHub Releases
- 生成 SHA256 校验和
- 自动生成发布说明

### 手动构建

#### Android APK
```bash
flutter build apk --release --split-per-abi
```

#### Windows 应用
```bash
flutter build windows --release
```

#### macOS 应用
```bash
flutter build macos --release
```

## 🔐 安全特性

### 认证安全
- 安全的密码存储
- Token 自动刷新
- 会话管理

### 网络安全
- HTTPS 加密传输
- 证书验证
- 请求签名

## 🛠️ 开发指南

### 代码规范
- 使用 `flutter_lints` 进行代码检查
- 遵循 Dart 官方编码规范
- 使用 `build_runner` 生成代码

### 状态管理
项目使用 Riverpod 进行状态管理：
```dart
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);
```

### 服务调用
```dart
final authService = AuthService.instance;
final user = await authService.login(email, password);
```

## 📱 平台特性

### Windows 平台
- 自定义窗口标题栏
- 窗口管理功能
- 系统托盘支持
- 专用登录界面

### Android 平台
- VPN 服务集成
- 系统代理设置
- 后台服务支持

### macOS 平台
- 原生窗口管理
- 系统菜单集成
- 权限管理

## 🔄 更新日志

### v1.0.0 (2025-01-XX)
- ✨ 初始版本发布
- 🎯 完整的 SSPanel 集成
- 🖥️ Windows 专用登录界面
- 📱 四端统一体验
- 🔧 OSS 域名自动选择
- 🎨 Material Design 3 界面

## 🤝 贡献指南

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 联系我们

- 项目主页: https://github.com/annabeautiful1/bbxyapp
- 问题反馈: https://github.com/annabeautiful1/bbxyapp/issues
- 邮箱: support@baibianxiaoying.top

## 🙏 致谢

- [FlClash](https://github.com/chen08209/FlClash) - 提供了优秀的代理客户端基础
- [SSPanel](https://github.com/Anankke/SSPanel-Uim) - 提供了完整的后端管理系统
- [Flutter](https://flutter.dev/) - 跨平台开发框架

---

⭐ 如果这个项目对您有帮助，请给我们一个 Star！ 