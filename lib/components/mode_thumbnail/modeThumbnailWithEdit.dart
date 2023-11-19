import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:remote_leds/components/color_model/LEDModesPage.dart';
import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/pages/modeEditor/ModeEditor.dart';
import 'package:remote_leds/components/mode_thumbnail/modeThumbnail.dart';
import 'dart:ui' as ui;

class ModeThumbnailWithEdit extends StatefulWidget {
  const ModeThumbnailWithEdit({super.key, required this.model});
  final LEDModeForPage model;

  @override
  State<StatefulWidget> createState() => _ModeThumbnailWithEdit();
}

enum BlockStatus { active, inactive }

class _ModeThumbnailWithEdit extends State<ModeThumbnailWithEdit> {
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
    return GestureDetector(
      onLongPress: () => {
        setState(() {
          widget.model.isToDelete = !widget.model.isToDelete;
        })
      },
      onTap: () => {
        if (widget.model.isToDelete) {
            setState(() {widget.model.isToDelete = false;})
          } else {
            context.read<PageModel>().setPage(ModeEditor(mode: widget.model.model, type: PickerType.edit,))
          }
      },
      child: Center(
        child: AnimatedContainer(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.transparent,
          ),
          duration: const Duration(milliseconds: 50),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ModeThumbnail(model: widget.model.model),
              if (widget.model.isToDelete)
                BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Выбрано", textScaleFactor: 2, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                        Icon(Icons.check_circle_outline_rounded, color: Colors.red, size: 32)
                      ],
                    ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
