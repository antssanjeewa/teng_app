import 'package:flutter/material.dart';
import '../../../../domain/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewModel({required AuthRepository authRepository})
    : _authRepository = authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null; // Reset error on new attempt
    notifyListeners();

    try {
      final user = await _authRepository.signUp(email, password);
      if (user != null) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Invalid email or password.";
        return false;
      }
    } catch (e) {
      _errorMessage = e.toString().contains('Exception:')
          ? e.toString().split('Exception: ').last
          : "An unexpected error occurred.";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
