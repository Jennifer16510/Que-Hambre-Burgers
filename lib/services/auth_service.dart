import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _userKey = "users"; 

  static Future<bool> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_userKey) ?? [];

    for (var user in users) {
      final parts = user.split(':');
      if (parts[0] == username) return false;
    }

    users.add("$username:$password");
    await prefs.setStringList(_userKey, users);
    return true;
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = prefs.getStringList(_userKey) ?? [];

    for (var user in users) {
      final parts = user.split(':');
      if (parts[0] == username && parts[1] == password) return true;
    }
    return false;
  }
}
