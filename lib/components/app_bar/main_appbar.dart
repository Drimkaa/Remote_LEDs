import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/services/sclaed_route/scaled_route.dart';
import 'package:remote_leds/pages/settings/settings_page.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MainAppBar();
}

class _MainAppBar extends State<MainAppBar> {
  @override
  initState() {
    super.initState();
    init();
  }

  init() async {}
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
              Text("Главная"),
            
    );
  }
}
