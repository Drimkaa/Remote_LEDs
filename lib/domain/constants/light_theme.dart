import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  textTheme: const TextTheme(
      labelMedium: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold, fontSize: 16),
      labelSmall: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0, height: 0),
      labelLarge: TextStyle(color: Color(0xFF3B3B3B), fontWeight: FontWeight.w500, fontSize: 12),
      headlineMedium: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold, height: 1.1, fontSize: 18),
      titleMedium: TextStyle(
        color: Color(0xFF000000),
        height: 1,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        height: 1,
        color: Color(0xFF2b4ec9),
        fontSize: 18,
        fontWeight: FontWeight.w700,
      )),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedItemColor: Color(0xFF7286D3),
    unselectedItemColor: Color(0xFFCECECE),
    backgroundColor: Color(0xFFECECEC),
  ),
);
