import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  // 🔹 Instancia del AuthService
  final AuthService _authService = AuthService();

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    bool success = _authService.register(
      _userCtrl.text.trim(),
      _passCtrl.text.trim(),
    );

    setState(() => _loading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Usuario creado con éxito')),
      );
      Navigator.pop(context); // volver al login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ El usuario ya existe')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _userCtrl,
              decoration: InputDecoration(labelText: "Usuario"),
              validator: (val) =>
                  val!.isEmpty ? "Ingrese un usuario" : null,
            ),
            TextFormField(
              controller: _passCtrl,
              obscureText: true,
              decoration: InputDecoration(labelText: "Contraseña"),
              validator: (val) =>
                  val!.isEmpty ? "Ingrese una contraseña" : null,
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: Text("Registrar"),
                  ),
          ],
        ),
      ),
    );
  }
}
