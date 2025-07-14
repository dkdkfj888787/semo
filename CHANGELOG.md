# Changelog

All notable changes to the Index project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2024-12-16

### 🎉 Major Release - Complete App Transformation

This release represents a complete transformation of the application from "Semo" to "Index" with modern features and improved user experience.

### ✨ Added
- **Guest Mode Authentication**: Removed Google Sign-In dependency, users can now access the app instantly as guests
- **Multi-language Support**: Added Arabic and English localization with RTL support
- **Company Information Section**: Added dedicated section for Voxin company information
- **Modern UI Components**: Updated all UI components with latest Material Design 3
- **API Integration**: Integrated TMDB API for movies/TV shows and SubDL API for subtitles
- **GitHub Actions CI/CD**: Automated APK building and release pipeline
- **Language Manager**: Centralized language management system
- **Local Storage**: Guest mode data persistence using SharedPreferences

### 🔄 Changed
- **App Name**: Changed from "Semo" to "Index"
- **Package Name**: Updated to `com.voxin.index`
- **App Version**: Bumped to 2.0.0+2
- **Flutter Version**: Updated to 3.24.0
- **Dependencies**: Updated all dependencies to latest stable versions
- **Authentication Flow**: Replaced Google authentication with guest mode
- **Navigation**: Updated navigation to support language changes
- **Theme**: Enhanced dark theme with modern color scheme

### 🗑️ Removed
- **Google Sign-In**: Removed Google authentication dependency
- **Firebase Auth**: Removed Firebase authentication (kept Analytics and Remote Config)
- **User Account Management**: Removed account deletion and user profile features
- **Cloud Firestore**: Removed cloud data storage (replaced with local storage)

### 🔧 Technical Improvements
- **Localization**: Added `flutter_localizations` and `intl` packages
- **Code Structure**: Reorganized code with better separation of concerns
- **Import Statements**: Updated all import statements from `semo` to `index`
- **Build Configuration**: Updated Android build configuration
- **API Configuration**: Centralized API keys management
- **Error Handling**: Improved error handling for guest mode

### 🌍 Localization
- **English (en)**: Default language with complete translations
- **Arabic (ar)**: Full Arabic translation with RTL support
- **Dynamic Language Switching**: Users can change language from settings

### 🏢 Company Branding
- **Developer**: Voxin
- **Founded**: 2020
- **Development Started**: 2021
- **Specialization**: Powerful mobile applications development

### 🔑 API Keys Integration
- **TMDB API**: `eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYTc2MDk3MTlhNTYxYjM0MWM4MDYyYzMzN2FiZTM5NyIsIm5iZiI6MTc0NDI5MzUwOC4xMDQsInN1YiI6IjY3ZjdjZTg0MzE3NzUyNzZkNmQ5OTM4OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jB-LdCFKnX7xETXv3UgAHXffgoCOFK9wfyr6Z8y4AzI`
- **SubDL API**: `l0cgAb7VNM_KMN2KwkLCFNuRsk8q3tEg` (Arabic subtitles)

### 📱 Platform Support
- **Android**: Minimum SDK 23, Target SDK 34
- **Compile SDK**: 34
- **Build Tools**: Latest Gradle and Android build tools

### 🚀 CI/CD Pipeline
- **Automated Building**: GitHub Actions workflow for APK building
- **Release Management**: Automatic release creation with artifacts
- **Version Tagging**: Semantic versioning with build numbers
- **Multi-platform Support**: Ready for future iOS support

### 🐛 Bug Fixes
- Fixed navigation issues with language changes
- Resolved authentication flow problems
- Fixed import statement inconsistencies
- Corrected theme application across all screens
- Fixed RTL layout issues for Arabic language

### 📚 Documentation
- **README**: Complete rewrite with modern documentation
- **CHANGELOG**: Added comprehensive changelog
- **Code Comments**: Improved code documentation
- **API Documentation**: Added API configuration documentation

### 🔒 Security
- **Guest Mode**: Secure local data storage
- **API Keys**: Proper API key management
- **Permissions**: Minimal required permissions

### 🎯 Performance
- **App Size**: Optimized app size by removing unnecessary dependencies
- **Startup Time**: Improved app startup time with guest mode
- **Memory Usage**: Reduced memory footprint
- **Network Efficiency**: Optimized API calls

---

## [1.x.x] - Previous Versions

Previous versions were released under the name "Semo" with Google authentication and Firebase integration. This changelog starts from version 2.0.0 which represents the complete transformation to "Index".

---

**Note**: This version represents a complete rewrite and modernization of the application. Users upgrading from previous versions will need to reinstall the app due to package name changes.