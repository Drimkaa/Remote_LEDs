import 'package:flutter/material.dart';
import 'package:remote_leds/domain/constants/strip_modes.dart';
import 'package:remote_leds/domain/usecases/led_mode.dart';
import 'package:remote_leds/domain/usecases/led_mode_card.dart';
import 'package:remote_leds/presentation/widgets/constants.dart';
import 'package:remote_leds/presentation/widgets/something/custom_switch.dart';

class ModeCard extends StatefulWidget {
  const ModeCard({super.key, required this.model});

  final LedModeCard model;

  @override
  State<StatefulWidget> createState() => _ModeCard();
}

class _ModeCard extends State<ModeCard> {
  @override
  Widget build(BuildContext context) {
    LedModeCard model = widget.model;
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: padding(8),
      height: 84,
      decoration: decorationRadius(20, lightGrayColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" ${model.model.name}", style: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1)),
              Text(stripModeToString(model.model.mode),
                  textScaleFactor: 1.25, overflow: TextOverflow.ellipsis, style: const TextStyle(height: 1)),
              Row(
                children: [
                  Container(
                    decoration: decorationRadius(16, const Color(0xFF35373d)),
                    padding: padding4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${model.model.zoneStart} - ${model.model.zoneEnd}",
                          style: const TextStyle(height: 1),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.linear_scale_rounded, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    decoration: decorationRadius(16, const Color(0xFF35373d)),
                    padding: padding4,
                    child: Row(
                      children: [
                        Text("${model.model.speed}", style: const TextStyle(height: 1)),
                        const SizedBox(width: 4),
                        const Icon(Icons.timer_outlined, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomSwitch(
                // This bool value toggles the switch.
                value: model.model.isActive,
                onChanged: (bool value) {
                  setState(() {
                    model.changeActive();
                  });
                },
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 0, maxWidth: 150),
                decoration: decorationRadius(16, const Color(0xFF35373d)),
                padding: padding4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < model.model.colors.length; i++) ...[
                        _buildColorCircle(context, model.model.colors[i]),
                        if (i != model.model.colors.length - 1) const SizedBox(width: 4)
                      ],
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildColorCircle(BuildContext context, Color color) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
