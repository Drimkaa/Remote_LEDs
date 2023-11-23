import 'package:flutter/material.dart';
import 'package:remote_leds/presentation/widgets/icon_button.dart';

class ModesPageViewModeAppBar extends StatelessWidget {
  const ModesPageViewModeAppBar({super.key, required this.onTap});
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("Режимы"), CustomIconButton(onPressed: onTap, iconData: Icons.add_rounded)],
      ),
    );
  }
}
