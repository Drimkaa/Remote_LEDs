import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/theme_extension.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF1E1F22),
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF141414)),
  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 16),
    titleSmall: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 12, letterSpacing: 0, height: 0),
    titleLarge: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, fontSize: 20),
    headlineMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500, height: 1.1, fontSize: 18),
    labelMedium: TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 18,
      height: 1,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      color: Color(0xff345cef),
      fontSize: 18,
      height: 1,
      fontWeight: FontWeight.w400,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: const MyColors().active,
    unselectedItemColor: const MyColors().inactive,
    backgroundColor: const Color(0xFF141414),
  ),
  extensions: <ThemeExtension<dynamic>>[const MyColors()],
);
