import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/components/app_bar/appbar.dart';

import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/components/color_model/LEDModesPage.dart';
import 'package:remote_leds/components/mode_thumbnail/modeThumbnailWithDraggable.dart';
import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/constants/constants.dart';
import 'package:remote_leds/constants/iconButton.dart';
import 'package:remote_leds/pages/modeEditor/ModeEditor.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BrowsePage();
}

class _BrowsePage extends State<BrowsePage> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
    init();
  }

  List<LEDModeForPage> active = [];
  List<LEDModeForPage> inactive = [];

  void init() {}
  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).setAppBar(AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Режимы"),
          Row(
            children: [
              CustomIconButton(
                  onPressed: () {
                    context.read<PageModel>().setPage(ModeEditor(type: PickerType.add));
                  },
                  iconData: Icons.add_rounded),
            ],
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  changedColors(List<Color> colors) {
    print(colors);
  }

  @override
  Widget build(BuildContext context) {
    //context.watch<AppBarModel>().set(AppBarType.mode);
    active = Provider.of<LEDControlModel>(context, listen: true).activeModesPage;
    inactive = Provider.of<LEDControlModel>(context, listen: true).inactiveModesPage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DragTarget<LEDModeForPage>(onAccept: (data) {
          if (!active.contains(data)) {
            setState(() {
              Provider.of<LEDControlModel>(context, listen: false).addInactivePageModeToActive(data);
            });
          }
        }, builder: (_, List<dynamic> accepted, List<dynamic> rejected) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 4),
                child: Text(
                  "Активные режимы",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.greenAccent),
                ),
              ),
              if (active.isEmpty) const SizedBox(height: 81),
              for (var i = 0; i < active.length; i++) ...[
                ModeThumbnailWithDraggable(model: active[i], type: BlockStatus.active),
                if (i != active.length - 1) const SizedBox(
                  height: 8
                )
              ],
            ],
          );
        }),

        DragTarget<LEDModeForPage>(onAccept: (data) {
          if (!inactive.contains(data)) {
            setState(() {
              Provider.of<LEDControlModel>(context, listen: false).addActivePageModelToInactive(data);
            });
          }
        }, builder: (context, List<dynamic> accepted, List<dynamic> rejected) {
          return Opacity(
            opacity: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 4),
                  child: const Text("Неактивные",
                      textScaleFactor: 1.5, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                ),
                if (inactive.isEmpty) const SizedBox(height: 200),
                for (var i = 0; i < inactive.length; i++) ...[
                  ModeThumbnailWithDraggable(model: inactive[i], type: BlockStatus.inactive),
                  if (i != inactive.length - 1) const SizedBox(height: 8)
                ],
              ],
            ),
          );
        }),
      ],
    );
  }
}
