import 'package:flutter/material.dart';

import 'led_mode.dart';

class LEDModeList with ChangeNotifier {
  LEDModeModel? selectedMode;
  final List<LEDModeModel> _active;

  final List<LEDModeModel> _all;

  LEDModeList(List<LEDModeModel> active, List<LEDModeModel> all)
      : _active = active,
        _all = all;

  addNewMode(LEDModeModel mode) {
    _all.add(mode);
    notifyListeners();
  }

  deleteMode(LEDModeModel mode) {
    _all.removeWhere((element) => element.key == mode.key);
    _active.removeWhere((element) => element.key == mode.key);
    notifyListeners();
  }

  editMode(LEDModeModel mode) {
    int index = _all.indexWhere((element) => element.key == mode.key);
    if (index >= 0) {
      _all[index] = mode;
      print("нашел");
    }
    index = _active.indexWhere((element) => element.key == mode.key);
    if (index >= 0) {
      _active[index] = mode;
    }
    print("заменил");
    notifyListeners();
  }

  addActiveMode(LEDModeModel mode) {
    _active.add(mode);
    if (!_all.contains(mode)) {
      _all.add(mode);
    }
    notifyListeners();
  }

  List<LEDModeModel> get all => _all;
  List<LEDModeModel> get active => _active;
}
