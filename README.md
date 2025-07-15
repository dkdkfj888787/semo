# Index - Modern VOD Streaming App

<div align="center">
  <img src="assets/icon.png" alt="Index Logo" width="120" height="120">
  
  [![Build APK](https://github.com/uiopooi/semo/actions/workflows/build-apk.yml/badge.svg)](https://github.com/uiopooi/semo/actions/workflows/build-apk.yml)
  [![Flutter](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev/)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

## 📱 About

**Index** is a modern Video-on-Demand (VOD) streaming application developed by **Voxin**. The app provides seamless access to movies and TV shows with multi-language support and guest mode functionality.

### 🏢 Company Information
- **Developer**: Voxin
- **Founded**: 2020
- **Development Started**: 2021
- **Release Date**: TBA
- **Specialization**: Powerful mobile applications development

## ✨ Features

### 🎯 Core Features
- 🎬 **Movies & TV Shows**: Browse extensive library of content
- 🔍 **Smart Search**: Find your favorite content quickly
- ❤️ **Favorites**: Save and organize your preferred content
- 📱 **Guest Mode**: No authentication required - instant access
- 🌍 **Multi-language**: Arabic and English support with RTL
- 🎨 **Modern UI**: Clean, intuitive interface
- 📺 **Subtitle Support**: Integrated subtitle system

### 🔧 Technical Features
- 🚀 **Latest Flutter**: Built with Flutter 3.24.0
- 🎯 **TMDB Integration**: Real-time movie and TV show data
- 📝 **SubDL Integration**: Subtitle support with Arabic language
- 💾 **Local Storage**: Guest mode with local data persistence
- 🔄 **Auto Updates**: GitHub Actions CI/CD pipeline

## 🚀 Getting Started

### Prerequisites
- Flutter 3.24.0 or higher
- Dart SDK 3.5.0 or higher
- Android Studio / VS Code
- Android SDK (for Android builds)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/uiopooi/semo.git
   cd semo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate localization files**
   ```bash
   flutter gen-l10n
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release
```

## 📱 Download

[![Download APK](https://custom-icon-badges.demolab.com/badge/-Download%20APK-F25278?style=for-the-badge&logo=download&logoColor=white&color=AB261D)](https://github.com/uiopooi/semo/releases)

## 🌐 Localization

The app supports multiple languages:

- **English** (en) - Default
- **Arabic** (ar) - RTL support

### Adding New Languages

1. Add new `.arb` file in `lib/l10n/`
2. Update `l10n.yaml` configuration
3. Run `flutter gen-l10n`

## 🔑 API Configuration

The app uses the following APIs:

### TMDB API
- **Purpose**: Movie and TV show data
- **Configuration**: `lib/utils/api_config.dart`

### SubDL API
- **Purpose**: Subtitle integration
- **Language**: Arabic subtitles support
- **Configuration**: `lib/utils/api_config.dart`

## 📁 Project Structure

```
lib/
├── l10n/                 # Localization files
├── models/               # Data models
├── screens/              # UI screens
├── utils/                # Utilities and helpers
├── widgets/              # Reusable widgets
└── main.dart            # App entry point
```

## 🔄 CI/CD

The project includes GitHub Actions workflow for:
- ✅ Automated APK building
- ✅ Release creation
- ✅ Artifact upload
- ✅ Multi-platform support

## 🎨 Theming

The app features a dark theme with:
- **Primary Color**: `#AB261D` (Red)
- **Background**: `#120201` (Dark)
- **Cards**: `#250604` (Dark Red)
- **Typography**: Freckle Face font

## 🏢 About Voxin

**Voxin** is a technology company specializing in powerful mobile application development. Founded in 2020, we focus on creating innovative solutions that enhance user experience and provide seamless digital entertainment.

### Our Mission
To develop cutting-edge applications that bring entertainment and technology together, making digital content accessible to everyone.

## 📞 Support

For support and inquiries:
- 📧 Email: support@voxin.com
- 🌐 Website: [voxin.com](https://voxin.com)
- 📱 GitHub: [@uiopooi](https://github.com/uiopooi)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- TMDB for providing movie and TV show data
- SubDL for subtitle services
- Open source community for various packages used

---

<div align="center">
  <p>Made with ❤️ by <strong>Voxin</strong></p>
  <p>© 2024 Voxin. All rights reserved.</p>
</div>
