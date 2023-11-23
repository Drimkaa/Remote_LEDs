import 'package:flutter/cupertino.dart';
import 'package:remote_leds/presentation/screens/main/pages/current_mode_page/current_mode_page.dart';
import 'package:remote_leds/presentation/screens/main/pages/home_page/home_page.dart';
import 'package:remote_leds/presentation/screens/main/pages/modes_page/modes_page.dart';

class MainScreenModel extends ChangeNotifier {
  final List<Widget> _pages = [const HomePage(), const ModesPage(), const CurrentModePage()];
  int _lastIndex = 0;
  int bottomIndex = 0;
  late Widget _currentPage = _pages[0];

  Widget get currentPage => _currentPage;

  void changeByIndex(int index) {
    _lastIndex = bottomIndex;
    _currentPage = _pages[index];
    bottomIndex = index;
    notifyListeners();
  }

  void lastPage() {
    _currentPage = _pages[_lastIndex];
    notifyListeners();
  }
}
