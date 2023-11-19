import 'package:flutter/material.dart';

class MainPageModel with ChangeNotifier {
  bool _status = false;
  bool get status => _status;
  set status(bool status) {
    _status = status;
    notifyListeners();}
 double _sliderValue = 30;
  int _lampValue = 30;
  int get lampValue => _lampValue;

  set sliderValue(double value) {
    if(status){
      _sliderValue = value;
      _lampValue=value.toInt();
      notifyListeners();
    }
  }
  double get sliderValue => _sliderValue;
}