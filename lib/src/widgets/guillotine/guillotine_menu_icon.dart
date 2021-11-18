import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/guillotine_settings.dart';

/// {@template guillotine_menu_icon}
///
/// This widget is to create a custom MenuIcon of [TaleDrawer] when is [GuillotineDrawerWidget]
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the menuIcon animation
/// Zoom animation is compose by: `Rotate`
///
/// This widget can use the `rotateIconMenu` param from [GuillotineSettings]
/// With this, the widget is fixed or rotate
///
/// {@endtemplate}
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
              angle: _iconRotateAngle,
              child: settings.iconMenu,
            ),
          ),
        ),
      ),
    );
  }

  double get _iconRotateAngle =>
      settings.rotateIconMenu ? -delta * math.pi * animationIcon.value : 0.0;
}
