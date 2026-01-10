import 'package:flutter/material.dart';

import '../../models/job_model.dart';
import '../../models/location_model.dart';
import '../remote/firestore_service.dart';

class DataProvider extends ChangeNotifier {
  final FirestoreService _service = FirestoreService();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  // Now using Lists of Objects instead of Maps
  List<LocationModel> _locations = [];
  List<JobModel> _jobs = [];

  List<LocationModel> get locations => _locations;
  List<JobModel> get jobs => _jobs;

  // 1. Initial Fetch: Call this once when the app/user is ready
  Future<void> initializeData() async {
    if (_isInitialized) return;

    try {
      // Fetch all data in parallel
      final results = await Future.wait([
        _service.getCollection('locations'),
        _service.getCollection('jobs'),
      ]);

      _locations = (results[0] as List)
          .map((e) => LocationModel.fromMap(e, e['id']))
          .toList();
      _jobs = (results[1] as List)
          .map((e) => JobModel.fromMap(e, e['id']))
          .toList();

      debugPrint(
        "Data Loaded: ${_locations.length} locations, ${_jobs.length} jobs",
      );

      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      debugPrint("Error initializing data: $e");
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  // 2. Calculated Data (Logic Layer)
  // Dashboard needs a count? Calculate it here locally.
  int get totalJobsCount => _jobs.length;

  // int get activeJobsCount =>
  //     _jobs.where((job) => job['status'] == 'active').length;

  // List<Map<String, dynamic>> getJobsByLocation(String locationId) {
  //   return _jobs.where((job) => job['locationId'] == locationId).toList();
  // }

  // // 3. CRUD wrapper
  // // When adding data, update Firestore AND local state so the UI updates instantly
  // Future<void> addNewJob(Map<String, dynamic> jobData) async {
  //   await _service.addJob(jobData);
  //   _jobs.add(jobData); // Optimistic update or refetch
  //   notifyListeners();
  // }
}
