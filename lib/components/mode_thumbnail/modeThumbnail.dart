import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:remote_leds/components/app_bar/appbar.dart';
import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/constants/constants.dart';
import 'package:remote_leds/constants/iconButton.dart';
import 'package:remote_leds/pages/modeEditor/ModeEditor.dart';

class ModeThumbnail extends StatefulWidget {
  const ModeThumbnail({Key? key, required this.model}) : super(key: key);
  final LEDModeModel model;
  @override
  State<StatefulWidget> createState() => _ModeThumbnail();
}

class _ModeThumbnail extends State<ModeThumbnail> {
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
    //context.watch<AppBarModel>().set(AppBarType.mode);
    return Container(
      padding: padding8,
      decoration: decorationRadius(16, lightGrayColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.model.name,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stringLEDMode(widget.model.mode),
                    textScaleFactor: 1.25,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1),
                  ),
                ],
              ),
              CustomIconButton(
                onPressed: () {context.read<PageModel>().setPage(ModeEditor(mode: widget.model, type: PickerType.edit,));},
                iconData: Icons.edit,
                iconSize: 32,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  decoration: decorationRadius(16, const Color(0xFF35373d)),
                  padding: padding4,
                  child: Wrap(
                    spacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "${widget.model.zoneStart.toString()} - ${widget.model.zoneEnd.toString()}",
                        style: const TextStyle(height: 1),
                      ),
                      const Icon(Icons.linear_scale_rounded, size: 16),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  decoration: decorationRadius(16, const Color(0xFF35373d)),
                  padding: padding4,
                  child: Wrap(
                    spacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        widget.model.speed.toString(),
                        style: const TextStyle(height: 1),
                      ),
                      const Icon(Icons.timer_outlined, size: 16),
                    ],
                  ),
                ),
              ]),
              Flexible(
                child: Container(
                    constraints: const BoxConstraints(minWidth: 0),
                decoration: decorationRadius(16, const Color(0xFF35373d)),
                padding: padding4,
                child:SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(var i = 0;i<widget.model.colors.length;i++) ...[_buildColorCircle(context, widget.model.colors[i]),
                    if(i!=widget.model.colors.length-1) const SizedBox(width: 4,)]

                  ],
                ),
              ))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(BuildContext context, Color color) {
    return  Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),

    );
  }
}
