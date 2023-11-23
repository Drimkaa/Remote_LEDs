import 'package:flutter/material.dart';
import 'package:remote_leds/domain/usecases/led_mode_card.dart';
import 'package:remote_leds/presentation/screens/main/pages/modes_page/modes_page_presenter.dart';
import 'package:remote_leds/presentation/widgets/mode_card/mode_card.dart';
import 'package:remote_leds/presentation/widgets/mode_card/mode_card_edit.dart';

class ModeCardWrapper extends StatefulWidget {
  const ModeCardWrapper(
      {super.key,
      required this.model,
      required this.pageMode,
      required this.onLongPress,
      required this.changeDeleteStatus,
      required this.onTap});

  final LEDModeCardModel model;
  final PageMode pageMode;
  final void Function() onLongPress;
  final void Function() onTap;
  final void Function() changeDeleteStatus;
  @override
  State<StatefulWidget> createState() => _ModeCardWrapper();
}

class _ModeCardWrapper extends State<ModeCardWrapper> {
  @override
  initState() {
    super.initState();

    init();
  }

  void init() async {}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: widget.onLongPress,
        onTap: widget.onTap,
        child: widget.pageMode == PageMode.delete
            ? ModeDeleteCard(model: widget.model, changeDeleteStatus: () => widget.changeDeleteStatus())
            : ModeCard(model: widget.model));
  }
}
