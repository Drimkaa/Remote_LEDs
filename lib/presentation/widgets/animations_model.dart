import 'package:flutter/cupertino.dart';
import 'package:remote_leds/domain/constants/strip_modes.dart';

class AnimationModel with ChangeNotifier{
  List<Color> _colors = [];
   StripModes _mode;
  Duration _duration;

  AnimationModel(List<Color> colors,StripModes mode,Duration duration):
  _colors=colors,_mode=mode,_duration=duration;
  List<Color> get colors =>_colors;
  set colors(List<Color> colors) {
    _colors = colors;
    notifyListeners();
  }
  StripModes get mode =>_mode;
  set mode(StripModes mode) {
    _mode = mode;
    notifyListeners();
  }

  Duration get duration =>_duration;
  set duration(Duration duration) {
    _duration = duration;
    notifyListeners();
  }
}