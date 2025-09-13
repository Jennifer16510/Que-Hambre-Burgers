import 'package:flutter/material.dart';

class AppColors {
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFBFF00A), // verde claro
      Color(0xFFFFC857), // amarillo/naranja
      Color(0xFFFF7A5A), // naranja oscuro
    ],
  );

  static const Color darkBg = Color(0xFF4A4A4A);
  static const Color accent = Color(0xFF2E7D32);
}
