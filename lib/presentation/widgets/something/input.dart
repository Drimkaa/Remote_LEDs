import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/change_type.dart';
import 'package:remote_leds/domain/constants/theme_extension.dart';

export 'package:remote_leds/domain/constants/change_type.dart';

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      this.label = "Описание",
      this.hint = "Подсказка",
      required this.change,
      this.changeType = ChangeType.onLeave,
      this.keyBoardType = TextInputType.name});
  final String label;
  final String hint;
  final void Function(String value) change;
  final ChangeType changeType;
  final TextInputType keyBoardType;

  @override
  State<StatefulWidget> createState() => _InputField();
}

class _InputField extends State<InputField> {
  bool isActive = false;
  String value = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () => changeActive(true),
      onTapOutside: (_) => changeActive(false),
      onSubmitted: (_) => changeActive(false),
      onEditingComplete: () => changeActive(false),
      onChanged: (value) => {value = value, changeValue(value)},
      keyboardType: widget.keyBoardType,
      decoration: InputDecoration(
          labelText: widget.label,
          floatingLabelStyle: TextStyle(color: Theme.of(context).extension<MyColors>()?.first),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Theme.of(context).extension<MyColors>()?.first ?? Colors.white, width: 2),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusColor: Theme.of(context).extension<MyColors>()?.first,
          hintText: widget.hint),
    );
  }

  changeActive(bool status) {
    if (isActive && !status) {
      isActive = false;
      if (widget.changeType == ChangeType.onLeave) {
        setState(() {
          widget.change(value);
        });
      }
    }
    if (!isActive && status) {
      isActive = true;
    }
  }

  changeValue(String value) {
    if (widget.changeType == ChangeType.always) {
      setState(() {
        widget.change(value);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
