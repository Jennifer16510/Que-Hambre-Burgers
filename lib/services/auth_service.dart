class AuthService {
  // 🔹 Aquí se guardan los usuarios (usuario -> password)
  final Map<String, String> _users = {};

  // Registrar un usuario nuevo
  bool register(String username, String password) {
    if (_users.containsKey(username)) {
      return false; // Usuario ya existe
    }
    _users[username] = password;
    return true;
  }

  // Iniciar sesión
  bool login(String username, String password) {
    return _users[username] == password;
  }
}
