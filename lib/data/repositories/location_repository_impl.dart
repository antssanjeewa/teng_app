import '../../domain/repositories/location_repository.dart';
import '../datasources/remote/firestore_service.dart';

class LocationRepositoryImpl implements LocationRepository {
  final FirestoreService _firestoreService;

  LocationRepositoryImpl({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  @override
  Future<void> addInstallation(Map<String, dynamic> data) {
    return _firestoreService.addInstallation(data);
  }
}
