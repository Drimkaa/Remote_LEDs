
import 'clippers/theme_switcher_clipper.dart';
import 'theme_provider.dart';
import 'package:flutter/material.dart';

typedef ChangeTheme = void Function(ThemeData theme);
typedef BuilderWithSwitcher = Widget Function(
    BuildContext, ThemeSwitcherState switcher);
typedef BuilderWithTheme = Widget Function(
    BuildContext, ThemeSwitcherState switcher, ThemeData theme);

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    super.key,
    this.clipper = const ThemeSwitcherClipper(),
    required this.builder,
  });

  factory ThemeSwitcher.switcher({
    Key? key,
    clipper = const ThemeSwitcherClipper(),
    required BuilderWithSwitcher builder,
  }) =>
      ThemeSwitcher(
        key: key,
        clipper: clipper,
        builder: (ctx) => builder(ctx, ThemeSwitcher.of(ctx)),
      );

  factory ThemeSwitcher.withTheme({
    Key? key,
    clipper = const ThemeSwitcherClipper(),
    required BuilderWithTheme builder,
  }) =>
      ThemeSwitcher.switcher(
        key: key,
        clipper: clipper,
        builder: (ctx, s) =>
            builder(ctx, s, ThemeModelInheritedNotifier.of(ctx).theme),
      );

  final Widget Function(BuildContext) builder;
  final ThemeSwitcherClipper clipper;

  @override
  ThemeSwitcherState createState() => ThemeSwitcherState();

  static ThemeSwitcherState of(BuildContext context) {
    final inherited =
    context.dependOnInheritedWidgetOfExactType<_InheritedThemeSwitcher>()!;
    return inherited.data;
  }
}

class ThemeSwitcherState extends State<ThemeSwitcher> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _InheritedThemeSwitcher(
      data: this,
      child: Builder(
        key: _globalKey,
        builder: widget.builder,
      ),
    );
  }

  void changeTheme({required ThemeData theme, bool isReversed = false}) {
    ThemeModelInheritedNotifier.of(context).changeTheme(
      theme: theme,
      key: _globalKey,
      clipper: widget.clipper,
      isReversed: isReversed,
    );
  }
}

class _InheritedThemeSwitcher extends InheritedWidget {
  final ThemeSwitcherState data;

  const _InheritedThemeSwitcher({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedThemeSwitcher oldWidget) {
    return true;
  }
}