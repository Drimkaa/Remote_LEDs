import 'package:flutter/material.dart';

EdgeInsetsGeometry padding16 = const EdgeInsets.all(16);
EdgeInsetsGeometry padding8 = const EdgeInsets.all(8);
EdgeInsetsGeometry padding2 = const EdgeInsets.all(2);
EdgeInsetsGeometry padding4 = const EdgeInsets.all(4);
EdgeInsetsGeometry padding0 = const EdgeInsets.all(0);
ButtonStyle buttonStyle(Color color) => TextButton.styleFrom(
      foregroundColor: color,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
    );
Decoration decorationRadius(double radius, Color background) => BoxDecoration(
    color: background,
    borderRadius: BorderRadius.all(Radius.circular(radius))
);
Decoration decorationBorder(double radius, double width, Color border, Color background) => BoxDecoration(
    color: background,
    border: Border.all(color: border, width: width),
    borderRadius: BorderRadius.all(Radius.circular(radius))
);

Color greenColor = Colors.greenAccent;
Color redColor = Colors.redAccent;
Color orangeColor = Colors.amber[800]!;
Color lightGrayColor = Color(0xff2b2d30);
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color lightBlackColor = Color(0xff1e1f22);
/*Theme.of(context).copyWith(
splashColor: Colors.transparent,
highlightColor: Colors.transparent,
focusColor: Colors.transparent,
hoverColor: Colors.transparent);
*/