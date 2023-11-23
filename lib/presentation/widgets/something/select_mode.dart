import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/strip_modes.dart';

class SelectModeField extends StatefulWidget {
  const SelectModeField({super.key, required this.mode, required this.change});
  final void Function(StripModes value) change;
  final StripModes mode;

  @override
  State<StatefulWidget> createState() => _SelectModeField();
}

class _SelectModeField extends State<SelectModeField> {
  bool isActive = false;
  String value = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            value: widget.mode,
            onChanged: (mode) => widget.change(mode!),
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

  @override
  void dispose() {
    super.dispose();
  }
}
