import '../../domain/entities/location.dart';
import '../../domain/entities/location_form.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/local/data_provider.dart';
import '../datasources/remote/firestore_service.dart';
import '../models/location_model.dart';

class LocationRepositoryImpl implements LocationRepository {
  final FirestoreService _firestoreService;
  final DataProvider _dataProvider;

  LocationRepositoryImpl({
    required FirestoreService firestoreService,
    required DataProvider dataProvider,
  }) : _firestoreService = firestoreService,
       _dataProvider = dataProvider;

  @override
  Future<void> addInstallation(LocationForm data) async {
    final model = LocationModel.fromEntity(data);
    final map = model.toMap();

    await _firestoreService.createDocument('locations', map);

    // Update local entity with the confirmed ID
    // _locations.add(data);
  }

  @override
  List<Location> getAllInstallations() {
    return _dataProvider.locations.map((model) => model.toEntity()).toList();
  }

  @override
  Location? getInstallationById(String id) {
    return _dataProvider.locations
        .firstWhere((model) => model.id == id)
        .toEntity();
  }
}
