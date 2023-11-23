import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/domain/usecases/led_controller.dart';
import 'package:remote_leds/presentation/widgets/animations.dart';
import 'package:remote_leds/presentation/widgets/animations_model.dart';
import 'package:remote_leds/presentation/widgets/appbar/appbar.dart';
import 'package:remote_leds/presentation/widgets/constants.dart';
import 'package:remote_leds/presentation/widgets/something/color_list.dart';
import 'package:remote_leds/presentation/widgets/something/input.dart';
import 'package:remote_leds/presentation/widgets/something/select_mode.dart';
import 'package:remote_leds/presentation/widgets/something/select_zone.dart';

class CurrentModePage extends StatefulWidget {
  const CurrentModePage({super.key});

  @override
  State<StatefulWidget> createState() => _CurrentModePage();
}

class _CurrentModePage extends State<CurrentModePage> {
  late LEDModeModel model = LEDModeModel();
  late StripModes select = model.mode;
  @override
  initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).setCustomAppBar(text: "Текущий режим");
  }

  void init() async {}
  @override
  void dispose() {
    super.dispose();
  }

  late AnimationModel animationModel = AnimationModel(model.colors, model.mode, Duration(milliseconds: model.speed * 1000));
  Widget gradient = Container(color: Colors.black12);
  @override
  Widget build(BuildContext context) {
    model = Provider.of<LEDControllerModel>(context, listen: false).selectedMode;
    animationModel = AnimationModel(model.colors, model.mode, Duration(milliseconds: model.speed * 1000));
    select = model.mode;
    return Container(
        padding: padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputField(
              label: "Наименование",
              changeType: ChangeType.always,
              hint: "Новый режим",
              change: (name) => changeName(name),
            ),
            const SizedBox(height: 8.0),
            SelectModeField(
                mode: model.mode,
                change: (StripModes value) {
                  changeMode(value);
                }),
            const SizedBox(height: 8.0),
            InputField(
              label: "Скорость",
              changeType: ChangeType.always,
              keyBoardType: TextInputType.number,
              hint: "1",
              change: (name) => changeSpeed(name),
            ),
            const SizedBox(height: 8.0),
            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return SelectZoneField(
                rangeValues: RangeValues(model.zoneStart.toDouble(), model.zoneEnd.toDouble()),
                change: (RangeValues value) {
                  setState(() {
                    Provider.of<LEDControllerModel>(context, listen: false)
                        .selectedMode
                        .setZone(value.start.toInt(), value.end.toInt());
                    model.setZone(value.start.toInt(), value.end.toInt());
                  });
                },
              );
            }),
            const SizedBox(height: 8.0),
            ColorList(
                colors: model.colors,
                change: (colors) => setState(() {
                      model.colors = colors;
                      Provider.of<LEDControllerModel>(context, listen: false).selectedMode.colors = colors;
                      animationModel.colors = colors;
                    }),
                colorLength: model.colorLength),
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
                child: AnimationWidget(model: animationModel)),
            const SizedBox(height: 8.0),
          ],
        ));
  }

  Widget selectMode(BuildContext context) {
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
          child: DropdownButton2<StripModes>(
            value: select,
            onChanged: (mode) => changeMode(mode),
            isExpanded: true,
            dropdownStyleData: const DropdownStyleData(
              offset: Offset(0, -8),
              useSafeArea: false,
              maxHeight: 310,
            ),
            items: StripModes.values.map((mode) {
              return DropdownMenuItem<StripModes>(
                value: mode,
                child: Text(stripModeToString(mode)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  changeMode(StripModes? mode) {
    if (mode != null && mode != model.mode) {
      Provider.of<LEDControllerModel>(context, listen: false).selectedMode.mode = mode;
      model.mode = mode;
      animationModel.mode = mode;
      setState(() {});
    }
  }

  changeName(String name) {
    if (name == "" || name == " ") {
      name = "Новый режим";
    }
    if (name != model.name) {
      Provider.of<LEDControllerModel>(context, listen: false).selectedMode.name = name;
      model.name = name;
      setState(() {});
    }
  }

  changeSpeed(String speed) {
    int speed0;
    if (speed.isNotEmpty) {
      speed0 = int.parse(speed);
    } else {
      speed0 = 1;
    }
    if (speed0 != model.speed) {
      model.speed = speed0;
      Provider.of<LEDControllerModel>(context, listen: false).selectedMode.speed = speed0;
      animationModel.duration = Duration(milliseconds: speed0 * 1000);
      setState(() {});
    }
  }
}
