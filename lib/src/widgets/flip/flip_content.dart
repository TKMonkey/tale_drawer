import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/flip_settings.dart';

/// {@template flip_content}
///
/// This widget is to create content drawer of [TaleDrawer] when is [FlipDrawerWidget]
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the flip animation
/// Flip animation is compose by: `Translate`, `Perspective` and `Rotate` the widget
///
/// This widget can use the `shadowColor` param from [FlipSettings]
/// With this, the widget creates a container to simulate a shadow effect
///
/// {@endtemplate}
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
      children:
          isLeftSide ? _elements(size) : _elements(size).reversed.toList(),
    );
  }

  List<Widget> _elements(Size size) => [
        SizedBox(
          width: settings.drawerWidth,
          height: size.height,
          child: Transform.translate(
            offset: _offsetForAnimationType(size),
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

  Offset _offsetForAnimationType(Size size) {
    switch (settings.type) {
      case DrawerAnimation.STATIC:
        return Offset(0, 0);

      default:
        return Offset(delta * settings.drawerWidth * (animation.value - 1), 0);
    }
  }
}
