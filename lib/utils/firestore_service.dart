import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory FirestoreService() {
    return _instance;
  }

  FirestoreService._internal();

  // Get a reference to the Firestore instance
  FirebaseFirestore get firestore => _firestore;

  // Collection references
  CollectionReference get usersCollection => _firestore.collection('users');
  CollectionReference get moviesCollection => _firestore.collection('movies');
  CollectionReference get tvShowsCollection => _firestore.collection('tv_shows');
  CollectionReference get favoritesCollection => _firestore.collection('favorites');
  
  // Add a document to a collection
  Future<DocumentReference> addDocument(
      {required String collection, required Map<String, dynamic> data}) async {
    return await _firestore.collection(collection).add(data);
  }

  // Get a document by ID
  Future<DocumentSnapshot> getDocument(
      {required String collection, required String documentId}) async {
    return await _firestore.collection(collection).doc(documentId).get();
  }

  // Update a document
  Future<void> updateDocument(
      {required String collection,
      required String documentId,
      required Map<String, dynamic> data}) async {
    await _firestore.collection(collection).doc(documentId).update(data);
  }

  // Delete a document
  Future<void> deleteDocument(
      {required String collection, required String documentId}) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }

  // Get all documents in a collection
  Future<QuerySnapshot> getCollection({required String collection}) async {
    return await _firestore.collection(collection).get();
  }

  // Get documents with a query
  Future<QuerySnapshot> queryCollection(
      {required String collection,
      required String field,
      required dynamic isEqualTo}) async {
    return await _firestore
        .collection(collection)
        .where(field, isEqualTo: isEqualTo)
        .get();
  }

  // Listen to a document for real-time updates
  Stream<DocumentSnapshot> streamDocument(
      {required String collection, required String documentId}) {
    return _firestore.collection(collection).doc(documentId).snapshots();
  }

  // Listen to a collection for real-time updates
  Stream<QuerySnapshot> streamCollection({required String collection}) {
    return _firestore.collection(collection).snapshots();
  }
}