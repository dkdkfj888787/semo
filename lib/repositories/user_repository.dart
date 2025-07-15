import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../utils/firestore_service.dart';

class UserRepository {
  final FirestoreService _firestoreService = FirestoreService();
  
  // Get a user by ID
  Future<User?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await _firestoreService.getDocument(
        collection: 'users',
        documentId: userId,
      );
      
      if (doc.exists) {
        return User.fromFirestore(doc);
      }
      
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }
  
  // Create a new user
  Future<String?> createUser(User user) async {
    try {
      DocumentReference docRef = await _firestoreService.addDocument(
        collection: 'users',
        data: user.toFirestore(),
      );
      
      return docRef.id;
    } catch (e) {
      print('Error creating user: $e');
      return null;
    }
  }
  
  // Update a user
  Future<bool> updateUser(User user) async {
    try {
      await _firestoreService.updateDocument(
        collection: 'users',
        documentId: user.id,
        data: user.toFirestore(),
      );
      
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }
  
  // Add a movie to favorites
  Future<bool> addMovieToFavorites(String userId, String movieId) async {
    try {
      User? user = await getUserById(userId);
      
      if (user != null) {
        List<String> updatedFavorites = List.from(user.favoriteMovies);
        
        if (!updatedFavorites.contains(movieId)) {
          updatedFavorites.add(movieId);
          
          await _firestoreService.updateDocument(
            collection: 'users',
            documentId: userId,
            data: {
              'favoriteMovies': updatedFavorites,
              'updatedAt': DateTime.now(),
            },
          );
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error adding movie to favorites: $e');
      return false;
    }
  }
  
  // Remove a movie from favorites
  Future<bool> removeMovieFromFavorites(String userId, String movieId) async {
    try {
      User? user = await getUserById(userId);
      
      if (user != null) {
        List<String> updatedFavorites = List.from(user.favoriteMovies);
        
        if (updatedFavorites.contains(movieId)) {
          updatedFavorites.remove(movieId);
          
          await _firestoreService.updateDocument(
            collection: 'users',
            documentId: userId,
            data: {
              'favoriteMovies': updatedFavorites,
              'updatedAt': DateTime.now(),
            },
          );
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error removing movie from favorites: $e');
      return false;
    }
  }
  
  // Add a TV show to favorites
  Future<bool> addTvShowToFavorites(String userId, String tvShowId) async {
    try {
      User? user = await getUserById(userId);
      
      if (user != null) {
        List<String> updatedFavorites = List.from(user.favoriteTvShows);
        
        if (!updatedFavorites.contains(tvShowId)) {
          updatedFavorites.add(tvShowId);
          
          await _firestoreService.updateDocument(
            collection: 'users',
            documentId: userId,
            data: {
              'favoriteTvShows': updatedFavorites,
              'updatedAt': DateTime.now(),
            },
          );
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error adding TV show to favorites: $e');
      return false;
    }
  }
  
  // Remove a TV show from favorites
  Future<bool> removeTvShowFromFavorites(String userId, String tvShowId) async {
    try {
      User? user = await getUserById(userId);
      
      if (user != null) {
        List<String> updatedFavorites = List.from(user.favoriteTvShows);
        
        if (updatedFavorites.contains(tvShowId)) {
          updatedFavorites.remove(tvShowId);
          
          await _firestoreService.updateDocument(
            collection: 'users',
            documentId: userId,
            data: {
              'favoriteTvShows': updatedFavorites,
              'updatedAt': DateTime.now(),
            },
          );
        }
        
        return true;
      }
      
      return false;
    } catch (e) {
      print('Error removing TV show from favorites: $e');
      return false;
    }
  }
  
  // Get user's favorite movies
  Future<List<String>> getUserFavoriteMovies(String userId) async {
    try {
      User? user = await getUserById(userId);
      
      if (user != null) {
        return user.favoriteMovies;
      }
      
      return [];
    } catch (e) {
      print('Error getting user favorite movies: $e');
      return [];
    }
  }
  
  // Get user's favorite TV shows
  Future<List<String>> getUserFavoriteTvShows(String userId) async {
    try {
      User? user = await getUserById(userId);
      
      if (user != null) {
        return user.favoriteTvShows;
      }
      
      return [];
    } catch (e) {
      print('Error getting user favorite TV shows: $e');
      return [];
    }
  }
}