import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../design/themedata.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final AuthService _authService = AuthService();

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final success = await _authService.login(
      _userCtrl.text.trim(),
      _passCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (success) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Credenciales inválidas")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userCtrl,
                decoration: const InputDecoration(labelText: "Usuario"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su usuario" : null,
              ),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese su contraseña" : null,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.coralRed, // botón rojo/naranja
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Iniciar Sesión"),
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  "¿No tienes cuenta? Regístrate aquí",
                  style: TextStyle(
                    color: ThemeColors.coralRed, // 🔸 texto en naranja
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
