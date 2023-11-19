import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';

class RanbowAnimation extends StatefulWidget {
  RanbowAnimation({super.key,required this.colors, this.time =const Duration(seconds: 0,milliseconds: 200)});
  List<Color> colors;
  Duration time;
  @override
  State<StatefulWidget> createState() => _RanbowAnimation();
}

class _RanbowAnimation extends State<RanbowAnimation> with SingleTickerProviderStateMixin {
  late List<Color> gradient;
  List<double> stops  = List<double>.generate(4, (index) =>  index/(4-1)*4);
  Animation<double>? animation;
  late AnimationController controller = AnimationController(vsync: this, duration:  widget.time);

  @override
  void initState() {
    super.initState();
    int length = widget.colors.length;
    stops  = List<double>.generate(length*2, (index) =>  index/(length*2-1)*4);
    double step = 4/(length*2-1);
    double animationBegin = 0-(step/2)*(length-1);
    double animationEnd = -4+(step/2)*(length-1);
    gradient = [...widget.colors,...widget.colors];
    animation = Tween<double>(begin: animationBegin, end: animationEnd).animate(controller!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    animation?.addListener(() {setState(() {});});
    controller.forward();
    }



  @override
  Widget build(BuildContext context) {
    return   Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: gradient,
    stops: stops.map((s) => s + animation!.value).toList()
    )
    ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}