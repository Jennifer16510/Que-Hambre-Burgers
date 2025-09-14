import 'package:flutter/material.dart';
import '../design/app_colors.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  // Instancia del AuthService
  final AuthService _authService = AuthService();

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    bool success = await _authService.login(
      _userCtrl.text.trim(),
      _passCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (success) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Credenciales inválidas")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userCtrl,
                decoration: InputDecoration(labelText: "Usuario"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su usuario" : null,
              ),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: InputDecoration(labelText: "Contraseña"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su contraseña" : null,
              ),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login, child: Text("Iniciar Sesión")),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text("¿No tienes cuenta? Regístrate aquí"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
