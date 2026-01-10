import 'package:flutter/material.dart';

import '../../../../domain/entities/location_form.dart';
import '../../../../domain/repositories/location_repository.dart';

class LocationCreateViewModel extends ChangeNotifier {
  final LocationRepository _repository;

  LocationCreateViewModel({required LocationRepository repository})
    : _repository = repository;

  /* -------------------------------------------------------------------------- */
  /*                               FORM CONTROLLERS                              */
  /* -------------------------------------------------------------------------- */

  final customerNameController = TextEditingController();
  final customerContactController = TextEditingController();

  final donorNameController = TextEditingController();
  final donorContactController = TextEditingController();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final estimatedCostController = TextEditingController();
  final specialInstructionsController = TextEditingController();

  // Form key moved to ViewModel so view can reuse same key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? _installationDate;
  DateTime? get installationDate => _installationDate;

  String? selectedDistrict;
  String? selectedModel;

  // Dropdown data (static for now; can be loaded from repository or API later)
  final List<String> districts = [
    'Colombo',
    'Gampaha',
    'Kandy',
    'Galle',
    'Jaffna',
    'Matara',
  ];

  final List<String> models = ['RO-100', 'RO-200', 'RO-500', 'RO-1000'];

  /* -------------------------------------------------------------------------- */
  /*                                  UI STATE                                   */
  /* -------------------------------------------------------------------------- */

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /* -------------------------------------------------------------------------- */
  /*                               SETTERS                                       */
  /* -------------------------------------------------------------------------- */

  void setInstallationDate(DateTime date) {
    _installationDate = date;
    notifyListeners();
  }

  void setDistrict(String value) {
    selectedDistrict = value;
    notifyListeners();
  }

  void setModel(String value) {
    selectedModel = value;
    notifyListeners();
  }

  /* -------------------------------------------------------------------------- */
  /*                               VALIDATION                                    */
  /* -------------------------------------------------------------------------- */

  bool validate() {
    _errorMessage = null;

    if (customerNameController.text.trim().isEmpty) {
      _errorMessage = 'Customer name is required';
      return false;
    }

    if (!_isValidPhone(customerContactController.text)) {
      _errorMessage = 'Valid customer contact number is required';
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      _errorMessage = 'Installation address is required';
      return false;
    }

    if (selectedDistrict == null) {
      _errorMessage = 'Please select a district';
      return false;
    }

    if (selectedModel == null) {
      _errorMessage = 'Please select RO plant model';
      return false;
    }

    if (_installationDate == null) {
      _errorMessage = 'Please select installation date';
      return false;
    }

    return true;
  }

  bool _isValidPhone(String value) {
    final phone = value.replaceAll(RegExp(r'\s+'), '');
    return phone.length >= 9;
  }

  /* -------------------------------------------------------------------------- */
  /*                               SAVE LOGIC                                    */
  /* -------------------------------------------------------------------------- */

  Future<bool> saveInstallation() async {
    // First validate any attached Form fields (TextFormField validators)
    final bool formValid = formKey.currentState?.validate() ?? true;
    if (!formValid) {
      // Let form show its validation errors
      notifyListeners();
      return false;
    }

    // Additional non-Form validation (dropdowns/date/phone)
    if (!validate()) {
      notifyListeners();
      return false;
    }

    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final LocationForm payload = LocationForm(
        name: nameController.text.trim(),
        customerName: customerNameController.text.trim(),
        customerContact: customerContactController.text.trim(),
        donorName: donorNameController.text.trim(),
        donorContact: donorContactController.text.trim(),
        address: addressController.text.trim(),
        district: selectedDistrict!,
        model: selectedModel!,
        installationDate: _installationDate!,
        estimatedCost: estimatedCostController.text.trim(),
        specialInstructions: specialInstructionsController.text.trim(),
      );

      await _repository.addInstallation(payload);
      return true;
    } catch (e) {
      _errorMessage = e.toString().contains('Exception:')
          ? e.toString().split('Exception: ').last
          : 'An unexpected error occurred';
      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                               CLEANUP                                       */
  /* -------------------------------------------------------------------------- */

  @override
  void dispose() {
    customerNameController.dispose();
    customerContactController.dispose();
    donorNameController.dispose();
    donorContactController.dispose();
    nameController.dispose();
    addressController.dispose();
    estimatedCostController.dispose();
    specialInstructionsController.dispose();
    super.dispose();
  }
}
