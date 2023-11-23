import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  //
  const MyColors();

  final Color success = Colors.green;
  final Color failure = Colors.redAccent;
  final Color first = const Color(0xff00fdc7);
  final Color second = const Color(0xff10dcb1);
  final Color active = const Color(0xff00fdc7);
  final Color inactive = const Color(0xff6f737c);
  final Color inactive2 = const Color(0xffa8adbb);
  final Color first2 = const Color(0xff7e15fd);
  final Color second2 = const Color(0xff670fc4);
  @override
  ThemeExtension<MyColors> copyWith() => const MyColors();

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) => (other is! MyColors) ? this : const MyColors();
}
