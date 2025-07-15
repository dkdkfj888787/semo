import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> favoriteMovies;
  final List<String> favoriteTvShows;
  final Map<String, dynamic> preferences;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.favoriteMovies,
    required this.favoriteTvShows,
    required this.preferences,
    required this.createdAt,
    required this.updatedAt,
  });

  // Create a User from a Firestore document
  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photoUrl: data['photoUrl'],
      favoriteMovies: List<String>.from(data['favoriteMovies'] ?? []),
      favoriteTvShows: List<String>.from(data['favoriteTvShows'] ?? []),
      preferences: data['preferences'] ?? {},
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }

  // Convert a User to a Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'favoriteMovies': favoriteMovies,
      'favoriteTvShows': favoriteTvShows,
      'preferences': preferences,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a copy of the User with updated fields
  User copyWith({
    String? name,
    String? email,
    String? photoUrl,
    List<String>? favoriteMovies,
    List<String>? favoriteTvShows,
    Map<String, dynamic>? preferences,
  }) {
    return User(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      favoriteTvShows: favoriteTvShows ?? this.favoriteTvShows,
      preferences: preferences ?? this.preferences,
      createdAt: this.createdAt,
      updatedAt: DateTime.now(),
    );
  }
}