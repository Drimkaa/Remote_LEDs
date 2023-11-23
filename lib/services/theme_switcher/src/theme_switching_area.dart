import 'package:flutter/material.dart';

import 'clippers/theme_switcher_clipper_bridge.dart';
import 'theme_provider.dart';

class ThemeSwitchingArea extends StatelessWidget {
  const ThemeSwitchingArea({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final model = ThemeModelInheritedNotifier.of(context);
    // Widget resChild;
    Widget child;
    if (model.oldTheme == null || model.oldTheme == model.theme) {
      child = _getPage(model.theme);
    } else {
      late final Widget firstWidget, animWidget;
      if (model.isReversed) {
        firstWidget = _getPage(model.theme);
        animWidget = RawImage(
          image: model.image,
          isAntiAlias: true,
        );
      } else {
        firstWidget = RawImage(image: model.image);
        animWidget = _getPage(model.theme);
      }
      child = Stack(
        children: [
          Container(
            key: const ValueKey('ThemeSwitchingAreaFirstChild'),
            child: firstWidget,
          ),
          AnimatedBuilder(
            key: const ValueKey('ThemeSwitchingAreaSecondChild'),
            animation: model.controller,
            child: animWidget,
            builder: (_, child) {
              return ClipOval(
                clipper: ThemeSwitcherClipperBridge(
                  clipper: model.clipper,
                  offset: model.switcherOffset,
                  sizeRate: model.controller.value,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: child,
              );
            },
          ),
        ],
      );
    }

    return Material(child: child);
  }

  Widget _getPage(ThemeData brandTheme) {
    return Theme(
      key: const ValueKey('ThemeSwitchingAreaPage'),
      data: brandTheme,
      child: child,
    );
  }
}
