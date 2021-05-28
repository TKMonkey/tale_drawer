import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/flip_settings.dart';

class FlipBody extends StatelessWidget {
  const FlipBody({
    Key? key,
    required this.body,
    required this.animation,
    required this.animationColor,
    required this.delta,
    required this.isLeftSide,
    required this.settings,
  }) : super(key: key);

  final Widget body;
  final Animation<double> animation;
  final Animation<Color?> animationColor;

  final double delta;
  final FlipSettings settings;
  final bool isLeftSide;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Transform.translate(
      offset: Offset(
        delta * settings.drawerWidth * animation.value,
        0,
      ),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(-delta * pi * animation.value / 2),
        alignment: isLeftSide ? Alignment.centerLeft : Alignment.centerRight,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: body,
            ),
            Visibility(
              visible: settings.showShadow && animation.value != 0,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  color: animationColor.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
