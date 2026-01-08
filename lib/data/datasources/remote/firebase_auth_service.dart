import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  AuthService() {
    // Listen to Firebase Auth changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      _user = user;
      print('AuthService: Auth state changed. User: ${user}');
      await Future.delayed(const Duration(seconds: 3));
      _isInitialized = true;
      notifyListeners(); // This triggers GoRouter to re-evaluate the redirect logic
    });
  }

  bool get isAuthenticated => _user != null;
}
