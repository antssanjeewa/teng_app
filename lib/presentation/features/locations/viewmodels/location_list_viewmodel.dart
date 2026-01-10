import 'package:flutter/material.dart';

import '../../../../domain/entities/location.dart';
import '../../../../domain/repositories/location_repository.dart';

class LocationListViewModel extends ChangeNotifier {
  final LocationRepository _repository;

  LocationListViewModel({required LocationRepository repository})
    : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<Location> _locations = [];
  List<Location> get locations => _locations;

  void loadLocations() {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = _repository.getAllInstallations();
      _locations = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
