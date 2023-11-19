import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/components/page_model.dart';
class SettingsAppBar extends StatefulWidget {
  const SettingsAppBar({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SettingsAppBar();
}

class _SettingsAppBar extends State<SettingsAppBar> {
  @override
  initState() {
    super.initState();
    init();
  }
  init() async {}
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Row(
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
                onPressed: () {
                  context.read<PageModel>().back();
                },
              ),

             const Text("Настройки"),
            ],
          ),
          const Icon(Icons.mode, size: 24),
        ],
      ),
    );
  }
}