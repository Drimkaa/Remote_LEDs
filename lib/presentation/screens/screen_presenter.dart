import 'package:flutter/material.dart';
import 'package:remote_leds/presentation/screens/connect/connect_screen.dart';


class ScreenModel extends ChangeNotifier {


  Widget _currentPage = const ConnectPage();
  Widget get current => _currentPage;
  late Widget _lastPage;

  void setPage(Widget page){
    _lastPage = _currentPage;
    _currentPage = page;
    notifyListeners();
  }

  void back(){
    Widget temp = _currentPage;
    _currentPage = _lastPage;
    _lastPage = temp;

    notifyListeners();
  }
}