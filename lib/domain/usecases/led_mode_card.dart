import 'package:flutter/material.dart';
import 'package:remote_leds/domain/usecases/led_mode.dart';

class LedModeCard with ChangeNotifier {
  LedMode model;
  LedModeCard(this.model);

  changeActive() {
    if (model.isActive) {
      model.isActive = false;
    } else {
      model.isActive = true;
    }
    notifyListeners();
  }

  changeDeleteStatus() {
    if (delete) {
      delete = false;
    } else {
      delete = true;
    }
    notifyListeners();
  }

  bool delete = false;
}
