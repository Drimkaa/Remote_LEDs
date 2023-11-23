import 'package:flutter/material.dart';

class RainbowAnimation extends StatefulWidget {
   const RainbowAnimation({super.key, required this.colors, this.duration = const Duration(seconds: 0, milliseconds: 200)});
   final List<Color> colors;
   final Duration duration;
  @override
  State<StatefulWidget> createState() => _RainbowAnimation();
}

class _RainbowAnimation extends State<RainbowAnimation> with SingleTickerProviderStateMixin {
  late List<Color> gradient;
  List<double> stops = List<double>.generate(4, (index) => index / (4 - 1) * 4);
  late Animation<double> animation;
  late AnimationController controller = AnimationController(vsync: this, duration: widget.duration);

  @override
  void initState() {
    super.initState();
    int length = widget.colors.length;
    stops = List<double>.generate(length * 2, (index) => index / (length * 2 - 1) * 4);
    double step = 4 / (length * 2 - 1);
    double animationBegin = 0 - (step / 2) * (length - 1);
    double animationEnd = -4 + (step / 2) * (length - 1);
    gradient = [...widget.colors, ...widget.colors];
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: gradient, stops: stops.map((s) => s + animation.value).toList())),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
