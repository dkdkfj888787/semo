# دليل المطور - Index Flutter App

## حالة المشروع الحالية

تم إصلاح معظم المشاكل الأساسية في المشروع. إليك الوضع الحالي:

### ✅ المشاكل المحلولة

1. **ملفات Firebase المفقودة**
   - تم إنشاء `lib/firebase_options.dart`
   - تم إنشاء `android/app/google-services.json`

2. **نظام الترجمة (Localization)**
   - تم إنشاء ملفات ARB: `lib/l10n/app_en.arb` و `lib/l10n/app_ar.arb`
   - تم إنشاء ملفات الترجمة المولدة في `lib/gen_l10n/`
   - تم إصلاح جميع مسارات الاستيراد

3. **إعدادات Android**
   - تم تحديث package names من `net.examnet.semo` إلى `com.voxin.index`
   - تم نقل `MainActivity.java` إلى المجلد الصحيح
   - تم إنشاء ملفات التكوين المطلوبة

4. **تحسينات عامة**
   - تم تحديث `analysis_options.yaml` لتجنب التحذيرات
   - تم إضافة `flutter_lints` إلى dependencies

### ⚠️ المشاكل المتبقية

1. **Flutter SDK Setup**
   - المشكلة: Flutter SDK يواجه مشاكل صلاحيات عند التشغيل كـ root
   - الحل: تشغيل Flutter في بيئة عادية (non-root)

## خطوات الإعداد للمطور

### 1. إعداد البيئة المحلية

```bash
# تأكد من تثبيت Flutter
flutter doctor

# انتقل إلى مجلد المشروع
cd /path/to/semo

# تثبيت dependencies
flutter pub get

# توليد ملفات الترجمة (إذا لزم الأمر)
flutter gen-l10n
```

### 2. إعداد Firebase (للإنتاج)

#### Android
1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. أنشئ مشروع جديد أو استخدم مشروع موجود
3. أضف تطبيق Android بـ package name: `com.voxin.index`
4. حمل ملف `google-services.json` واستبدل الموجود في `android/app/`
5. حدث `lib/firebase_options.dart` بالقيم الحقيقية

#### iOS (إذا لزم الأمر)
1. أضف تطبيق iOS في Firebase Console
2. حمل ملف `GoogleService-Info.plist`
3. أضفه إلى مجلد `ios/Runner/`

### 3. إعداد API Keys

#### TMDB API
```dart
// في lib/utils/api_config.dart أو ملف مشابه
class ApiConfig {
  static const String tmdbApiKey = 'YOUR_TMDB_API_KEY';
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
}
```

#### SubDL API (إذا لزم الأمر)
```dart
class ApiConfig {
  static const String subdlApiKey = 'YOUR_SUBDL_API_KEY';
  static const String subdlBaseUrl = 'https://api.subdl.com';
}
```

### 4. تشغيل التطبيق

```bash
# للتطوير
flutter run

# لبناء APK للاختبار
flutter build apk --debug

# لبناء APK للإنتاج
flutter build apk --release
```

## هيكل الملفات المهمة

```
lib/
├── firebase_options.dart          # تكوين Firebase (محدث)
├── gen_l10n/                     # ملفات الترجمة المولدة (جديد)
│   ├── app_localizations.dart
│   ├── app_localizations_en.dart
│   └── app_localizations_ar.dart
├── l10n/                         # ملفات ARB للترجمة (جديد)
│   ├── app_en.arb
│   └── app_ar.arb
├── main.dart                     # محدث - إصلاح مسارات الاستيراد
└── screens/                      # محدث - إصلاح مسارات الاستيراد
    ├── splash.dart
    ├── fragments.dart
    ├── company_info.dart
    ├── settings.dart
    └── landing.dart

android/
├── app/
│   ├── google-services.json      # تكوين Firebase (جديد)
│   ├── build.gradle             # محدث - package names
│   └── src/main/java/com/voxin/index/
│       └── MainActivity.java    # منقول ومحدث
├── local.properties             # جديد
└── key.properties              # جديد

analysis_options.yaml              # محدث
pubspec.yaml                       # محدث - إضافة flutter_lints
```

## نصائح للتطوير

### 1. إضافة نصوص ترجمة جديدة

1. أضف النص في `lib/l10n/app_en.arb`:
```json
{
  "newText": "New Text",
  "@newText": {
    "description": "Description of the new text"
  }
}
```

2. أضف الترجمة العربية في `lib/l10n/app_ar.arb`:
```json
{
  "newText": "نص جديد"
}
```

3. شغل `flutter gen-l10n` لتوليد الملفات
4. استخدم النص في الكود:
```dart
Text(AppLocalizations.of(context)!.newText)
```

### 2. إضافة شاشات جديدة

1. أنشئ ملف جديد في `lib/screens/`
2. استورد ملف الترجمة:
```dart
import '../gen_l10n/app_localizations.dart';
```

3. استخدم الترجمة:
```dart
final l10n = AppLocalizations.of(context)!;
```

### 3. إضافة models جديدة

أنشئ ملفات في `lib/models/` مع factory constructors للـ JSON:

```dart
class NewModel {
  final int id;
  final String name;

  NewModel({required this.id, required this.name});

  factory NewModel.fromJson(Map<String, dynamic> json) {
    return NewModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
```

## استكشاف الأخطاء

### مشاكل شائعة وحلولها

1. **خطأ في مسارات الاستيراد**
   - تأكد من استخدام `../gen_l10n/app_localizations.dart`

2. **مشاكل Firebase**
   - تأكد من وجود `google-services.json` في المكان الصحيح
   - تأكد من تطابق package name في جميع الملفات

3. **مشاكل الترجمة**
   - شغل `flutter gen-l10n` بعد تحديث ملفات ARB
   - تأكد من وجود `generate: true` في `pubspec.yaml`

4. **مشاكل Android Build**
   - تأكد من تطابق package names في جميع ملفات Android
   - تأكد من وجود `local.properties` و `key.properties`

## الخطوات التالية

1. **إعداد Flutter SDK في بيئة مناسبة**
2. **تشغيل `flutter pub get`**
3. **اختبار التطبيق على جهاز أو محاكي**
4. **إضافة API keys الحقيقية**
5. **اختبار جميع الميزات**

## ملاحظات مهمة

- جميع الملفات المنشأة تحتوي على قيم وهمية للتطوير
- يجب استبدال تكوين Firebase بالقيم الحقيقية للإنتاج
- تم إصلاح معظم مشاكل الكود، المتبقي هو إعداد البيئة فقط

---

**تم إنجاز هذا الدليل بواسطة OpenHands AI Assistant**