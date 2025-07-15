# الأخطاء التي تم إصلاحها

هذا الملف يوثق الأخطاء التي تم إصلاحها في مشروع Index VOD Streaming App.

## الأخطاء الرئيسية

### 1. أنواع الإرجاع المفقودة

تم إضافة أنواع الإرجاع المفقودة في العديد من الدوال، مثل:

- `Future<void>` للدوال غير المتزامنة التي لا ترجع قيمة
- `void` للدوال المتزامنة التي لا ترجع قيمة

### 2. مشكلة في فئة Fragments

تم إصلاح مشكلة في فئة Fragments حيث كانت الخصائص غير نهائية في فئة غير قابلة للتغيير. تم إضافة كلمة `final` للخصائص.

```dart
// قبل
class Fragments extends StatefulWidget {
  String title;
  int currentIndex;
  
  Fragments({required this.title, required this.currentIndex});
  
  // ...
}

// بعد
class Fragments extends StatefulWidget {
  final String title;
  final int currentIndex;
  
  Fragments({required this.title, required this.currentIndex});
  
  // ...
}
```

### 3. تحسين SubtitleStyle.fromJson

تم تحسين طريقة `SubtitleStyle.fromJson` للتعامل مع JSON فارغ:

```dart
// قبل
factory SubtitleStyle.fromJson(Map<String, dynamic> json) {
  return SubtitleStyle(
    fontSize: json['fontSize'],
    fontColor: json['fontColor'],
    backgroundColor: json['backgroundColor'],
    // ...
  );
}

// بعد
factory SubtitleStyle.fromJson(Map<String, dynamic> json) {
  if (json.isEmpty) {
    return SubtitleStyle.defaultStyle();
  }
  
  return SubtitleStyle(
    fontSize: json['fontSize'] ?? 16.0,
    fontColor: json['fontColor'] ?? 'FFFFFF',
    backgroundColor: json['backgroundColor'] ?? '000000',
    // ...
  );
}
```

### 4. إضافة const constructor لـ IndexApp

تم إضافة `const` constructor لـ IndexApp لتحسين الأداء:

```dart
// قبل
return IndexApp();

// بعد
return const IndexApp();
```

### 5. إصلاح أسماء الطرق في landing.dart

تم إصلاح أسماء الطرق في landing.dart لاتباع اصطلاحات التسمية في Dart (الحرف الأول صغير):

```dart
// قبل
void Navigate() {
  // ...
}

// بعد
void navigate() {
  // ...
}
```

## إضافات جديدة

### 1. دعم Firestore

تم إضافة دعم Firestore للاستخدام المستقبلي:

1. إضافة تبعية cloud_firestore إلى pubspec.yaml
2. إنشاء فئة FirestoreService للتعامل مع قاعدة البيانات
3. إنشاء نموذج User للتكامل مع Firestore
4. إنشاء UserRepository للتعامل مع بيانات المستخدم
5. تحديث تهيئة Firebase لتكوين Firestore

```dart
// FirestoreService
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  Future<void> addDocument(String collection, Map<String, dynamic> data) async {
    await _firestore.collection(collection).add(data);
  }
  
  Future<void> updateDocument(String collection, String documentId, Map<String, dynamic> data) async {
    await _firestore.collection(collection).doc(documentId).update(data);
  }
  
  Future<void> deleteDocument(String collection, String documentId) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }
  
  Future<DocumentSnapshot> getDocument(String collection, String documentId) async {
    return await _firestore.collection(collection).doc(documentId).get();
  }
  
  Stream<QuerySnapshot> getDocuments(String collection) {
    return _firestore.collection(collection).snapshots();
  }
}
```

### 2. إنشاء مجلد fonts

تم إنشاء مجلد fonts المفقود والمشار إليه في pubspec.yaml.

### 3. إصلاح تكوين l10n.yaml

تم إصلاح تكوين l10n.yaml بإضافة معلمة output-dir.

```yaml
# قبل
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart

# بعد
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-dir: lib/gen_l10n
```

## الأخطاء المتبقية

هناك بعض الأخطاء المتبقية التي تحتاج إلى إصلاح:

1. مشاكل في ملفات movies.dart, tv_shows.dart, search.dart, movie.dart, tv_show.dart
2. مشاكل مع CarouselSliderController
3. مشاكل مع InternetConnection و InternetStatus
4. مشاكل مع WidgetStatePropertyAll
5. مشاكل مع SettingsThemeData

هذه الأخطاء تحتاج إلى مزيد من العمل لإصلاحها بشكل كامل.