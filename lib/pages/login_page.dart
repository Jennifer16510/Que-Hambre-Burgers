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
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

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

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
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
                  TextFormField(
                    controller: _userCtrl,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'Ingrese usuario' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.15),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    ),
                    validator: (v) => (v == null || v.isEmpty) ? 'Ingrese password' : null,
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showDialog(context: context, builder: (_) =>
                          AlertDialog(
                            title: Text('Recuperar contraseña'),
                            content: Text('Funcionalidad demo: usa admin / 1234'),
                            actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text('OK'))],
                          )
                        );
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
                  ElevatedButton(
                    onPressed: _loading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor:  Color.fromARGB(255, 57, 128, 209),
                    ),
                    child: _loading
                      ? CircularProgressIndicator(color: const Color.fromARGB(255, 255, 254, 254))
                      : Text(
                          'Login',
                        style: TextStyle(
                          color: Colors.white, // 👈 Aquí cambias el color de la letra
                          fontSize: 16,        // opcional: tamaño
                          fontWeight: FontWeight.bold, // opcional: negrita
                        ),
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
}
