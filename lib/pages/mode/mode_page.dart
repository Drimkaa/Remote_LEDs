//context.watch<TodayModel?>();
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:remote_leds/components/app_bar/appbar.dart';
import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/pages/mode/BrowsePageType.dart';


class ModePage extends StatefulWidget {
  const ModePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ModePage();
}

class _ModePage extends State<ModePage> {
  @override
  initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).set(AppBarType.mode);
    Provider.of<LEDControlModel>(context, listen: false).addActiveMode(LEDModeModel(colors: [Colors.orange]));
  }

  void init() async {}
  @override
  void dispose() {
    super.dispose();
  }

  changedColors(List<Color> colors) {}
  @override
  Widget build(BuildContext context) {
    //context.watch<AppBarModel>().set(AppBarType.mode);
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BrowsePage(),
        SizedBox(
          height: 76,
        )
      ],
    ));
  }
}
