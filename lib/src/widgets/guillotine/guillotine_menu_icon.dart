import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/guillotine_settings.dart';

class GuillotineMenuIcon extends StatelessWidget {
  const GuillotineMenuIcon({
    Key? key,
    required this.animationIcon,
    required this.settings,
    required this.delta,
  }) : super(key: key);

  final Animation<double> animationIcon;
  final double delta;

  final GuillotineSettings settings;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: settings.menuVisible,
      child: FittedBox(
        alignment: Alignment.topLeft,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.rotate(
              angle: iconRotateAngle,
              child: settings.iconMenu,
            ),
          ),
        ),
      ),
    );
  }

  double get iconRotateAngle =>
      settings.rotateIconMenu ? -delta * math.pi * animationIcon.value : 0.0;
}
