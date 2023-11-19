import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class FireAnimation extends StatefulWidget {
  FireAnimation({super.key,required this.colors, this.time =const Duration(seconds: 0,milliseconds: 200)});
  List<Color> colors;
  Duration time;

  @override
  State<StatefulWidget> createState() => _FireAnimationState();
}

class _FireAnimationState extends State<FireAnimation> {
  late Timer _timer;
  late HSLColor baseHSL;
  late double baseHue;
  late double baseLightness;
  late double baseSaturation;
  List<Color> _colors = [];


  late Duration duration = widget.time;

  int range = 30;

  Random random = Random();

  late double hue;
  late double lightness;
  bool add = false;
  @override
  void initState() {
    super.initState();
    baseHSL = HSLColor.fromColor(widget.colors[0]);
    baseHue = baseHSL.hue;
    baseLightness = baseHSL.lightness;
    baseSaturation = baseHSL.saturation;
    _colors = [
      getColor(),
      getColor(),
      getColor(),
      getColor()
    ];
    _timer = Timer.periodic(duration~/10, _updateTimer);
  }

  void updateColors() {
    setState(() {
      _colors = [
        getColor(),
        getColor(),
        getColor(),
        getColor()
      ];
    });
  }
  Color getColor(){
    hue = (baseHue + random.nextInt(range)) % 360;
    lightness = random.nextDouble() / 100 + 0.5 + (add?0.05:-0.05);
    add =!add;
    return HSLColor.fromAHSL(1.0, hue, baseSaturation,lightness ).toColor();
  }
  void _updateTimer(Timer timer) {
    updateColors();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(gradient: LinearGradient(colors: _colors)),
      duration: duration~/10,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
