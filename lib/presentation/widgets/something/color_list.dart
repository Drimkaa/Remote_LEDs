import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:remote_leds/domain/entities/picker_type.dart';
import 'dart:ui' as ui;
class ColorList extends StatefulWidget {
  const ColorList({super.key, required this.colors, required this.change, required this.colorLength});
  final void Function(List<Color> colors) change;
  final List<Color> colors;
  final int colorLength;

  @override
  State<StatefulWidget> createState() => _ColorList();
}

class _ColorList extends State<ColorList> {
  bool isActive = false;
  String value = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white38), borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Цвета", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < widget.colors.length; i++) buildColorCircle(context, i),
                if (widget.colors.length < widget.colorLength) buildAddColor(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildColorCircle(BuildContext context, int colorIndex) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.colors[colorIndex],
          maximumSize: const Size(40, 40),
          minimumSize: const Size(40, 40),
          shape:
          const CircleBorder(side: BorderSide(color: Colors.white38, width: 1.0, strokeAlign: BorderSide.strokeAlignCenter)),
        ),
        onPressed: () {
          showColorPicker(context, index: colorIndex, type: PickerType.edit);
        },
        child: const Text(""),
      ),
    );
  }
  Widget buildAddColor(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        maximumSize: const Size(40, 40),
        minimumSize: const Size(40, 40),
        padding: EdgeInsets.zero,
        shape: const CircleBorder(side: BorderSide(color: Colors.white38, width: 1.0, strokeAlign: BorderSide.strokeAlignCenter)),
      ),
      onPressed: () {
        showColorPicker(context, type: PickerType.add);
      },
      child: const Icon(Icons.add, color: Colors.white38),
    );
  }
  changeColor(int index, Color color) {
    widget.colors[index] = color;
    widget.change(widget.colors);
  }

  addColor(Color color) {
    if(widget.colors.length<widget.colorLength) {
      widget.colors.add(color);
      widget.change(widget.colors);
    }

  }

  deleteColor(int index) {
    if (index >= 0) {
      widget.colors.removeAt(index);
      widget.change(widget.colors);
    }
  }

  void showColorPicker(BuildContext context, {int index = -1, required PickerType type}) {
    Color selectedColor = index == -1 ? Colors.white : widget.colors[index]; // Initial color if editing an existing color
    showDialog(
      context: context,
      builder: (_) {
        return
          BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child:

          AlertDialog(
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white24, width: 1), borderRadius: BorderRadius.all(Radius.circular(22.0))),
          titlePadding: const EdgeInsets.all(12),
          contentPadding: const EdgeInsets.all(12),
          actionsPadding: const EdgeInsets.all(12),
          title: const Text('Выберите цвет'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorPicker(
                pickerColor: selectedColor,
                enableAlpha: false,
                labelTypes: const [],
                onColorChanged: (Color newColor) {
                  selectedColor = newColor;
                },
              )
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    deleteColor(index);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 24, top: 4, right: 24, bottom: 4),
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border.fromBorderSide(BorderSide(color: Colors.redAccent, width: 2)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: const Text(
                      'Удалить',
                      style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.greenAccent,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    if (type == PickerType.add) {
                      addColor(selectedColor);
                    }
                    if (type == PickerType.edit) {
                      changeColor(index, selectedColor);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 24, top: 4, right: 24, bottom: 4),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      border: Border.fromBorderSide(BorderSide(color: Colors.green, width: 2)),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      'Выбрать',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ],
          )
        );
      },
    );
  }


  @override
  void dispose() {
    super.dispose();
  }
}
