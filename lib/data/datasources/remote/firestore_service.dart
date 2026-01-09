import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addInstallation(Map<String, dynamic> data) async {
    try {
      await _firestore.collection('installations').add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? 'Firestore write failed');
    }
  }
}
