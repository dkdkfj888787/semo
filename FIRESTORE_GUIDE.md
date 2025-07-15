# دليل استخدام Firestore في تطبيق Index

هذا الدليل يشرح كيفية استخدام Firestore في تطبيق Index VOD Streaming App.

## المقدمة

تم إضافة دعم Firestore إلى التطبيق لتخزين بيانات المستخدمين والمفضلات وسجل المشاهدة. يتيح هذا للمستخدمين مزامنة بياناتهم عبر أجهزة متعددة والاحتفاظ بها حتى بعد إعادة تثبيت التطبيق.

## الإعداد

### 1. إنشاء مشروع Firebase

1. انتقل إلى [Firebase Console](https://console.firebase.google.com/)
2. أنشئ مشروعًا جديدًا
3. أضف تطبيق Android و/أو iOS إلى المشروع
4. قم بتنزيل ملف التكوين `google-services.json` (Android) أو `GoogleService-Info.plist` (iOS)
5. ضع ملف التكوين في المكان المناسب في مشروع Flutter

### 2. تمكين Firestore

1. في Firebase Console، انتقل إلى Firestore Database
2. انقر على "إنشاء قاعدة بيانات"
3. اختر وضع البدء (الإنتاج أو الاختبار)
4. اختر موقع قاعدة البيانات
5. انتظر حتى يتم إنشاء قاعدة البيانات

### 3. تكوين قواعد الأمان

قم بتكوين قواعد الأمان لقاعدة بيانات Firestore:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /favorites/{document=**} {
      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;
    }
    match /watchHistory/{document=**} {
      allow read, write: if request.auth != null && resource.data.userId == request.auth.uid;
    }
  }
}
```

## هيكل البيانات

### 1. مجموعة المستخدمين (users)

```
users/
  ├── userId1/
  │   ├── name: "اسم المستخدم"
  │   ├── email: "user@example.com"
  │   ├── createdAt: Timestamp
  │   └── lastLogin: Timestamp
  └── userId2/
      └── ...
```

### 2. مجموعة المفضلات (favorites)

```
favorites/
  ├── documentId1/
  │   ├── userId: "userId1"
  │   ├── mediaId: "123"
  │   ├── mediaType: "movie"
  │   ├── title: "عنوان الفيلم"
  │   ├── posterPath: "/path/to/poster.jpg"
  │   └── addedAt: Timestamp
  └── documentId2/
      └── ...
```

### 3. مجموعة سجل المشاهدة (watchHistory)

```
watchHistory/
  ├── documentId1/
  │   ├── userId: "userId1"
  │   ├── mediaId: "123"
  │   ├── mediaType: "movie"
  │   ├── title: "عنوان الفيلم"
  │   ├── posterPath: "/path/to/poster.jpg"
  │   ├── watchedAt: Timestamp
  │   └── position: 1234 (بالثواني)
  └── documentId2/
      └── ...
```

## استخدام FirestoreService

### 1. تهيئة الخدمة

```dart
final firestoreService = FirestoreService();
```

### 2. إضافة مستخدم جديد

```dart
Future<void> addUser(User user) async {
  await firestoreService.addDocument('users', user.toJson());
}
```

### 3. تحديث بيانات المستخدم

```dart
Future<void> updateUser(String userId, Map<String, dynamic> data) async {
  await firestoreService.updateDocument('users', userId, data);
}
```

### 4. الحصول على بيانات المستخدم

```dart
Future<User?> getUser(String userId) async {
  final doc = await firestoreService.getDocument('users', userId);
  if (doc.exists) {
    return User.fromJson(doc.data() as Map<String, dynamic>);
  }
  return null;
}
```

### 5. إضافة فيلم إلى المفضلة

```dart
Future<void> addToFavorites(String userId, Movie movie) async {
  await firestoreService.addDocument('favorites', {
    'userId': userId,
    'mediaId': movie.id,
    'mediaType': 'movie',
    'title': movie.title,
    'posterPath': movie.posterPath,
    'addedAt': FieldValue.serverTimestamp(),
  });
}
```

### 6. الحصول على قائمة المفضلة

```dart
Stream<List<Movie>> getFavoriteMovies(String userId) {
  return firestoreService
      .getDocuments('favorites')
      .where('userId', isEqualTo: userId)
      .where('mediaType', isEqualTo: 'movie')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Movie(
        id: data['mediaId'],
        title: data['title'],
        posterPath: data['posterPath'],
      );
    }).toList();
  });
}
```

### 7. إضافة إلى سجل المشاهدة

```dart
Future<void> addToWatchHistory(String userId, Movie movie, int position) async {
  await firestoreService.addDocument('watchHistory', {
    'userId': userId,
    'mediaId': movie.id,
    'mediaType': 'movie',
    'title': movie.title,
    'posterPath': movie.posterPath,
    'watchedAt': FieldValue.serverTimestamp(),
    'position': position,
  });
}
```

## نموذج المستخدم

```dart
class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime lastLogin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      lastLogin: (json['lastLogin'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}
```

## UserRepository

```dart
class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> createUser(User user) async {
    await _firestoreService.addDocument('users', user.toJson());
  }

  Future<User?> getUser(String userId) async {
    final doc = await _firestoreService.getDocument('users', userId);
    if (doc.exists) {
      return User.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _firestoreService.updateDocument('users', userId, data);
  }

  Future<void> deleteUser(String userId) async {
    await _firestoreService.deleteDocument('users', userId);
  }

  Future<void> addToFavorites(String userId, Movie movie) async {
    await _firestoreService.addDocument('favorites', {
      'userId': userId,
      'mediaId': movie.id,
      'mediaType': 'movie',
      'title': movie.title,
      'posterPath': movie.posterPath,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeFromFavorites(String userId, String movieId) async {
    final querySnapshot = await _firestoreService.firestore
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .where('mediaId', isEqualTo: movieId)
        .get();

    for (var doc in querySnapshot.docs) {
      await _firestoreService.deleteDocument('favorites', doc.id);
    }
  }

  Stream<List<Movie>> getFavoriteMovies(String userId) {
    return _firestoreService.firestore
        .collection('favorites')
        .where('userId', isEqualTo: userId)
        .where('mediaType', isEqualTo: 'movie')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Movie(
          id: data['mediaId'],
          title: data['title'],
          posterPath: data['posterPath'],
        );
      }).toList();
    });
  }

  Future<void> addToWatchHistory(String userId, Movie movie, int position) async {
    await _firestoreService.addDocument('watchHistory', {
      'userId': userId,
      'mediaId': movie.id,
      'mediaType': 'movie',
      'title': movie.title,
      'posterPath': movie.posterPath,
      'watchedAt': FieldValue.serverTimestamp(),
      'position': position,
    });
  }

  Stream<List<Movie>> getWatchHistory(String userId) {
    return _firestoreService.firestore
        .collection('watchHistory')
        .where('userId', isEqualTo: userId)
        .orderBy('watchedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Movie(
          id: data['mediaId'],
          title: data['title'],
          posterPath: data['posterPath'],
        );
      }).toList();
    });
  }
}
```

## الخلاصة

باستخدام Firestore، يمكن للتطبيق الآن تخزين بيانات المستخدمين ومزامنتها عبر الأجهزة المختلفة. يمكن توسيع هذه الوظائف لتشمل المزيد من الميزات مثل التوصيات المخصصة والإعدادات المتزامنة.