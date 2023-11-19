import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/constants/constants.dart';
import 'package:remote_leds/pages/main/main_page_model.dart';

import '../../components/app_bar/appbar.dart';
import 'dart:ui' as ui;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyanAccent,
    Colors.blue,
    Colors.purple,
  ];
  late List<Color> colors;
  List<double> _stops = List<double>.generate(16, (index) => index * 0.2 - 0.4);
  Animation<double>? animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
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
      if (status) {
        setState(() {});
      }
    });
    controller.forward();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).set(AppBarType.main);
  }

  bool sizeChanged(SizeChangedLayoutNotification notification) {
    // change height here
    width = MediaQuery.of(context).size.width * 0.8 > 300 ? 300 : MediaQuery.of(context).size.width * 0.8;
    height = width / 3;
    return false;
  }

  double width = 300;
  double height = 100;
  void init() async {}
  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
  bool status = false;
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageModel>(
      builder: (context, model, child) {
        status = model.status;

        return NotificationListener<SizeChangedLayoutNotification>(
          onNotification: sizeChanged,
          child: SizeChangedLayoutNotifier(
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[


                GestureDetector(
                  onTap: () => model.status = !model.status,
                  child: Container(
                    alignment: Alignment.center,
                    height: (height * 3),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/led.png',
                            width: width,
                            color: model.status ? Colors.white.withOpacity(0.95) : Colors.white.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.zero,
                          clipBehavior: Clip.hardEdge,
                          height: model.status ? (height * 3) : 0,
                          width: model.status ? MediaQuery.of(context).size.width : 0,
                          decoration: const BoxDecoration(color: Colors.transparent),
                          child: Container(
                            padding: EdgeInsets.zero,
                            height: model.status ? height * 1.25 : 0,
                            width: model.status ? width * 1.25 : 0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 250, 250, 250).withOpacity(model.lampValue / 100),
                              borderRadius: BorderRadius.circular(height / 2),
                              gradient: LinearGradient(colors: colors, stops: _stops.map((s) => s + animation!.value).toList()),
                            ),
                            child: BackdropFilter(
                              filter: ui.ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                              child: Image.asset(
                                'assets/led.png',
                                width: width,
                                color: Colors.white.withOpacity(1 - model.lampValue / 110),
                                colorBlendMode: BlendMode.modulate,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               Column(
                 children: [
                   Container(
                     padding: padding16,
                     decoration: decorationRadius(32, lightGrayColor),
                     margin: const EdgeInsets.only(left: 16, right: 16),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         GestureDetector(
                         onTap: () => model.status = !model.status,
                 child:Text(" ${model.status ? "Активна" : "Неактивна"}",
                             textScaleFactor: 1.5,
                             textAlign: TextAlign.center,
                             style: TextStyle(color: model.status ? Colors.white : Color(0xff8f8f8f)))),
                         Row(
                           mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Список", textScaleFactor: 1.5, style: TextStyle(color: light ? Color(0xff8f8f8f) : Colors.white)),
                             Switch(
                               // This bool value toggles the switch.
                               value: light,
                               inactiveThumbColor: Colors.redAccent,
                               inactiveTrackColor: Color(0xff8f8f8f),
                               activeTrackColor: Color(0xff8f8f8f),
                               activeColor: Colors.greenAccent,
                               onChanged: (bool value) {
                                 // This is called when the user toggles the switch.
                                 setState(() {
                                   light = value;
                                 });
                               },
                             ),
                             Text("Режим", textScaleFactor: 1.5, style: TextStyle(color: !light ? Color(0xff8f8f8f) : Colors.white)),
                           ],
                         ),
                         SliderTheme(
                           data:  SliderThemeData(trackHeight: 18, trackShape: RoundedRectSliderTrackShape(),
                               overlayShape: SliderComponentShape.noOverlay,
                             ),
                           child: Slider(

                             activeColor: Colors.amber[300],
                             secondaryActiveColor: Colors.amber[300],
                             overlayColor: MaterialStateProperty.all(Colors.transparent),
                             inactiveColor: const Color(0xFF777777),
                             thumbColor: Colors.amber[800],
                             value: model.sliderValue,
                             max: 100,
                             min: 30,
                             onChanged: (double value) {
                               model.sliderValue = value;
                             },
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 76,)
                 ],

               )

              ])
          ),
        );
      },
    );
  }
}
