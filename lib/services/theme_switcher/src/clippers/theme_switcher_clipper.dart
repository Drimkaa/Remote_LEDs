import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class ThemeSwitcherClipper {
  const ThemeSwitcherClipper();

  Rect getClip(Size size, Offset? offset, double? sizeRate) {
    return Rect.fromCircle(
      center: offset!,
      radius: lerpDouble(0, _calcMaxRadius(size, offset), sizeRate!)!,
    );
  }

  bool shouldReclip(CustomClipper<Rect> oldClipper, Offset? offset, double? sizeRate) {
    return true;
  }

  static double _calcMaxRadius(Size size, Offset center) {
    final w = max(center.dx, size.width - center.dx);
    final h = max(center.dy, size.height - center.dy);
    return sqrt(w * w + h * h);
  }
}
