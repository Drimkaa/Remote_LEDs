import 'package:flutter/material.dart';
import 'package:remote_leds/pages/main/main_page.dart';
import 'package:remote_leds/pages/mode/mode_page.dart';
import 'package:remote_leds/pages/profile/profile_page.dart';



class BottomRoutesModel extends ChangeNotifier {
  static final List<Widget> _pageList = <Widget>[
    const MainPage(),
    const ModePage(),
    const ProfilePage(),
  ];

  int _lastIndex = 0;
  int bottomIndex = 0;
  Widget _currentPage = _pageList[0];
  Widget get currentPage => _currentPage;

  void changeByIndex(int index) {
    _lastIndex = bottomIndex;
    _currentPage = _pageList[index];
    bottomIndex = index;
    notifyListeners();
  }

  void lastPage() {
    _currentPage = _pageList[_lastIndex];
    notifyListeners();
  }
}