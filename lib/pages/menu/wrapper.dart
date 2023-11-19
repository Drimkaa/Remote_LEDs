import 'package:flutter/material.dart';
import 'package:remote_leds/components/app_bar/appbar.dart';
import 'package:remote_leds/components/bottom_navigation.dart';

import 'package:provider/provider.dart';
import 'package:remote_leds/components/color_model/LEDController.dart';


import '../settings/settings_page.dart';

class PageWrapper extends StatefulWidget {
  const PageWrapper({super.key});
  static const String id = 'main_screen';

  @override
  _PageWrapper createState() => _PageWrapper();
}

class _PageWrapper extends State<PageWrapper> with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));

  }

  int currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  Widget icon = const Icon(Icons.light_mode_outlined);
  @override
  Widget build(BuildContext context) {
    return

      Consumer<BottomRoutesModel>(builder: (context, page, child) {
      return WillPopScope(
        onWillPop: () async {
          page.lastPage();
          return false;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0), // here the desired height
            child: Consumer<AppBarModel>(builder: (context, appBar, child) {
              return appBar.current;
            }),
          ),
          body: page.currentPage,
          extendBody: true,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: page.bottomIndex == -1 ? 0 : page.bottomIndex,

              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              iconSize: 32,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: page.changeByIndex,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_remote_rounded),
                  label: 'Главная',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.palette_outlined),
                  label: 'Список',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb_circle_outlined),
                  label: 'Режим',
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
