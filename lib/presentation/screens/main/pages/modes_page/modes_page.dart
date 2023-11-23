import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remote_leds/domain/usecases/led_controller.dart';
import 'package:remote_leds/domain/usecases/led_mode.dart';
import 'package:remote_leds/domain/usecases/led_mode_card.dart';
import 'package:remote_leds/presentation/screens/main/pages/modes_page/modes_page_presenter.dart';
import 'package:remote_leds/presentation/widgets/mode_card/mode_card_wrapper.dart';

class ModesPage extends StatefulWidget {
  const ModesPage({super.key});

  @override
  State<StatefulWidget> createState() => _ModesPage();
}

class _ModesPage extends State<ModesPage> {
  @override
  initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) => changeTree(context));
  }

  double y = 0;
  changeTree(BuildContext context) {
    Provider.of<ModesPageModel>(context, listen: false).pageSetMode();
    Provider.of<ModesPageModel>(context, listen: false).addMode(LedModeCard(LedMode(colors: [Colors.blueAccent])));
  }

  void init() async {}
  @override
  void dispose() {
    super.dispose();
  }

  ModesPageModel model = ModesPageModel();
  changedColors(List<Color> colors) {}
  int deleteCount = 0;
  @override
  Widget build(BuildContext context) {
    model = Provider.of<ModesPageModel>(context, listen: true);
    List<LedModeCard> modes = model.modes;
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  for (var i = 0; i < modes.length; i++) ...[
                    ModeCardWrapper(
                      model: modes[i],
                      onLongPress: () {
                        setState(() {
                          model.cardOnLongPress(modes[i]);
                        });
                      },
                      pageMode: model.pageMode,
                      onTap: () {
                        setState(() {
                          model.cardOnPress(modes[i]);
                        });
                      },
                      changeDeleteStatus: () {
                        model.cardChangeDeleteStatus(modes[i]);
                      },
                    ),
                    if (i != modes.length - 1) const SizedBox(height: 8),
                  ],
                  const SizedBox(
                    height: 82,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
