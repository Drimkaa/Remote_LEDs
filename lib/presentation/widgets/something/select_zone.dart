import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/theme_extension.dart';

class SelectZoneField extends StatefulWidget {
  const SelectZoneField({super.key, required this.rangeValues, required this.change});
  final void Function(RangeValues value) change;
  final RangeValues rangeValues;

  @override
  State<StatefulWidget> createState() => _SelectZoneField();
}

class _SelectZoneField extends State<SelectZoneField> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(
              "Выбранная область: ${widget.rangeValues.start.toInt()} - ${widget.rangeValues.end.toInt()}",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          RangeSlider(
            values: widget.rangeValues,
            min: 0,
            max: 300,
            activeColor: Theme.of(context).extension<MyColors>()?.first,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            inactiveColor: Theme.of(context).extension<MyColors>()?.inactive,
            onChanged: (RangeValues values) => widget.change(values),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
