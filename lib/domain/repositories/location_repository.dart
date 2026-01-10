import '../entities/location.dart';
import '../entities/location_form.dart';

abstract class LocationRepository {
  Future<void> addInstallation(LocationForm data);
  List<Location> getAllInstallations();
  Location? getInstallationById(String id);
}
