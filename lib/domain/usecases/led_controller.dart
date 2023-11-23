
import 'package:flutter/material.dart';
import 'package:remote_leds/domain/usecases/led_mode.dart';

export 'package:remote_leds/domain/usecases/led_mode.dart';

enum PageStatus {
  browse,
  edit,
}
class LEDControllerModel with ChangeNotifier {
  bool _isOn;
  int _brightness;
  UniqueKey key;
  List<LEDModeModel> modeList;
  PageStatus _pageStatus = PageStatus.browse;
  PageStatus get pageStatus=>_pageStatus;
  set pageStatus(PageStatus status) {_pageStatus = status;notifyListeners();}
  LEDControllerModel({
    bool isOn = false,
    int brightness = 255,
    required this.modeList,

  })  : _isOn = isOn,
        _brightness = brightness,
        key = UniqueKey();

  bool get isOn => _isOn;
  set isOn(bool value) {_isOn = value;notifyListeners();}

  int get brightness => _brightness;
  set brightness(int value) {_brightness = value;notifyListeners();}

  LEDModeModel selectedMode = LEDModeModel();

  editMode(LEDModeModel mode) {
    int index = modeList.indexWhere((element) => element.key==mode.key);
    if(index>=0){modeList[index] = mode;}
    notifyListeners();
  }
  deleteMode(LEDModeModel mode) {
    modeList.removeWhere((element) => element.key==mode.key);
    notifyListeners();
  }
  // Method to add a new mode

}