import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/domain/entities/picker_type.dart';
import 'package:remote_leds/domain/usecases/led_mode.dart';
import 'package:remote_leds/presentation/screens/edit/edit_presenter.dart';
import 'package:remote_leds/presentation/widgets/icon_button.dart';
import 'package:remote_leds/presentation/widgets/animations.dart';
import 'package:remote_leds/presentation/widgets/something/color_list.dart';
import 'package:remote_leds/presentation/widgets/something/input.dart';
import 'package:remote_leds/presentation/widgets/something/select_mode.dart';
import 'package:remote_leds/presentation/widgets/something/select_zone.dart';

class ModeEditor extends StatefulWidget {
  const ModeEditor({super.key, required this.type, required this.model});
  final PickerType type;
  final LEDModeModel model;
  @override
  State<ModeEditor> createState() => _ModeEditorState();
}

class _ModeEditorState extends State<ModeEditor> {
  late EditScreenModel pageModel;
  @override
  void initState() {
    Provider.of<EditScreenModel>(context, listen: false).init(led: widget.model, pageType: widget.type);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  changeTree(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    pageModel = Provider.of<EditScreenModel>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                onPressed: () => pageModel.moveBack(),
                iconData: Icons.arrow_back,
                iconSize: 30,
              ),
              Text(pageModel.led.name),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight - 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputField(
                        label: "Наименование",
                        changeType: ChangeType.always,
                        hint: "Новый режим",
                        change: (name) {
                          setState(() {
                            pageModel.changeName(name);
                          });
                        },
                      ),
                      const SizedBox(height: 8.0),
                      SelectModeField(
                          change: (StripModes value) {
                            setState(() {
                              pageModel.changeMode(value);
                            });
                          },
                          mode: widget.model.mode),
                      const SizedBox(height: 8.0),
                      InputField(
                        label: "Скорость",
                        changeType: ChangeType.always,
                        keyBoardType: TextInputType.number,
                        hint: "1",
                        change: (name) {
                          setState(() {
                            pageModel.changeSpeed(name);
                          });
                        },
                      ),
                      const SizedBox(height: 8.0),
                      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                        return SelectZoneField(
                          rangeValues: pageModel.rangeValues,
                          change: (RangeValues value) {
                            setState(() {
                              pageModel.setZone(value);
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 8.0),
                      ColorList(
                          colors: pageModel.colors,
                          change: (colors) => setState(() {
                                pageModel.changeColors(colors);
                              }),
                          colorLength: pageModel.colorLength),
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
                          child: AnimationWidget(model: pageModel.animationModel)),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                  if (widget.type == PickerType.add)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [buildAddButton(() => pageModel.addNewMode())],
                    ),
                  if (widget.type == PickerType.edit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildDeleteButton(() => pageModel.deleteExistingMode()),
                        buildEditButton(() => pageModel.editExistingMode())
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildEditButton(
    void Function() onPress,
  ) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.greenAccent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () => onPress(),
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

  Widget buildAddButton(void Function() onPress) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.greenAccent,
        padding: EdgeInsets.zero,
      ),
      onPressed: () => onPress(),
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

  Widget buildDeleteButton(void Function() onPress) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1e1f22),
        padding: EdgeInsets.zero,
      ),
      onPressed: () => onPress(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: const Icon(
          Icons.delete_outline,
          size: 32,
        ),
      ),
    );
  }
}
