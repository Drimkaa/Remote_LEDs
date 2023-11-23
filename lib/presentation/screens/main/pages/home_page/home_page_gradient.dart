import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class HomePageGradient extends StatefulWidget {
  const HomePageGradient({super.key, required this.width, required this.brightness});
  final int brightness;
  final double width;
  @override
  State<StatefulWidget> createState() => _HomePageGradient();
}

class _HomePageGradient extends State<HomePageGradient> with SingleTickerProviderStateMixin {
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyanAccent,
    Colors.blue,
    Colors.purple,
  ];
  late List<Color> colors;
  List<double> _stops = List<double>.generate(16, (index) => index * 0.2 - 0.4);
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    colors = [..._colors, ..._colors];
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _stops = List<double>.generate(_colors.length * 2, (index) => index / (_colors.length * 2 - 1) * 4);
    double step = 4 / (_colors.length * 2 - 1);
    double animationBegin = 0 - (step / 2) * (_colors.length - 1);
    double animationEnd = -4 + (step / 2) * (_colors.length - 1);
    animation = Tween<double>(begin: animationBegin, end: animationEnd).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    animation.addListener(() {
      setState(() {});
    });
    controller.forward();
    init();
  }

  void init() async {}
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double temp = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 1.2,
      height: (widget.width / 3 * 1.5),
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 250, 250).withOpacity(widget.brightness / 100),
        borderRadius: BorderRadius.circular(widget.width / 6),
        gradient: LinearGradient(colors: colors, stops: _stops.map((s) => s + animation.value).toList()),
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: const SizedBox(),
      ),
    );
  }
}
