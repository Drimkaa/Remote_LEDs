import 'package:flutter/material.dart';
import 'package:remote_leds/presentation/widgets/icon_button.dart';

class ModesPageViewModeAppBar extends StatefulWidget {
  const ModesPageViewModeAppBar({super.key, required this.onTap});
  final void Function() onTap;
  @override
  State<StatefulWidget> createState() => _ModesPageViewModeAppBar();
}

class _ModesPageViewModeAppBar extends State<ModesPageViewModeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("Режимы"), CustomIconButton(onPressed: widget.onTap, iconData: Icons.add_rounded)],
      ),
    );
  }
}
