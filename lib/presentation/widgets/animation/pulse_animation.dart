import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class PulseAnimation extends StatefulWidget {
  const PulseAnimation({super.key,required this.colors, this.duration =const Duration(seconds: 0,milliseconds: 200)});
  final List<Color> colors;
  final Duration duration;

  @override
  State<StatefulWidget> createState() => _PulseAnimation();
}

class _PulseAnimation extends State<PulseAnimation> {
  late Timer _timer;
  late Color color = Colors.black12;
  int counter = 0;
  late Duration duration = widget.duration;

  int range = 30;

  Random random = Random();

  late double hue;
  late double lightness;
  bool add = false;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.duration, _updateTimer);
  }

  void updateColors() {

    setState(() {

      if(counter%2==0){
        if(counter~/2==widget.colors.length){counter=0;}
        color = widget.colors[counter~/2];
        duration = widget.duration;
        _timer.cancel();
        _timer = Timer.periodic(widget.duration, _updateTimer);
      } else {

        duration = const Duration(milliseconds: 1000);
        color = Colors.black12;
        _timer.cancel();
        _timer = Timer.periodic(const Duration(milliseconds: 1000), _updateTimer);
      }
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
