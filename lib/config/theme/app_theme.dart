import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Color(0xFF10B981),
      secondary: Color(0xFFD4AF37),
      surface: Color(0xFFF5F5DC),
    
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Color(0xFF374151),
    ),
    scaffoldBackgroundColor: Color(0xFFF9FAF8),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF10B981), foregroundColor: Colors.white),
    useMaterial3: true,
    iconTheme: const IconThemeData(color: Colors.white),
    
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF34D399),
      secondary: Color(0xFFFACC15),
      surface: Color(0xFF1F2937),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF111827),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF065F46), foregroundColor: Colors.white),
    useMaterial3: true,
  );
}
