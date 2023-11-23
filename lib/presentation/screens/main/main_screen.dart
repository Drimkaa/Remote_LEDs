import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/presentation/screens/main/main_presenter.dart';
import 'package:remote_leds/presentation/widgets/appbar/appbar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenModel>(builder: (context, page, child) {
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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: page.bottomIndex,
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
      );
    });
  }
}
