// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../design/app_colors.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _isLogin = true; // 👈 Toggle entre login y registro

  // Credenciales dummy
  final String goodUser = 'admin';
  final String goodPass = '1234';

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(Duration(milliseconds: 700));
    setState(() => _loading = false);

    if (_userCtrl.text == goodUser && _passCtrl.text == goodPass) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Credenciales inválidas. Usa admin / 1234')),
      );
    }
  }

  void _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passCtrl.text != _confirmPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    setState(() => _loading = true);
    await Future.delayed(Duration(milliseconds: 700));
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Usuario registrado con éxito ✅')),
    );

    // Después de registrar, vuelve al login
    setState(() => _isLogin = true);
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.mainGradient),
        padding: EdgeInsets.symmetric(horizontal: 28),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Qué Hambre Burgers',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(4, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),

                  // ======= CAMPOS =======
                  TextFormField(
                    controller: _userCtrl,
                    decoration: _inputStyle('Username'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Ingrese usuario' : null,
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _passCtrl,
                    obscureText: true,
                    decoration: _inputStyle('Password'),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Ingrese password' : null,
                  ),

                  if (!_isLogin) ...[
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPassCtrl,
                      obscureText: true,
                      decoration: _inputStyle('Confirmar Password'),
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Repita su password'
                          : null,
                    ),
                  ],

                  SizedBox(height: 12),

                  if (_isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text('Recuperar contraseña'),
                                    content: Text('Recuerda usar: admin / 1234'),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('OK'))
                                    ],
                                  ));
                        },
                        child: Center(
                          child: Text(
                            'Restablecer contraseña?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 8),

                  // ======= BOTÓN =======
                  ElevatedButton(
                    onPressed: _loading
                        ? null
                        : _isLogin
                            ? _login
                            : _register,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Color.fromARGB(255, 57, 128, 209),
                    ),
                    child: _loading
                        ? CircularProgressIndicator(
                            color: const Color.fromARGB(255, 255, 254, 254))
                        : Text(
                            _isLogin ? 'Login' : 'Registrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),

                  SizedBox(height: 20),

                  // ======= TOGGLE =======
                  TextButton(
                    onPressed: () =>
                        setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin
                          ? '¿No tienes cuenta? Regístrate'
                          : '¿Ya tienes cuenta? Inicia sesión',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.15),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    );
  }
}
