import 'package:flutter/material.dart';

import '../../../../domain/repositories/job_repository.dart';

class JobCreateViewModel extends ChangeNotifier {
  final JobRepository _repository;

  JobCreateViewModel({required JobRepository repository})
    : _repository = repository;

  /* -------------------------------------------------------------------------- */
  /*                               FORM CONTROLLERS                              */
  /* -------------------------------------------------------------------------- */

  final descriptionController = TextEditingController();
  final estimatedCostController = TextEditingController();
  final specialInstructionsController = TextEditingController();

  // Form key moved to ViewModel so view can reuse same key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? _installationDate;
  DateTime? get installationDate => _installationDate;

  String? selectedDistrict;
  String? selectedModel;

  // Form State
  String _selectedCategory = 'Leakage';
  final List<String> _photos = []; // Paths to images
  bool _isSubmitting = false;

  // Getters
  String get selectedCategory => _selectedCategory;
  List<String> get photos => _photos;
  bool get isSubmitting => _isSubmitting;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void addPhoto(String path) {
    _photos.add(path);
    notifyListeners();
  }

  void removePhoto(int index) {
    _photos.removeAt(index);
    notifyListeners();
  }

  Future<bool> submitRequest() async {
    _isSubmitting = true;
    notifyListeners();

    try {
      await _repository.create({
        'description': descriptionController.text.trim(),
        'estimatedCost': estimatedCostController.text.trim(),
        'specialInstructions': specialInstructionsController.text.trim(),
        'category': _selectedCategory,
        'photos': _photos,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    descriptionController.dispose();
    estimatedCostController.dispose();
    specialInstructionsController.dispose();
    super.dispose();
  }
}
