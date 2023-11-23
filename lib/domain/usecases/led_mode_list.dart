import 'package:flutter/material.dart';

import 'led_mode.dart';

class LedModeList with ChangeNotifier {
  LedMode? selectedMode;
  final List<LedMode> _active;

  final List<LedMode> _all;

  LedModeList(List<LedMode> active, List<LedMode> all)
      : _active = active,
        _all = all;

  addNewMode(LedMode mode) {
    _all.add(mode);
    notifyListeners();
  }

  deleteMode(LedMode mode) {
    _all.removeWhere((element) => element.key == mode.key);
    _active.removeWhere((element) => element.key == mode.key);
    notifyListeners();
  }

  editMode(LedMode mode) {
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

  addActiveMode(LedMode mode) {
    _active.add(mode);
    if (!_all.contains(mode)) {
      _all.add(mode);
    }
    notifyListeners();
  }

  List<LedMode> get all => _all;
  List<LedMode> get active => _active;
}
