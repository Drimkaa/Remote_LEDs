

import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/strip_modes.dart';
import 'package:remote_leds/domain/constants/theme_extension.dart';
import 'package:remote_leds/presentation/widgets/animation/fire_animation.dart';
import 'package:remote_leds/presentation/widgets/animation/gradient_animation.dart';
import 'package:remote_leds/presentation/widgets/animation/pulse_animation.dart';
import 'package:remote_leds/presentation/widgets/animation/rainbow_animation.dart';
import 'package:remote_leds/presentation/widgets/animations_model.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({super.key, required this.model});

  final AnimationModel model;


  @override
  State<StatefulWidget> createState() => _AnimationWidget();
}

class _AnimationWidget extends State<AnimationWidget> {
  late Duration duration = widget.model.duration;
  late List<Color> colors= widget.model.colors;
  late StripModes mode= widget.model.mode;
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    if(widget.model.colors.isEmpty){
      return Container( color: Theme.of(context).extension<MyColors>()?.first??Colors.cyan);
    }
    switch (widget.model.mode) {
      case StripModes.static:
        return Container( color: widget.model.colors[0]);
      case StripModes.pulse:
        return PulseAnimation(key:GlobalKey(),colors: widget.model.colors, duration:  widget.model.duration);
      case StripModes.fading:
        return GradientAnimation(key:GlobalKey(),colors: widget.model.colors, duration:  widget.model.duration);
      case StripModes.fire:
        return FireAnimation(key:GlobalKey(),colors: widget.model.colors, duration:  widget.model.duration);
      case StripModes.rainbow:
        return RainbowAnimation(key:GlobalKey(),colors: widget.model.colors, duration:  widget.model.duration);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
