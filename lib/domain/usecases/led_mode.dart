import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/strip_modes.dart';
export 'package:remote_leds/domain/constants/strip_modes.dart';
class LEDModeModel with ChangeNotifier {
  final UniqueKey _key;
  get key => _key;
  LEDModeModel(
      {StripModes? mode,
        int speed = 1,
        List<int>? zone,
        List<Color>? colors,
        String? name,
         UniqueKey? key,
      }): _key = key ?? UniqueKey(),
        _mode = mode??StripModes.static,
        _speed = speed,
        _zone = zone ?? [],
        _name = name??"Новый режим",
        _colors = colors ?? [] ;
  StripModes _mode;
  int _speed;
  List<int> _zone;
  List<Color> _colors;
  String _name;
  int _colorLength = 1;
  int get colorLength => _colorLength;
  bool _isActive = false;
  bool get isActive=>_isActive;
  set isActive(bool isActive){
    _isActive = isActive;
    notifyListeners();
  }

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  StripModes get mode => _mode;
  set mode(StripModes value) {
    _mode = value;
    switch(_mode){
      case StripModes.static:
        _colorLength = 1;
        break;
      case StripModes.fading:
        _colorLength = 10;
        break;
      case StripModes.rainbow:
        _colorLength = 10;
        break;
      case StripModes.fire:
        _colorLength = 1;
        break;
      case StripModes.pulse:
        _colorLength = 10;
        break;
    }
    notifyListeners();
  }

  int get speed => _speed;
  set speed(int value) {
    _speed = value;
    notifyListeners();
  }

  List<int> get zone => _zone;
  int get zoneStart => _zone.isNotEmpty ? _zone[0] : 0;
  int get zoneEnd => _zone.isNotEmpty ? _zone.last : 300;
  setZone(int start, int end) {
    _zone = List<int>.generate(end - start+1, (i) => start + i);
    notifyListeners();
  }

  List<Color> get colors => _colors;
  set colors(List<Color> value) {
    _colors = value;
    notifyListeners();
  }
  deleteColor(int index){
    if(index<_colors.length && index>-1){
      _colors.removeAt(index);
      notifyListeners();
    }
  }
  changeColor(int index, Color color) {
    if(index<_colors.length && index>-1){
      _colors[index] = color;
    }
  }
  addColor(Color color){
    if(_colors.length<_colorLength){
      _colors.add(color);
      notifyListeners();
    }

  }
}

