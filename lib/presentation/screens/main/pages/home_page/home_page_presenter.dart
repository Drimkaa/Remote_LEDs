import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/home_mode.dart';

export 'package:remote_leds/domain/constants/home_mode.dart';

class HomePageModel with ChangeNotifier {
  bool _status = false;
  bool get status => _status;
  set status(bool status) {
    _status = status;
    notifyListeners();
  }

  HomeMode _mode = HomeMode.list;
  HomeMode get mode => _mode;
  set mode(HomeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  changeMode() {
    if (_mode == HomeMode.list) {
      _mode = HomeMode.mode;
    } else if (_mode == HomeMode.mode) {
      _mode = HomeMode.list;
    }
    notifyListeners();
  }

  void changeStatus() {
    _status = !_status;
    notifyListeners();
  }

  double _sliderValue = 30;
  int _lampValue = 30;
  int get lampValue => _lampValue;

  set sliderValue(double value) {
    if (status) {
      _sliderValue = value;
      _lampValue = value.toInt();
      notifyListeners();
    }
  }

  double get sliderValue => _sliderValue;
}
