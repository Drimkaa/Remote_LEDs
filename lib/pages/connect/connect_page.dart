import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:quick_blue/quick_blue.dart';

import 'package:remote_leds/components/page_model.dart';
import 'package:remote_leds/pages/connect/connect_page_model.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});
  static const String id = 'connect_screen';
  @override
  State<StatefulWidget> createState() => _ConnectPage();
}

class _ConnectPage extends State<ConnectPage> with SingleTickerProviderStateMixin {
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyanAccent,
    Colors.blue,
    Colors.purpleAccent,
  ];
  late final List<Color> colors;
  List<double> _stops = List<double>.generate(16, (index) => index * 0.2 - 0.4);
  Animation<double>? animation;
  late AnimationController controller;

  String espAddress = "9C:9C:1F:C9:82:2A";
  StreamController<ConnectStatus> _streamController = StreamController<ConnectStatus>();
  @override
  void initState() {
    super.initState();

    icon = activeButtonIcon(setConnection);
    colors = [..._colors, ..._colors];
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _stops = List<double>.generate(_colors.length * 2, (index) => index / (_colors.length * 2 - 1) * 4);
    double step = 4 / (_colors.length * 2 - 1);
    double animationBegin = 0 - (step / 2) * (_colors.length - 1);
    double animationEnd = -4 + (step / 2) * (_colors.length - 1);
    animation = Tween<double>(begin: animationBegin, end: animationEnd).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    animation?.addListener(() {
      setState(() {});
    });
    controller.forward();
    _streamController.stream.listen((event) => context.read<ConnectPageModel>().status = event);
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  changeTree(BuildContext context) {}
  void setConnection() async {
    QuickBlue.isBluetoothAvailable().asStream().listen((event) {
      print(event);
      if (event) {
        QuickBlue.scanResultStream.listen((result) {
          print('onScanResult ${result.name} | ${result.deviceId}');
        });

        QuickBlue.startScan();
      }
    });

    print(context.read<ConnectPageModel>().status);
    if (await checkPermissions() == false) {
      _streamController.add(ConnectStatus.error);
      return;
    }
    _streamController.add(ConnectStatus.progress);
  }

  checkPermissions() async {
    var returned = true;
    if (!await Permission.bluetoothConnect.request().isGranted) {
      returned = false;
      await Permission.bluetoothConnect.request();
    }
    if (!await Permission.bluetoothScan.request().isGranted) {
      returned = false;
      await Permission.bluetoothScan.request();
    }
    if (!await Permission.bluetooth.request().isGranted) {
      returned = false;
      await Permission.bluetooth.request();
    }
  }

  late Widget icon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () => context.read<PageModel>().setPageFromEnum(PagesEnum.wrapper),
                child: const Icon(Icons.account_circle, color: Colors.white)),
            Consumer<ConnectPageModel>(builder: (context, model, child) {
              return Container(
                height: 240.0,
                width: 240.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 50, 50, 50),
                  borderRadius: BorderRadius.circular(150),
                  gradient: LinearGradient(colors: colors, stops: _stops.map((s) => s + animation!.value).toList()),
                ),
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: const Color.fromARGB(255, 50, 50, 50), borderRadius: BorderRadius.circular(150)),
                    child: model.status == ConnectStatus.progress ? loadingIcon : icon,
                  ),
                ),
              );
            }),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: Text(
                context.read<ConnectPageModel>().textStatus,
                style: const TextStyle(color: Color.fromARGB(120, 255, 255, 255), fontSize: 28),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget activeButtonIcon(Function() function) => IconButton(
      padding: EdgeInsets.zero,
      iconSize: 200,
      icon: const Icon(Icons.lightbulb_outlined, color: Color.fromARGB(120, 255, 255, 255)),
      onPressed: function,
      splashColor: Colors.green,
      highlightColor: Colors.green);

  final Widget loadingIcon = Container(
    margin: const EdgeInsets.all(10.0),
    child: const CircularProgressIndicator(strokeWidth: 20, color: Color.fromARGB(120, 255, 255, 255)),
  );
}
