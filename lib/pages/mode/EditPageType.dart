import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/components/app_bar/appbar.dart';

import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/components/color_model/LEDModesPage.dart';
import 'package:remote_leds/components/mode_thumbnail/modeThumbnailWithEdit.dart';


class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditPage();
}

class _EditPage extends State<EditPage> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
    init();
  }

  List<LEDModeForPage> modes = [];

  void init() {}
  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).setAppBar(
        AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.all(0),
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(Icons.arrow_back, size: 24),
                    onPressed: () {
                      Provider.of<LEDControlModel>(context, listen: false).pageStatus = PageStatus.browse;
                    },
                  ),
                ],
              ),
               Text("Редактор"),

            ],
          ),
        )
    );

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
    modes = Provider.of<LEDControlModel>(context, listen: true).modesPage;

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 32,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 4),
          child: const Text(
            "Доступные режимы (редактирование)",
            textScaleFactor: 1.25,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.greenAccent),
          ),
        ),
        for (var i = 0; i < modes.length; i++) ...[
          ModeThumbnailWithEdit(model: modes[i]),
          if(i != modes.length-1) const SizedBox(height: 8,)
        ],
      ],
    );
  }
}
