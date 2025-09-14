import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../design/themedata.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final AuthService _authService = AuthService();

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passCtrl.text.trim() != _confirmCtrl.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Las contraseñas no coinciden")),
      );
      return;
    }

    setState(() => _loading = true);

    final success = await _authService.register(
      _userCtrl.text.trim(),
      _passCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Registro exitoso")),
      );
      Navigator.pushReplacementNamed(context, '/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Error al registrarse")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
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
                    value!.isEmpty ? "Ingrese un usuario" : null,
              ),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Contraseña"),
                validator: (value) =>
                    value!.isEmpty ? "Ingrese una contraseña" : null,
              ),
              TextFormField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Confirmar Contraseña"),
                validator: (value) =>
                    value!.isEmpty ? "Repita la contraseña" : null,
              ),
              const SizedBox(height: 20),
              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.coralRed,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Registrarse"),
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text(
                  "¿Ya tienes cuenta? Inicia sesión",
                  style: TextStyle(
                    color: ThemeColors.coralRed, // 🔸 texto naranja
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
