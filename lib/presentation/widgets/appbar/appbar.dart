import 'package:flutter/material.dart';

class AppBarModel extends ChangeNotifier {
  Widget _current = AppBar();
  setAppBar(Widget appBar) {
    _current = appBar;
    notifyListeners();
  }
  get current => _current;
  setCustomAppBar({required String text, IconData? iconData, double iconSize = 24}) {
    _current = customAppBar(text: text, iconData: iconData, iconSize: iconSize);
    notifyListeners();
  }
}

AppBar customAppBar({required String text, IconData? iconData, double iconSize = 24}) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        if (iconData != null) Icon(iconData, size: iconSize),
      ],
    ),
  );
}
