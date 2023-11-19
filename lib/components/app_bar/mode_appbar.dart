import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../page_model.dart';

class ModeAppBar extends StatefulWidget {
  const ModeAppBar({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ModeAppBar();
}

class _ModeAppBar extends State<ModeAppBar> {
  @override
  initState() {
    super.initState();
    init();
  }

  init() async {}
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.mode, size: 20),
              Text("Режимы"),
            ],
          ),
        ],
      ),
    );
  }
}
