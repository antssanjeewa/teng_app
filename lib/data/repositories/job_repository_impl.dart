import '../../domain/repositories/job_repository.dart';
import '../datasources/remote/firestore_service.dart';

class JobRepositoryImpl implements JobRepository {
  final FirestoreService _firestoreService;

  JobRepositoryImpl({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  @override
  Future<void> create(Map<String, dynamic> data) {
    return _firestoreService.addJob(data);
  }
}
