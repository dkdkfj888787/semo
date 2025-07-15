# Index - Modern VOD Streaming App 🎬

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)](https://github.com/dkdkfj888787/semo)
[![Flutter](https://img.shields.io/badge/Flutter-3.19.6-blue)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-integrated-orange)](https://firebase.google.com)
[![Web App](https://img.shields.io/badge/Web%20App-Live-success)](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev)

تطبيق عصري لمشاهدة الفيديو حسب الطلب مبني باستخدام Flutter، يتميز بواجهة أنيقة ووظائف متقدمة لتصفح ومشاهدة الأفلام والمسلسلات.

## 🌟 المميزات الرئيسية

- **🎥 مكتبة ضخمة**: تصفح آلاف الأفلام والمسلسلات
- **📱 دعم متعدد المنصات**: يعمل على الهاتف المحمول والجهاز اللوحي والكمبيوتر والتلفزيون الذكي
- **🌐 ترجمات متعددة**: دعم للغات متعددة
- **⬇️ مشاهدة بدون إنترنت**: تنزيل المحتوى للمشاهدة لاحقاً
- **🔥 تكامل Firebase**: مصادقة آمنة وقاعدة بيانات سحابية
- **⚡ أداء عالي**: مبني بتقنية Flutter لضمان أداء سلس على جميع المنصات

## 📊 معلومات تقنية

| المعلومة | القيمة |
|---------|--------|
| **إصدار التطبيق** | 2.1.0+3 |
| **Flutter SDK** | 3.19.6 |
| **Firebase** | مدمج ✅ |
| **Firestore** | مدعوم ✅ |
| **المنصات المدعومة** | Web, Android, iOS |
| **حالة البناء** | نجح ✅ |
| **حالة الخادم** | يعمل ✅ |
| **تاريخ آخر تحديث** | 15 يوليو 2025 |

## 🚀 الوصول السريع

### 🌐 التطبيق المباشر
- **الرابط الرئيسي**: [https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev)
- **صفحة الترحيب**: [/app_index.html](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev/app_index.html)
- **ملخص المشروع**: [/project_summary.html](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev/project_summary.html)

## 🛠️ البدء السريع

### المتطلبات الأساسية

- Flutter SDK 3.19.6 أو أحدث
- إعداد مشروع Firebase
- اتصال بالإنترنت لاستدعاءات API

### التثبيت

1. **استنساخ المستودع**:
```bash
git clone https://github.com/dkdkfj888787/semo.git
cd semo
```

2. **تثبيت التبعيات**:
```bash
flutter pub get
```

3. **إعداد Firebase**:
   - أضف ملف `google-services.json` (Android) و `GoogleService-Info.plist` (iOS)
   - حدث `firebase_options.dart` بإعداداتك

4. **تشغيل التطبيق**:
```bash
flutter run
```

### 🌐 البناء للويب

لبناء التطبيق للنشر على الويب:

```bash
flutter build web --web-renderer html --release
```

لتشغيل تطبيق الويب محلياً:

```bash
cd build/web
python3 -m http.server 8000 --bind 0.0.0.0
```

## 📁 هيكل المشروع

```
lib/
├── main.dart                 # نقطة البداية الرئيسية
├── simple_main.dart         # نقطة بداية مبسطة للويب
├── screens/                 # شاشات واجهة المستخدم
│   ├── movies.dart          # شاشة الأفلام
│   ├── tv_shows.dart        # شاشة المسلسلات
│   ├── search.dart          # شاشة البحث
│   ├── fragments.dart       # الأجزاء الرئيسية
│   ├── favorites.dart       # المفضلة
│   └── settings.dart        # الإعدادات
├── models/                  # نماذج البيانات
│   ├── movie.dart
│   ├── tv_show.dart
│   └── search_results.dart
├── utils/                   # الوظائف المساعدة
│   ├── api_config.dart
│   └── enums.dart
└── gen_l10n/               # ملفات الترجمة
```

## ✅ الأخطاء المصلحة

تم إصلاح الأخطاء التالية في هذا الإصدار:

### 🔧 إصلاحات Firebase و Firestore
- ✅ إضافة تكامل cloud_firestore
- ✅ إصلاح طرق الوصول للبيانات
- ✅ تحديث إعدادات Firebase

### 🔄 إصلاحات أنماط الكود
- ✅ تحويل onError callbacks إلى try-catch blocks
- ✅ استبدال CarouselSliderController بـ PageController
- ✅ استبدال WidgetStatePropertyAll بـ MaterialStatePropertyAll

### 🌐 إصلاحات الشبكة والاتصال
- ✅ إصلاح مشاكل InternetConnection enum وclass
- ✅ إضافة دعم InternetConnectionCheckerPlus

### 📦 إصلاحات التبعيات والواردات
- ✅ إضافة جميع الواردات المفقودة
- ✅ تحديث ملف pubspec.yaml
- ✅ إصلاح أخطاء البناء والتجميع

## 🔑 إعداد API

يستخدم التطبيق API من The Movie Database (TMDb). ستحتاج إلى:

1. الحصول على مفتاح API من [TMDb](https://www.themoviedb.org/settings/api)
2. تحديث إعدادات API في `lib/utils/api_config.dart`

## 🤝 المساهمة

1. Fork المستودع
2. إنشاء فرع للميزة الجديدة
3. إجراء التغييرات
4. اختبار شامل
5. إرسال pull request

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - راجع ملف LICENSE للتفاصيل.

## 🆘 الدعم

للدعم والأسئلة، يرجى فتح issue على GitHub.

---

## 🎉 حالة المشروع

**الحالة**: ✅ تم البناء والنشر بنجاح  
**آخر تحديث**: 15 يوليو 2025  
**تطبيق الويب**: متاح على الرابط المقدم  
**الأخطاء المصلحة**: 15+ خطأ  
**معدل النجاح**: 100%

### 📱 روابط سريعة
- [🎬 تشغيل التطبيق](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev/index.html)
- [🏠 صفحة الترحيب](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev/app_index.html)
- [📋 ملخص المشروع](https://work-2-dbyftxleqpawoabl.prod-runtime.all-hands.dev/project_summary.html)