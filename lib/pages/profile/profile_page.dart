import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/animation/FireAnimation.dart';
import 'package:remote_leds/animation/GradientAnimation.dart';
import 'package:remote_leds/animation/PulseAnimation.dart';
import 'package:remote_leds/animation/RainbowAnimation.dart';
import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/constants/constants.dart';
import 'package:remote_leds/pages/modeEditor/ModeEditor.dart';


import '../../components/app_bar/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  late LEDModeModel model = LEDModeModel();
  late LEDMode select = model.mode;
  @override
  initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }
  changeTree(BuildContext context){
    Provider.of<AppBarModel>(context,listen: false).set(AppBarType.currentMode);
    model = Provider.of<LEDControlModel>(context,listen: false).selectedMode??LEDModeModel();
  }
  void init() async {}
  @override
  void dispose() {
    super.dispose();
  }
  Widget gradient = Container(color: Colors.black12);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: padding16,
        child:
    Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _selectMode(context),
        const SizedBox(height: 8.0),
        _inputSpeed(context),
        const SizedBox(height: 8.0),
        _selectZone(context),
        const SizedBox(height: 8.0),
        _selectColors(context),
        const SizedBox(height: 8.0),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white38),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24)),
            ),
            child: gradient),
      ],
    ));

  }
  Widget _selectZone(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              "Выбранная область: "
                  "${model.zoneStart.toString()}" +
                  " - "
                      "${model.zoneEnd.toString()}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          RangeSlider(
            values: RangeValues(model.zoneStart.toDouble(), model.zoneEnd.toDouble()),
            min: 0.0,
            max: 300.0,
            activeColor: Colors.amber,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            inactiveColor: const Color(0xFF777777),
            onChanged: (RangeValues values) {
              setState(() {
                model.setZone(values.start.toInt(), values.end.toInt());
              });
            },
          ),
        ],
      ),
    );
  }
  Widget _selectMode(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<LEDMode>(
            value: select,
            onChanged: (mode) => setState(() {
              model.mode = mode ?? LEDMode.static;
              select = mode ?? LEDMode.static;
              changeGradient(context);
            }),
            isExpanded: true,
            dropdownStyleData: const DropdownStyleData(
              offset: Offset(0, -8),
              useSafeArea: false,
              maxHeight: 310,
            ),
            items: LEDMode.values.map((mode) {
              return DropdownMenuItem<LEDMode>(
                value: mode,
                child: Text(stringLEDMode(mode)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  int speed = 0;
  Widget _inputSpeed(BuildContext context) {
    return TextField(
      onEditingComplete: () => {
        if (model.speed != speed) {changeGradient(context), speed = model.speed}
      },
      onTapOutside: (_) => {
        if (model.speed != speed) {changeGradient(context), speed = model.speed}
      },
      onChanged: (speed) => {model.speed = speed.isNotEmpty ? int.parse(speed) : 0},
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
          labelText: 'Скорость режима',
          floatingLabelStyle: TextStyle(color: Colors.amber),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.amber, width: 2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusColor: Colors.amber,
          hintText: "1"),
    );
  }
  changeGradient(BuildContext context) {
    print("вызвал изменение градиента ${model.colors.length}");
    GlobalKey key = GlobalKey();
    if (model.mode == LEDMode.static) {
      if (model.colors.isNotEmpty) {
        setState(() {
          gradient = Container(key: key, color: model.colors[0]);
        });
      }
    } else if (model.mode == LEDMode.fire) {
      if (model.colors.isNotEmpty) {
        setState(() {
          gradient =
              FireAnimation(key: key, colors: [model.colors[0]], time: Duration(milliseconds: model.speed * 1000));
        });
      }
    } else if (model.mode == LEDMode.rainbow) {
      if (model.colors.length > 1) {
        setState(() {
          gradient =
              RanbowAnimation(key: key, colors: model.colors, time: Duration(milliseconds: model.speed * 1000));
        });
      }
    } else if (model.mode == LEDMode.fading) {
      if (model.colors.length > 1) {
        setState(() {
          gradient =
              GradientAnimation(key: key, colors: model.colors, time: Duration(milliseconds: model.speed * 1000));
        });
      }
    } else if (model.mode == LEDMode.pulse) {
      if (model.colors.length > 1) {
        setState(() {
          gradient = PulseAnimation(key: key, colors: model.colors, time: Duration(milliseconds: model.speed * 1000));
        });
      }
    }
  }
  Widget _selectColors(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 8),
      decoration:
      BoxDecoration(border: Border.all(color: Colors.white38), borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Цвета",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0; i < model.colors.length; i++) _buildColorCircle(context, i),
                if (model.colors.length < model.colorLength) _addButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _addButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        maximumSize: const Size(40, 40),
        minimumSize: const Size(40, 40),
        padding: EdgeInsets.zero,
        shape: const CircleBorder(side: BorderSide(color: Colors.white38, width: 1.0, strokeAlign: BorderSide.strokeAlignCenter)),
      ),
      onPressed: () {
        _showColorPicker(context, type: PickerType.add);
      },
      child: const Icon(Icons.add, color: Colors.white38),
    );
  }

  Widget _buildColorCircle(BuildContext context, int colorIndex) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: model.colors[colorIndex],
          maximumSize: const Size(40, 40),
          minimumSize: const Size(40, 40),
          shape:
          const CircleBorder(side: BorderSide(color: Colors.white38, width: 1.0, strokeAlign: BorderSide.strokeAlignCenter)),
        ),
        onPressed: () {
          _showColorPicker(context, index: colorIndex, type: PickerType.edit);
        },
        child: const Text(""),
      ),
    );
  }

  void _showColorPicker(BuildContext context, {int index = -1, required PickerType type}) {
    Color selectedColor = index == -1 ? Colors.white : model.colors[index]; // Initial color if editing an existing color

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white24, width: 2), borderRadius: BorderRadius.all(Radius.circular(8.0))),
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
                labelTypes: [],
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
                    setState(() {
                      if (index > 0) {
                        model.deleteColor(index);
                      }
                      Navigator.of(context).pop();
                    });
                    changeGradient(context);
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
                    setState(
                          () {
                        if (type == PickerType.add) {
                          model.addColor(selectedColor);
                        } else {
                          model.colors[index] = selectedColor;
                        }

                        Navigator.of(context).pop();
                      },
                    );
                    changeGradient(context);
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
        );
      },
    );
  }
}