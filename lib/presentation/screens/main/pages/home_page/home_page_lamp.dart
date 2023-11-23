import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/presentation/screens/main/pages/home_page/home_page_gradient.dart';
import 'package:remote_leds/presentation/widgets/appbar/appbar.dart';

class HomePageLamp extends StatefulWidget {
  const HomePageLamp({super.key, this.status  = false, this.brightness = 70,required this.change});
  final bool status;
  final int brightness;
  final Function() change;
  @override
  State<StatefulWidget> createState() => _HomePageLamp();
}

class _HomePageLamp extends State<HomePageLamp> with SingleTickerProviderStateMixin {
  @override
  initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).setCustomAppBar(text: "Главная");
  }

  double width = 300;
  double height = 100;
  bool isPadding = true;
  void init() async {}

  double temp = 0;
  bool sizeChanged(SizeChangedLayoutNotification notification) {
    temp = MediaQuery.of(context).size.width * 0.8 > 300 ? 300 : MediaQuery.of(context).size.width * 0.8;
    if (temp != width) {
      width = temp;
      height = width / 3;
    }
    return false;
  }

  bool status = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {widget.change();},
      child: Stack(
        alignment: Alignment.center,
        children: [
          NotificationListener<SizeChangedLayoutNotification>(
            onNotification: sizeChanged,
            child: SizeChangedLayoutNotifier(
              child: Container(
                width: width * 1.5,
                height: (height * 3),
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: widget.status
                    ? HomePageGradient(
                        width: width,
                        brightness: widget.brightness,
                      )
                    : const SizedBox(),
              ),
            ),
          ),
          Image.asset(
            'assets/led.png',
            width: width,
            color: Colors.white.withOpacity(1 - (widget.status ? widget.brightness / 110 : 0)),
            colorBlendMode: BlendMode.modulate,
          ),
        ],
      ),
    );
  }
}
