import 'package:flutter/material.dart';
import 'package:remote_leds/pages/connect/connect_page.dart';
import 'package:remote_leds/pages/menu/wrapper.dart';
import 'package:remote_leds/pages/settings/settings_page.dart';

class Page{
  int id;
  Widget page;
  Page(this.page, this.id);
}
enum PagesEnum{
  settings,
  wrapper,
}
class PageModel extends ChangeNotifier {


  Widget _currentPage = const ConnectPage();
  Widget get current => _currentPage;
  late Widget _lastPage;

  void setPage(Widget page){
    _lastPage = _currentPage;
    _currentPage = page;
    notifyListeners();
  }
  void setPageFromEnum(PagesEnum pagesEnum){
    if(pagesEnum == PagesEnum.settings){
      setPage(const SettingsPage());
    } else if(pagesEnum==PagesEnum.wrapper){
      setPage( const PageWrapper());
    }
  }
  void back(){
    Widget temp = _currentPage;
    _currentPage = _lastPage;
    _lastPage = temp;

    notifyListeners();
  }
}