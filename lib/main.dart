import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/domain/usecases/led_controller.dart';
import 'package:remote_leds/presentation/screens/connect/connect_presenter.dart';
import 'package:remote_leds/presentation/screens/edit/edit_presenter.dart';
import 'package:remote_leds/presentation/screens/main/main_presenter.dart';
import 'package:remote_leds/presentation/screens/main/pages/home_page/home_page_presenter.dart';
import 'package:remote_leds/presentation/screens/main/pages/modes_page/modes_page_presenter.dart';
import 'package:remote_leds/presentation/screens/screen_presenter.dart';
import 'package:remote_leds/presentation/widgets/appbar/appbar.dart';
import 'package:remote_leds/services/theme/theme.dart';
import 'package:remote_leds/services/theme_switcher/animated_theme_switcher.dart';

void main() async {
  final themeService = await ThemeService.instance;

  var initTheme = themeService.initial;
  runApp(MyApp(theme: initTheme));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.theme});
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      builder: (context, theme) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        return MaterialApp(
          title: 'Remote LEDs',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: MultiProvider(
            providers: [
              ChangeNotifierProvider<AppBarModel>(create: (context) => AppBarModel()),
              ChangeNotifierProvider<ModesPageModel>(create: (context) => ModesPageModel()),
              ChangeNotifierProvider<ScreenModel>(create: (context) => ScreenModel()),
              ChangeNotifierProxyProvider2<ModesPageModel, ScreenModel, EditScreenModel>(
                create: (context) => EditScreenModel(),
                lazy: false,
                update: (context, ledModeListPage, screenModel, editScreenModel) => editScreenModel!
                  ..setListPageModel(ledModeListPage)
                  ..setScreenModel(screenModel),
              ),
              ChangeNotifierProxyProvider2<ScreenModel, AppBarModel, ModesPageModel>(
                create: (context) => ModesPageModel(),
                lazy: false,
                update: (context, screenModel, appBarModel, editScreenModel) => editScreenModel!
                  ..setScreenModel(screenModel)
                  ..setAppBarModel(appBarModel),
              ),
              ChangeNotifierProvider<HomePageModel>(create: (context) => HomePageModel()),
              ChangeNotifierProvider<MainScreenModel>(create: (context) => MainScreenModel()),
              ChangeNotifierProvider<ConnectPageModel>(create: (context) => ConnectPageModel()),
              ChangeNotifierProvider<LedController>(create: (context) => LedController(modeList: [])),
            ],
            child: ThemeSwitchingArea(
              child: Consumer<ScreenModel>(builder: (context, page, child) {
                return page.current;
              }),
            ),
          ),
        );
      },
    );
  }
}
