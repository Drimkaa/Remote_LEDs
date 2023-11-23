import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GradientAnimation extends StatefulWidget {
  const GradientAnimation({super.key,required this.colors, this.duration =const Duration(seconds: 0,milliseconds: 200)});
  final List<Color> colors;
  final Duration duration;

  @override
  State<StatefulWidget> createState() => _GradientAnimation();
}

class _GradientAnimation extends State<GradientAnimation> {
  late Timer _timer;
  late Color color = widget.colors[0];
  int counter = 1;
  late Duration duration = widget.duration;

  int range = 30;

  Random random = Random();

  late double hue;
  late double lightness;
  bool add = false;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(duration, _updateTimer);
  }

  void updateColors() {

    setState(() {

      if(counter>widget.colors.length-1){counter=0;}
      color = widget.colors[counter];
    });
    counter+=1;
  }

  void _updateTimer(Timer timer) {
    updateColors();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: color,
      duration: duration,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
