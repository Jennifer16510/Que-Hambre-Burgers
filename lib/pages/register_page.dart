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

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    bool success = await AuthService.register(
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
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crear cuenta")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _userCtrl,
                decoration: InputDecoration(
                  labelText: "Usuario",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Ingrese un usuario" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Ingrese una contraseña" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loading ? null : _register,
                child: _loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
