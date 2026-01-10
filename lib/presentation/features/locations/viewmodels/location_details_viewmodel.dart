import 'package:flutter/material.dart';

import '../../../../domain/entities/location.dart';
import '../../../../domain/repositories/location_repository.dart';

class LocationDetailsViewModel extends ChangeNotifier {
  final LocationRepository _repository;

  LocationDetailsViewModel({required LocationRepository repository})
    : _repository = repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Location? _location;
  Location? get location => _location;

  Future<void> loadById(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _location = await _repository.getInstallationById(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
