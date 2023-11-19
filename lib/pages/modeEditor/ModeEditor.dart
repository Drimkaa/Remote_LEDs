import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/animation/FireAnimation.dart';
import 'package:remote_leds/animation/GradientAnimation.dart';
import 'package:remote_leds/animation/PulseAnimation.dart';
import 'package:remote_leds/animation/RainbowAnimation.dart';

import 'package:remote_leds/components/color_model/LEDController.dart';
import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/constants/iconButton.dart';

enum PickerType { add, edit }

class ModeEditor extends StatefulWidget {
  ModeEditor({super.key, required this.type, LEDModeModel? mode}) : mode = mode ?? LEDModeModel();
  LEDModeModel mode;
  PickerType type;
  @override
  State<ModeEditor> createState() => _ModeEditorState();
}

class _ModeEditorState extends State<ModeEditor> {
  late LEDMode select = widget.mode.mode;
  @override
  void initState() {
    super.initState();
    changeGradient(context);
  }

  int speed = 0;
  Widget gradient = Container(color: Colors.black12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(onPressed: () {
                  context.read<PageModel>().back();
                }, iconData: Icons.arrow_back,iconSize: 30,)
                ,
                Text("${widget.mode.name.isNotEmpty ? widget.mode.name : 'Новый режим'}"),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _inputName(context),
                  const SizedBox(height: 8.0),
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
                  const SizedBox(height: 8.0),
                ],
              ),
              Row(
                mainAxisAlignment: widget.type == PickerType.add? MainAxisAlignment.end:MainAxisAlignment.spaceBetween,
                children: [
                  if(widget.type == PickerType.edit) _buildDeleteButton(context),
                  widget.type == PickerType.add ? _buildAddButton(context) : _buildEditButton(context),
                ],
              )

            ],
          ),
        ));
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
              widget.mode.mode = mode ?? LEDMode.static;
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

  Widget _inputName(BuildContext context) {
    return TextField(
      onChanged: (name) => setState(() {
        widget.mode.name = name;
      }),
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: 'Наименование',
        floatingLabelStyle: TextStyle(color: Colors.amber),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.amber, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusColor: Colors.amber,
        hintText: "Новый режим",
      ),
    );
  }

  Widget _inputSpeed(BuildContext context) {
    return TextField(
      onEditingComplete: () => {
        if (widget.mode.speed != speed) {changeGradient(context), speed = widget.mode.speed}
      },
      onTapOutside: (_) => {
        if (widget.mode.speed != speed) {changeGradient(context), speed = widget.mode.speed}
      },
      onChanged: (speed) => {widget.mode.speed = speed.isNotEmpty ? int.parse(speed) : 0},
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
                      "${widget.mode.zoneStart.toString()}" +
                  " - "
                      "${widget.mode.zoneEnd.toString()}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          RangeSlider(
            values: RangeValues(widget.mode.zoneStart.toDouble(), widget.mode.zoneEnd.toDouble()),
            min: 0.0,
            max: 300.0,
            activeColor: Colors.amber,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            inactiveColor: const Color(0xFF777777),
            onChanged: (RangeValues values) {
              setState(() {
                widget.mode.setZone(values.start.toInt(), values.end.toInt());
              });
            },
          ),
        ],
      ),
    );
  }
  Widget _buildDeleteButton (BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFF1e1f22),
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        if (widget.mode.colors.isNotEmpty) Provider.of<LEDControlModel>(context, listen: false).deleteMode(widget.mode);
        context.read<PageModel>().back();
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Icon(Icons.delete_outline,size: 32,),
      ),
    );
  }
  Widget _buildAddButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.greenAccent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        if (widget.mode.colors.isNotEmpty) Provider.of<LEDControlModel>(context, listen: false).addNewMode(widget.mode);
        context.read<PageModel>().back();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Text(
          'Добавить режим',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF1e1f22)),
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.greenAccent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () {
        if (widget.mode.colors.isNotEmpty) Provider.of<LEDControlModel>(context, listen: false).editMode(widget.mode);
        context.read<PageModel>().back();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Text(
          'Применить изменения',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF1e1f22)),
        ),
      ),
    );
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
                for (int i = 0; i < widget.mode.colors.length; i++) _buildColorCircle(context, i),
                if (widget.mode.colors.length < widget.mode.colorLength) _addButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  changeGradient(BuildContext context) {
    print("вызвал изменение градиента ${widget.mode.colors.length}");
    GlobalKey key = GlobalKey();
    if (widget.mode.mode == LEDMode.static) {
      if (widget.mode.colors.isNotEmpty) {
        setState(() {
          gradient = Container(key: key, color: widget.mode.colors[0]);
        });
      }
    } else if (widget.mode.mode == LEDMode.fire) {
      if (widget.mode.colors.isNotEmpty) {
        setState(() {
          gradient =
              FireAnimation(key: key, colors: [widget.mode.colors[0]], time: Duration(milliseconds: widget.mode.speed * 1000));
        });
      }
    } else if (widget.mode.mode == LEDMode.rainbow) {
      if (widget.mode.colors.length > 1) {
        setState(() {
          gradient =
              RanbowAnimation(key: key, colors: widget.mode.colors, time: Duration(milliseconds: widget.mode.speed * 1000));
        });
      }
    } else if (widget.mode.mode == LEDMode.fading) {
      if (widget.mode.colors.length > 1) {
        setState(() {
          gradient =
              GradientAnimation(key: key, colors: widget.mode.colors, time: Duration(milliseconds: widget.mode.speed * 1000));
        });
      }
    } else if (widget.mode.mode == LEDMode.pulse) {
      if (widget.mode.colors.length > 1) {
        setState(() {
          gradient = PulseAnimation(key: key, colors: widget.mode.colors, time: Duration(milliseconds: widget.mode.speed * 1000));
        });
      }
    }
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
          backgroundColor: widget.mode.colors[colorIndex],
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
    Color selectedColor = index == -1 ? Colors.white : widget.mode.colors[index]; // Initial color if editing an existing color

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
                        widget.mode.deleteColor(index);
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
                          widget.mode.addColor(selectedColor);
                        } else {
                          widget.mode.colors[index] = selectedColor;
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
