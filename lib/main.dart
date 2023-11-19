import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/components/app_bar/appbar.dart';
import 'package:remote_leds/components/bottom_navigation.dart';
import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/components/color_model/LEDModesPage.dart';
import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/pages/connect/connect_page_model.dart';
import 'package:remote_leds/pages/main/main_page_model.dart';

import 'package:remote_leds/services/theme/theme.dart';
import 'package:remote_leds/services/theme_switcher/animated_theme_switcher.dart';

import 'services/sclaed_route/scaled_route.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  final themeService = await ThemeService.instance;

  var initTheme = themeService.initial;
  runApp(MyApp(theme: initTheme));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.theme}) : super(key: key);
  final ThemeData theme;
  // This widget is the root of your application.
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
              ChangeNotifierProvider<PageModel>(create: (context) => PageModel()),
              ChangeNotifierProvider<BottomRoutesModel>(create: (context)=>BottomRoutesModel()),
              ChangeNotifierProvider<MainPageModel>(create: (context) => MainPageModel()),
              ChangeNotifierProvider<ConnectPageModel>(create: (context) => ConnectPageModel()),
              ChangeNotifierProvider<LEDControlModel>(create: (context) => LEDControlModel()),
              ],
            child:  ThemeSwitchingArea(child:
            Consumer<PageModel>(builder: (context, page, child) {
              return  page.current;
            }),

            ),
          ),
        );
      },
    );
  }
}