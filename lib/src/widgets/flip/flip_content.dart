import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/flip_settings.dart';

class FlipContent extends StatelessWidget {
  const FlipContent({
    Key? key,
    required this.drawerContent,
    required this.animation,
    required this.animationColor,
    required this.onStart,
    required this.delta,
    required this.rotate,
    required this.isLeftSide,
    required this.addSizeInRight,
    required this.settings,
    required this.translate,
  }) : super(key: key);

  final Widget drawerContent;
  final Animation<double> animation;
  final Animation<Color?> animationColor;
  final VoidCallback onStart;
  final double delta;
  final double rotate;
  final bool isLeftSide;
  final double addSizeInRight;
  final FlipSettings settings;
  final double translate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: isLeftSide ? elements(size) : elements(size).reversed.toList(),
    );
  }

  List<Widget> elements(Size size) => [
        SizedBox(
          width: settings.drawerWidth,
          height: size.height,
          child: Transform.translate(
            offset: offsetForAnimationType(size),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.003)
                ..rotateY((delta * pi / 2) * (1 - animation.value) * rotate),
              alignment:
                  !isLeftSide ? Alignment.centerLeft : Alignment.centerRight,
              child: SizedBox(
                width: settings.drawerWidth,
                height: size.height,
                child: drawerContent,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onStart,
          child: Container(
            width: size.width - settings.drawerWidth,
            height: size.height,
            color: Colors.transparent,
          ),
        ),
      ];

  Offset offsetForAnimationType(Size size) {
    switch (settings.type) {
      case DrawerAnimation.STATIC:
        return Offset(0, 0);

      default:
        return Offset(delta * settings.drawerWidth * (animation.value - 1), 0);
    }
  }
}
