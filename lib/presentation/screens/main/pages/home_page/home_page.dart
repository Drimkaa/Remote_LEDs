import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/domain/constants/theme_extension.dart';
import 'package:remote_leds/presentation/screens/main/pages/home_page/home_page_lamp.dart';
import 'package:remote_leds/presentation/screens/main/pages/home_page/home_page_presenter.dart';
import 'package:remote_leds/presentation/widgets/appbar/appbar.dart';
import 'package:remote_leds/presentation/widgets/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  bool isOpened = false;
  changeTree(BuildContext context) {
    Provider.of<AppBarModel>(context, listen: false).setCustomAppBar(text: "Главная");

    setState(() {
      isOpened = true;
    });
  }

  @override
  void dispose() {
    isOpened = false;
    super.dispose();
  }

  changeStatus() {
    Provider.of<HomePageModel>(context, listen: false).changeStatus();
  }

  @override
  Widget build(BuildContext context) {
    HomePageModel model = Provider.of<HomePageModel>(context, listen: true);
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Positioned(
            right: 0,
            top: 0,
            left: 0,
            child: HomePageLamp(status: model.status, brightness: model.lampValue, change: () => changeStatus())),
        Positioned(
          right: 0,
          bottom: 0,
          left: 0,
          height: 205,
          child: AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 16),
              decoration: BoxDecoration(
                  color: lightGrayColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero)),
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 65, top: isOpened ? 0 : 100),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Provider.of<HomePageModel>(context, listen: false).changeStatus(),
                          child: Text(
                            " ${model.status ? "Активна" : "Неактивна"}",
                            textScaleFactor: 1.5,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: model.status ? Colors.white : Theme.of(context).extension<MyColors>()?.inactive,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Provider.of<HomePageModel>(context, listen: false).changeMode(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Список",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                  color: model.mode == HomeMode.list
                                      ? Colors.white
                                      : Theme.of(context).extension<MyColors>()?.inactive,
                                ),
                              ),
                              Switch(
                                // This bool value toggles the switch.
                                value: model.mode == HomeMode.mode,
                                inactiveThumbColor: Theme.of(context).extension<MyColors>()?.first,
                                inactiveTrackColor: Theme.of(context).extension<MyColors>()?.second,
                                activeTrackColor: Theme.of(context).extension<MyColors>()?.second2,
                                activeColor: Theme.of(context).extension<MyColors>()?.first2,
                                onChanged: (bool value) {
                                  Provider.of<HomePageModel>(context, listen: false).changeMode();
                                },
                              ),
                              Text(
                                "Режим",
                                textScaleFactor: 1.5,
                                style: TextStyle(
                                  color: model.mode == HomeMode.mode
                                      ? Colors.white
                                      : Theme.of(context).extension<MyColors>()?.inactive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 18,
                        trackShape: const RoundedRectSliderTrackShape(),
                        overlayShape: SliderComponentShape.noOverlay,
                      ),
                      child: Slider(
                        activeColor: Theme.of(context).extension<MyColors>()?.second,
                        secondaryActiveColor: Colors.amber[300],
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        inactiveColor: Theme.of(context).extension<MyColors>()?.inactive,
                        thumbColor: Theme.of(context).extension<MyColors>()?.first,
                        value: model.sliderValue,
                        max: 100,
                        min: 30,
                        onChanged: (double value) {
                          if (model.status) {
                            model.sliderValue = value;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }
}
