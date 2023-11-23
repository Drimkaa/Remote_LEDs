import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/theme_extension.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.value == false ? widget.onChanged(true) : widget.onChanged(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 50.0,
        padding: const EdgeInsets.all(4),
        height: 28.0,
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color:
              widget.value ? Theme.of(context).extension<MyColors>()?.second : Theme.of(context).extension<MyColors>()?.inactive,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.value
                  ? Theme.of(context).extension<MyColors>()?.active
                  : Theme.of(context).extension<MyColors>()?.inactive2),
        ),
      ),
    );
  }
}
