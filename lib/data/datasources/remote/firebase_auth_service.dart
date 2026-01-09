import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  AuthService() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  bool get isAuthenticated => _user != null;
}
