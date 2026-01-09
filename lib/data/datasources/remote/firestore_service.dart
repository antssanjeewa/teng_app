import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  // ==========================================
  // READ (The "Fetch Once" Logic)
  // ==========================================

  /// Fetches an entire collection once.
  /// Perfect for initializing your local state.
  Future<List<Map<String, dynamic>>> getCollection(String path) async {
    try {
      final querySnapshot = await _firestore.collection(path).get();
      return querySnapshot.docs.map((doc) {
        return {'id': doc.id, ...doc.data()};
      }).toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch $path: ${e.message}');
    }
  }

  // ==========================================
  // READ (Single Document)
  // ==========================================

  Future<Map<String, dynamic>?> getDocumentById(
    String path,
    String docId,
  ) async {
    try {
      final doc = await _firestore.collection(path).doc(docId).get();

      if (doc.exists) {
        return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
      }
      return null; // Document not found
    } on FirebaseException catch (e) {
      throw Exception('Failed to fetch document: ${e.message}');
    }
  }

  // ==========================================
  // CREATE
  // ==========================================

  Future<String> createDocument(String path, Map<String, dynamic> data) async {
    try {
      final docRef = await _firestore.collection(path).add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef.id; // Return the ID so you can add it to your local state
    } on FirebaseException catch (e) {
      throw Exception('Create failed: ${e.message}');
    }
  }

  // ==========================================
  // UPDATE
  // ==========================================

  Future<void> updateDocument(
    String path,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore.collection(path).doc(docId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Update failed: ${e.message}');
    }
  }

  // ==========================================
  // DELETE
  // ==========================================

  Future<void> deleteDocument(String path, String docId) async {
    try {
      await _firestore.collection(path).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Delete failed: ${e.message}');
    }
  }

  Future<void> addInstallation(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('locations').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Firestore write failed');
    }
  }

  Future<void> addJob(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('jobs').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Firestore write failed');
    }
  }
}
