import 'package:flutter/material.dart';

import 'LEDMode.dart';
enum LEDModeForPageStatus {
  pressed,
  unpressed
}

class LEDModeForPage with ChangeNotifier{
 LEDModeModel model;
 bool isToDelete = false;
 LEDModeForPageStatus _status = LEDModeForPageStatus.unpressed;
 LEDModeForPageStatus get  status =>_status;
 set status(LEDModeForPageStatus status) =>{ _status=status,notifyListeners()};
 LEDModeForPage(this.model);
}