import 'package:flutter/material.dart';
import 'package:mudahjev3/Services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  User? get user => _user;

  AuthProvider() {
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}