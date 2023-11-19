import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.iconSize = 36,
  });

  final Function() onPressed;
  final IconData iconData;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: iconSize,
        height: iconSize,
        child:Theme(
      data: Theme.of(context).copyWith(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: IconButton(

        iconSize: iconSize,
        onPressed: onPressed,
        icon:  Icon(iconData),
        padding: const EdgeInsets.all(0),
      ),
    ));
  }
}