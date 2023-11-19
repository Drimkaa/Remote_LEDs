import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:remote_leds/components/app_bar/appbar.dart';
import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/components/color_model/LEDModesPage.dart';

import 'package:remote_leds/components/mode_thumbnail/modeThumbnail.dart';

class ModeThumbnailWithDraggable extends StatefulWidget {
  const ModeThumbnailWithDraggable({Key? key, required this.model,required this.type}) : super(key: key);
  final LEDModeForPage model;
  final BlockStatus type;
  @override
  State<StatefulWidget> createState() => _ModeThumbnailWithDraggable();
}
enum BlockStatus { active, inactive }
class _ModeThumbnailWithDraggable extends State<ModeThumbnailWithDraggable> {
  @override
  initState() {
    super.initState();
    init();
  }

  void init() async {}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color;

    Widget childWhenDragging = Container();
    switch (widget.type) {
      case BlockStatus.active:
        Provider.of<LEDControlModel>(context, listen: false).activeModes.length == 0;
        childWhenDragging = const SizedBox(
          height: 81,
        );
        color = const Color(0x634B5D46);
        break;
      case BlockStatus.inactive:
        Provider.of<LEDControlModel>(context, listen: false).inactiveModes.length == 0;
        childWhenDragging = const SizedBox(
          height: 81,
        );
        color = const Color(0x635D4646);
        break;
    }
    return
       Center(child:AnimatedContainer(
          duration: const Duration(milliseconds: 50),

          width:widget.model.status==LEDModeForPageStatus.pressed ? MediaQuery.of(context).size.width - 64 : MediaQuery.of(context).size.width - 32,

          child: LongPressDraggable<LEDModeForPage>(
            data: widget.model,
            feedback: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 32,
                padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 12),
                decoration: BoxDecoration(
                  color: color,
                  border: Border.all(color: Colors.white38, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                )),
            childWhenDragging: childWhenDragging,
            child: ModeThumbnail(model:widget.model.model)
          ),
        ),
      );


  }


}
