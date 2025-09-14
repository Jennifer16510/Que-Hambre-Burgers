import 'package:flutter/material.dart';

class ThemeColors {
  
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      ThemeColors.freshGreen,
      ThemeColors.sunsetYellow,
      ThemeColors.coralRed,
    ],
  );

  
  static const Color freshGreen = Color(0xFF7CB518); 
  static const Color sunsetYellow = Color(0xFFFFC857); 
  static const Color coralRed = Color(0xFFFF7A5A); 

 
  static const Color darkBg = Color(0xFF121212); 
  static const Color lightBg = Color(0xFFF5F5F5); 
  static const Color textPrimary = Color(0xFF212121); 
  static const Color textSecondary = Color(0xFF757575); 

 
  static const Color success = Color(0xFF4CAF50); 
  static const Color error = Color(0xFFF44336); 
  static const Color warning = Color(0xFFFF9800); 
  static const Color info = Color(0xFF2196F3); 
}
