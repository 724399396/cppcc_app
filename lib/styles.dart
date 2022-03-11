import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF4F4F4);

  static const textColor = Color.fromRGBO(35, 35, 50, .7);

  static const greyTextColor = Color(0xFF9A9A9A);

  static const displayTextColor = Colors.black;

  static const primaryBlue = Colors.blue;

  static MaterialColor primary = MaterialColor(0xFFFB7D30, _primarySwatch);
}

Map<int, Color> _primarySwatch = {
  50: const Color(0xFFE8F5E9),
  100: const Color(0xFFC8E6C9),
  200: const Color(0xFFA5D6A7),
  300: const Color(0xFF81C784),
  400: const Color(0xFF66BB6A),
  500: const Color(0xFF29C478),
  600: const Color(0xFF43A047),
  700: const Color(0xFF388E3C),
  800: const Color(0xFF2E7D32),
  900: const Color(0xFF1B5E20),
};
