import 'package:flutter/material.dart';
import 'package:remote_leds/components/app_bar/settings_appbar.dart';

import 'main_appbar.dart';
import 'mode_appbar.dart';
import 'current_mode_appbar.dart';
export 'main_appbar.dart';
export 'mode_appbar.dart';
export 'current_mode_appbar.dart';

enum AppBarType {
  mode,
  main,
  currentMode,
  settings
}

class AppBarModel with ChangeNotifier {
  static Widget modeAppBar = const ModeAppBar();
  static Widget mainAppBar = const MainAppBar();
  static Widget currentModeAppBar = const CurrentModeAppBar();
  static Widget settingsAppBar = const SettingsAppBar();
  setAppBar(AppBar wi){
    _current = wi;
    notifyListeners();
  }
  Widget _current =  MainAppBar();
  Widget get current => _current;

  set(AppBarType appBarType){
    switch(appBarType){
      case AppBarType.main:
        _current = mainAppBar;
        break;
      case AppBarType.mode:
        _current = modeAppBar;
        break;
      case AppBarType.currentMode:
        _current = currentModeAppBar;
        break;
      case AppBarType.settings:
        _current = settingsAppBar;
        break;
    }
    notifyListeners();
  }
}





