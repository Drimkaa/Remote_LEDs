import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/components/page_model.dart';
class CurrentModeAppBar extends StatefulWidget {
  const CurrentModeAppBar({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CurrentModeAppBar();
}

class _CurrentModeAppBar extends State<CurrentModeAppBar> {
  @override
  initState() {
    super.initState();
    init();
  }
  init() async {}
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Текущий режим")
    );
  }
}