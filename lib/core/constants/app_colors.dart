import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFBEC21);
  static const Color primaryDark = Color(0xFFFCC218);
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF5F5F5);
  static const Color textPrimary = Colors.black;
  static const Color textSecondary = Colors.black87;
  static const Color textGrey = Colors.grey;
  static const Color error = Colors.red;
  static const Color success = Colors.green;
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );
}
