import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

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
