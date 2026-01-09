import '../../domain/repositories/job_repository.dart';
import '../datasources/local/data_provider.dart';
import '../datasources/remote/firestore_service.dart';

class JobRepositoryImpl implements JobRepository {
  final FirestoreService _firestoreService;
  final DataProvider _dataProvider;

  JobRepositoryImpl({
    required FirestoreService firestoreService,
    required DataProvider dataProvider,
  }) : _firestoreService = firestoreService,
       _dataProvider = dataProvider;

  @override
  Future<void> create(Map<String, dynamic> data) {
    return _firestoreService.addJob(data);
  }
}
