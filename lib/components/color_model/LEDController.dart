
import 'package:flutter/material.dart';
import 'package:remote_leds/components/color_model/LEDModesPage.dart';

import 'LEDMode.dart';

export "LEDMode.dart";

enum PageStatus {
  browse,
  edit,
}
class LEDControlModel with ChangeNotifier {
  bool _isOn;
  int _brightness;
  UniqueKey key;
  LEDModeModel? _selectedMode;
  UniqueKey? _selectedModeKey;
  List<LEDModeModel> _activeModes = [];
  List<LEDModeModel> _inactiveModes = [];
  List<LEDModeModel> _modes = [];
  PageStatus _pageStatus = PageStatus.browse;
  PageStatus get pageStatus=>_pageStatus;
  set pageStatus(PageStatus status) {_pageStatus = status;notifyListeners();}
  get modes => _modes;
  LEDControlModel({
    bool isOn = false,
    int brightness = 255,
    List<LEDModeModel>? modes,

  })  : _isOn = isOn,
        _brightness = brightness,
        _modes = modes??[],
  key = UniqueKey();

  bool get isOn => _isOn;
  set isOn(bool value) {_isOn = value;notifyListeners();}

  int get brightness => _brightness;
  set brightness(int value) {_brightness = value;notifyListeners();}

  List<LEDModeModel> get activeModes => _activeModes;
  set activeModes(List<LEDModeModel> value) {_activeModes = value;notifyListeners();}
  get inactiveModes =>_inactiveModes;

  List<LEDModeForPage> get activeModesPage => List<LEDModeForPage>.from(activeModes.map((e) => LEDModeForPage(e)));
  List<LEDModeForPage> get inactiveModesPage =>  List<LEDModeForPage>.from(inactiveModes.map((e) => LEDModeForPage(e)));
  List<LEDModeForPage> get modesPage =>  List<LEDModeForPage>.from(modes.map((e) => LEDModeForPage(e)));
  LEDModeModel? get selectedMode => _selectedMode;
  set selectedMode(LEDModeModel? value) {_selectedMode = value;notifyListeners();}

  addSelectedMode(){
    if(_selectedMode!=null) {
      _modes.add(_selectedMode!);
    }
    notifyListeners();
  }
  deleteSelectedMode(){
    if(_selectedMode!=null){
      _modes.removeWhere((element) => element.key==_selectedMode?.key);
      _activeModes.removeWhere((element) => element.key==_selectedMode?.key);
    }
    notifyListeners();
  }
  addActiveMode(LEDModeModel mode){
    _activeModes.add(mode);
    if(!_modes.contains(mode)){
      _modes.add(mode);

    }
    notifyListeners();
  }
  addActiveToInactive(LEDModeModel activeMode){
    print("добавил активный в неактивный");
    _inactiveModes.insert(0, activeMode);
    _activeModes.removeWhere((element) => element.key == activeMode.key);
    notifyListeners();
  }
  addActivePageModelToInactive(LEDModeForPage activeMode){
    print("добавил активный в неактивный");
    _inactiveModes.insert(0, activeMode.model);
    _activeModes.removeWhere((element) => element.key == activeMode.model.key);
    notifyListeners();
  }
  addInactivePageModeToActive(LEDModeForPage inactiveMode){
    print("добавил неактивный в активный");
    _activeModes.insert(0, inactiveMode.model);
    _inactiveModes.removeWhere((element) => element.key == inactiveMode.model.key);
    notifyListeners();
  }
  // Method to add a new mode
  addNewMode(LEDModeModel mode) {
    _modes.add(mode);
    _inactiveModes.add(mode);
    notifyListeners();
  }
  deleteMode(LEDModeModel mode) {
    _modes.removeWhere((element) => element.key==mode.key);
    _activeModes.removeWhere((element) => element.key==mode.key);
    _inactiveModes.removeWhere((element) => element.key==mode.key);
    notifyListeners();
  }

  editMode(LEDModeModel mode) {
    int index = _modes.indexWhere((element) => element.key==mode.key);
    if(index>=0){_modes[index] = mode;}
    index = _activeModes.indexWhere((element) => element.key==mode.key);
    if(index>=0){_activeModes[index] = mode;}
    index = _inactiveModes.indexWhere((element) => element.key==mode.key);
    if(index>=0){_inactiveModes[index] = mode;}
    notifyListeners();
  }
}