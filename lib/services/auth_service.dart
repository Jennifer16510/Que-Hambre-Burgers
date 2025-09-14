import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final Map<String, String> _users = {}; // username -> password
  String? _currentUser;

  String? get currentUser => _currentUser;

  Future<bool> register(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.containsKey(username)) return false;
    _users[username] = password;
    notifyListeners();
    return true;
  }

  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users[username] == password) {
      _currentUser = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // 🔑 Reset password (flujo simple: asigna "123456")
  Future<bool> resetPassword(String username) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.containsKey(username)) {
      _users[username] = "123456"; // nueva contraseña por defecto
      notifyListeners();
      return true;
    }
    return false;
  }
}
