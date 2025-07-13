# 🚀 BBXYApp - 基于 FlClash 的 SSPanel 四端代理管理应用

## 📋 项目概述

**BBXYApp** 是基于 [FlClash](https://github.com/chen08209/FlClash) 底层架构开发的四端（Android／iOS／Windows／macOS）SSPanel 代理管理应用。项目深度集成了 FlClash 的跨平台代理客户端功能和 SSPanel API 系统，提供完整的商业化代理服务解决方案。

### 🎯 项目目标
- 以 FlClash 为底层代理核心
- 完整集成 SSPanel API 功能
- 提供统一的四端用户体验
- 支持商业化运营需求

## 🏗️ 技术架构

### 核心架构
- **底层引擎**: FlClash (ClashMeta 核心)
- **前端框架**: Flutter 跨平台开发
- **后端集成**: SSPanel API 完整集成
- **状态管理**: Riverpod + 自定义状态层
- **数据持久化**: SQLite + SharedPreferences

### API 集成层
- **SSPanel API**: 完整的用户管理、订阅、支付 API
- **代理层**: 统一的 API 适配和缓存机制
- **配置中心**: 动态配置管理和热更新
- **安全层**: 请求加密、签名验证、防重放

## 🔧 核心功能模块

### 1. 用户系统 (集成 SSPanel)
- **用户注册**: 邮箱验证、邀请码系统
- **用户登录**: 密码认证、二步验证、Telegram 登录
- **个人中心**: 用户信息、流量统计、到期时间
- **会话管理**: 自动登录、多设备管理

### 2. 订阅管理 (基于 SSPanel)
- **订阅获取**: 动态获取用户订阅链接
- **节点解析**: 支持 SS/SSR/V2Ray/Trojan/Clash 协议
- **自动更新**: 定时更新节点信息
- **节点筛选**: 按地区、类型、延迟筛选

### 3. 代理功能 (FlClash 核心)
- **代理启动**: 一键启动/停止代理
- **模式切换**: 全局/规则/直连模式
- **规则管理**: 自定义代理规则
- **流量监控**: 实时流量统计和历史记录

### 4. 商业功能 (SSPanel 集成)
- **套餐购买**: 流量包、会员套餐购买
- **钱包系统**: 余额充值、消费记录
- **签到奖励**: 每日签到获取流量
- **邀请返利**: 邀请好友获得奖励

### 5. OSS 功能 (自动域名选择)
- **域名检测**: 自动检测多个域名延迟
- **最佳选择**: 自动选择延迟最小的可用域名
- **定时检测**: 定期检测域名状态
- **缓存机制**: 本地缓存最佳域名

## 📁 项目结构

```
bbxyapp/
├── README.md                   # 项目说明文档
├── pubspec.yaml               # Flutter 配置
├── .github/                   # GitHub 配置
│   └── workflows/             # CI/CD 配置
├── lib/                       # Flutter 主要代码
│   ├── main.dart              # 应用入口
│   ├── core/                  # 核心模块
│   │   └── app_config.dart    # 应用配置
│   ├── models/                # 数据模型
│   │   └── user.dart          # 用户模型
│   ├── providers/             # 状态管理
│   │   ├── theme_provider.dart # 主题提供者
│   │   └── locale_provider.dart # 语言提供者
│   ├── services/              # 业务服务
│   │   ├── auth_service.dart  # 认证服务
│   │   └── oss_service.dart   # OSS 服务
│   ├── pages/                 # 页面组件
│   │   ├── splash_page.dart   # 启动页面
│   │   ├── auth/              # 认证页面
│   │   │   ├── login_page.dart # 登录页面
│   │   │   └── register_page.dart # 注册页面
│   │   └── home/              # 主页
│   │       └── home_page.dart # 主页面
│   └── l10n/                  # 国际化
│       └── app_localizations.dart # 本地化
└── android/                   # Android 平台配置
    └── app/
        ├── build.gradle       # Android 构建配置
        └── src/main/
            └── AndroidManifest.xml # Android 权限配置
```

## 🌐 OSS 域名配置

### 支持的域名列表
- `https://bbxy.xn--cesw6hd3s99f.com` (国内入口1)
- `https://cn1.cardsakura.buzz` (国外入口1)
- `https://cn1.bbxy.fun` (国外入口2)
- `https://bbxy.buzz` (仅国外可访问永久入口)

### 域名发布页面
- `https://bbxy88.com`
- `https://bbxy88.top`
- `https://bbxy88.xyz`

### OSS 功能特性
- **智能选择**: 自动检测延迟最小的域名
- **故障转移**: 自动切换到可用域名
- **定时检测**: 每5分钟检测一次域名状态
- **本地缓存**: 缓存最佳域名避免重复检测

## 🔌 SSPanel API 集成

### 认证 API 集成
```dart
// 用户登录
POST /auth/login
{
  "email": "user@example.com",
  "password": "password",
  "2fa_code": "123456"
}

// 用户注册
POST /auth/register
{
  "email": "user@example.com",
  "password": "password",
  "invite_code": "INVITE123"
}
```

### 用户信息 API
```dart
// 获取用户信息
GET /user/profile

// 获取订阅信息
GET /user/subscription

// 每日签到
POST /user/checkin
```

### 节点订阅 API
```dart
// 获取订阅链接
GET /user/subscription/link

// 获取节点列表
GET /nodes/list

// 获取 Clash 配置
GET /user/clash/config
```

## 🛠️ 开发环境设置

### 环境要求
- Flutter SDK >= 3.19.0
- Dart SDK >= 3.0.0
- Android SDK (Android 开发)
- Xcode (iOS 开发)
- Visual Studio (Windows 开发)

### 快速开始
```bash
# 克隆仓库
git clone https://github.com/[username]/bbxyapp.git
cd bbxyapp

# 安装依赖
flutter pub get

# 运行应用 (调试模式)
flutter run

# 构建发布版本
flutter build apk          # Android
flutter build ios          # iOS
flutter build windows      # Windows
flutter build macos        # macOS
```

## 🚀 GitHub Actions 部署

### 自动化构建
项目使用 GitHub Actions 进行自动化构建，支持：
- **多平台构建**: Android、iOS、Windows、macOS
- **自动发布**: 推送标签时自动创建 Release
- **构建缓存**: 优化构建速度
- **并行构建**: 多平台同时构建

### 构建触发条件
- 推送到 `main` 或 `develop` 分支
- 创建 Pull Request 到 `main` 分支
- 发布 Release 时自动构建和发布

## 📊 开发进度

### ✅ 已完成
- [x] 项目架构设计
- [x] GitHub Actions 工作流配置
- [x] Android 平台配置
- [x] OSS 域名选择服务
- [x] 用户认证服务架构
- [x] 登录注册页面 UI
- [x] 主页面框架
- [x] 应用配置管理

### 🔄 开发中
- [ ] 完善用户认证功能
- [ ] 实现 SSPanel API 集成
- [ ] FlClash 核心集成
- [ ] 节点管理功能
- [ ] 代理功能实现

### 📋 待开发
- [ ] 商店购买功能
- [ ] 支付系统集成
- [ ] 签到奖励系统
- [ ] 邀请返利功能
- [ ] 多语言支持
- [ ] 主题系统
- [ ] 性能优化
- [ ] 单元测试

## 🔐 安全特性

### API 安全
- HTTPS 强制加密
- JWT Token 认证
- 请求签名验证
- 防重放攻击
- 访问频率限制

### 数据安全
- 本地数据加密存储
- 敏感信息内存保护
- 安全的密钥管理
- 用户数据隐私保护

## 🤝 贡献指南

### 开发流程
1. Fork 项目到个人仓库
2. 创建功能分支: `git checkout -b feature/new-feature`
3. 提交代码: `git commit -m 'Add new feature'`
4. 推送分支: `git push origin feature/new-feature`
5. 创建 Pull Request

### 代码规范
- 遵循 Dart 官方代码风格
- 使用 `dart format` 格式化代码
- 运行 `dart analyze` 检查代码质量
- 编写必要的测试用例

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 📞 联系方式

- **GitHub**: https://github.com/[username]/bbxyapp
- **Issues**: https://github.com/[username]/bbxyapp/issues
- **Discussions**: https://github.com/[username]/bbxyapp/discussions

---

## 🎯 快速体验

### 开发版本体验
```bash
# 克隆项目
git clone https://github.com/[username]/bbxyapp.git

# 进入项目目录
cd bbxyapp

# 安装依赖
flutter pub get

# 运行调试版本
flutter run
```

### 配置 SSPanel 后端
1. 确保您有可用的 SSPanel 后端服务
2. 修改 `lib/core/app_config.dart` 中的 API 地址
3. 配置必要的认证信息

**注意**: 本项目正在积极开发中，当前版本为初始架构版本。欢迎提交 Issue 和 Pull Request！

### 🔄 当前状态
- **版本**: v1.0.0 (开发中)
- **状态**: 架构搭建完成，正在实现核心功能
- **平台**: Android 优先，其他平台后续跟进

---

**⭐ 如果这个项目对您有帮助，请给个 Star 支持一下！** 