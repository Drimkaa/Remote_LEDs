import 'package:flutter/material.dart';

enum LEDMode {
  static,
  fading,
  rainbow,
  fire,
  pulse,
}

class LEDModeModel with ChangeNotifier {
  final UniqueKey _key;
  get key => _key;
  LEDModeModel(
     {LEDMode? mode,
    int speed = 1,
    List<int>? zone,
    List<Color>? colors,
       String? name,
  })  : _key = UniqueKey(),
        _mode = mode??LEDMode.static,
        _speed = speed,
        _zone = zone ?? [],
  _name = name??"Новый режим",
        _colors = colors ?? [];
  LEDMode _mode;
  int _speed;
  List<int> _zone;
  List<Color> _colors;
  String _name;
  int _colorLength = 1;
  int get colorLength => _colorLength;


  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  LEDMode get mode => _mode;
  set mode(LEDMode value) {
    _mode = value;
    switch(_mode){
      case LEDMode.static:
        _colorLength = 1;
        break;
      case LEDMode.fading:
        _colorLength = 10;
        break;
      case LEDMode.rainbow:
        _colorLength = 10;
        break;
      case LEDMode.fire:
        _colorLength = 1;
        break;
      case LEDMode.pulse:
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
    if(index<_colors.length){
      _colors.removeAt(index);
      notifyListeners();
    }
  }
  addColor(Color color){


    if(_colors.length<_colorLength){
      _colors.add(color);
      notifyListeners();
    }

  }
}
String stringLEDMode(LEDMode mode){
  switch(mode){
    case LEDMode.static:
      return "Статичный цвет";
    case LEDMode.fading:
      return "Градиент";
    case LEDMode.rainbow:
      return "Радуга";
    case LEDMode.fire:
      return "Огонь";
    case LEDMode.pulse:
      return "Пульсация";

  }
}
String stringLEDModeDescription(LEDMode mode){
  switch(mode){
    case LEDMode.static:
      return "Статичный цвет";
    case LEDMode.fading:
      return "Светодиоды медленно меняют яркость от максимума к минимуму и обратно, создавая приятный эффект плавного затухания и разгорания";
    case LEDMode.rainbow:
      return "Цвета радуги плавно двигаются по всей ленте, создавая красочный и яркий эффект.";
    case LEDMode.fire:
      return "Имитация пламени, где светодиоды мигают и изменяют цветы, чтобы создать видимость огня.";
    case LEDMode.pulse:
      return "Свет светодиодов пульсирует внутри каждого участка, создавая визуально завораживающий эффект.";
  }
}
