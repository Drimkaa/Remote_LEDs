import 'package:flutter/material.dart';
@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.dayCard,
    required this.lessonCard,
    required this.active,
    required this.dayCardBorder,
    required this.lessonCardBorder,
    required this.lessonCardActive
  });

  final Color? dayCard;
  final Color? lessonCard;
  final Color? active;
  final Color? dayCardBorder;
  final Color? lessonCardBorder;
  final Color? lessonCardActive;


  @override
  MyColors copyWith({Color? a, Color? b, Color? c,Color? d, Color? e,Color? f}) {
    return MyColors(
      dayCard: a ?? dayCard,
      lessonCard: b ?? lessonCard,
      active: c ?? active,
      dayCardBorder: d ?? dayCardBorder,
      lessonCardBorder: e ?? lessonCardBorder,
      lessonCardActive: f ?? lessonCardActive,
    );
  }

  @override
  MyColors lerp(MyColors? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      dayCard: Color.lerp(dayCard, other.dayCard, t),
      lessonCard: Color.lerp(lessonCard, other.dayCard, t),
      active: Color.lerp(active, other.dayCard, t),
      dayCardBorder: Color.lerp(dayCardBorder, other.dayCardBorder, t),
      lessonCardBorder: Color.lerp(lessonCardBorder, other.lessonCardBorder, t),
      lessonCardActive: Color.lerp(lessonCardActive, other.lessonCardActive, t),

    );
  }
}

ThemeData lightTheme = ThemeData.light().copyWith(
  textTheme: const TextTheme(
      labelMedium: TextStyle(color: Color(0xFF000000),  fontWeight: FontWeight.bold, fontSize: 16),
      labelSmall: TextStyle(color: Color(0xFF000000),  fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0, height: 0),
      labelLarge: TextStyle(color: Color(0xFF3B3B3B),  fontWeight: FontWeight.w500, fontSize: 12),
      headlineMedium: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold,  height: 1.1,fontSize: 18),
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
      )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedItemColor: Color(0xFF7286D3),
    unselectedItemColor: Color(0xFFCECECE),
    backgroundColor: Color(0xFFECECEC),

  ),

  extensions: <ThemeExtension<dynamic>>[
    const MyColors(
      dayCard : Color(0xffebebeb),
      lessonCard:Color(0xffe3e3e3),
      active: Color(0xFF2b4ec9),
      dayCardBorder : Color(0xffbbbbbb),
      lessonCardBorder : Color(0xffa2a2a2),
      lessonCardActive:   Color(0xff99adf1),
    ),
  ],
);


ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF1E1F22),
  appBarTheme: const AppBarTheme(

    backgroundColor: Color(0xFF141414),
  ),
  textTheme: const TextTheme(
      titleMedium: TextStyle(color: Color(0xFFFFFFFF),  fontWeight: FontWeight.w500, fontSize: 16),
      titleSmall: TextStyle(color: Color(0xFFFFFFFF),  fontWeight: FontWeight.w500, fontSize: 12, letterSpacing: 0, height: 0),
      titleLarge: TextStyle(color: Color(0xFFFFFFFF),  fontWeight: FontWeight.w500, fontSize: 20),
      headlineMedium: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500,  height: 1.1, fontSize: 18),
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
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFFF8F00),
    unselectedItemColor: Color(0xFF777777),
    backgroundColor: Color(0xFF141414),

  ),

  extensions: <ThemeExtension<dynamic>>[
    const MyColors(
      dayCard : Color(0xFF1E1E1E),
      lessonCard:Color(0xFF141414),
      active: Color(0xff345cef),
      dayCardBorder : Color(0xFF323232),
      lessonCardBorder : Color(0xFF282828),
      lessonCardActive:  Color(0xff2f3c6b),
    ),
  ],
);

