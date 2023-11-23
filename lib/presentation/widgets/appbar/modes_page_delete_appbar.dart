import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/presentation/screens/main/pages/modes_page/modes_page_presenter.dart';
import 'package:remote_leds/presentation/widgets/icon_button.dart';

class ModesPageDeleteModeAppBar extends StatefulWidget {
  const ModesPageDeleteModeAppBar({super.key, required this.moveBack, required this.selectAll});
  final void Function() moveBack;
  final void Function() selectAll;
  @override
  State<StatefulWidget> createState() => _ModesPageDeleteModeAppBar();
}

class _ModesPageDeleteModeAppBar extends State<ModesPageDeleteModeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            iconData: Icons.arrow_back_rounded,
            iconSize: 24,
            onPressed: () => widget.moveBack(),
          ),
          Consumer<ModesPageModel>(
            builder: (context, model, child) => Text(
              "Выбрано (${model.selectedToDelete})",

            ),
          ),
          CustomIconButton(
            iconData: Icons.select_all,
            iconSize: 24,
            onPressed: () => widget.selectAll(),
          ),
        ],
      ),
    );
  }
}
