import 'package:flutter/material.dart';
import 'package:remote_leds/services/theme/config.dart';
import 'package:remote_leds/services/theme/theme.dart';
import 'package:remote_leds/services/theme_switcher/src/theme_provider.dart';
import 'package:remote_leds/services/theme_switcher/src/theme_switcher.dart';

class SchemeSwitcher extends StatefulWidget {
  const SchemeSwitcher({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SchemeSwitcher();
}

class _SchemeSwitcher extends State<SchemeSwitcher> {
  @override
  void initState() {
    super.initState();
  }

  changeColor(BuildContext context) async {
    final themeSwitcher = ThemeSwitcher.of(context);
    final themeName = ThemeModelInheritedNotifier.of(context).theme.brightness == Brightness.light ? 'dark' : 'light';

    final service = await ThemeService.instance
      ..save(themeName);
    final theme = service.getByName(themeName);
    themeSwitcher.changeTheme(theme: theme, isReversed: themeName == "dark" ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).extension<MyColors>()!.dayCard ?? Color(0xffffffff),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Theme.of(context).extension<MyColors>()!.dayCardBorder ?? Color(0xffffffff), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Цветовая схема:",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            ThemeSwitcher.switcher(
              builder: (context, switcher) {
                return IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => changeColor(context),
                    icon: Theme.of(context).brightness == Brightness.light
                        ? const Icon(Icons.sunny, size: 32)
                        : const Icon(Icons.brightness_2_sharp, size: 32));
              },
            ),
          ],
        ));
  }
}
