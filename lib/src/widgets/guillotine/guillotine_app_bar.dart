import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/guillotine_settings.dart';

/// {@template guillotine_app_bar}
///
/// This widget is to create a custom AppBar of [TaleDrawer] when is [GuillotineDrawerWidget]
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the appbar animation
/// Zoom animation is compose by: `Rotate` and `Fade`
///
/// We use `RotateBox` to rotate the appBar in directon depends of [SideState]
///
///
/// {@endtemplate}

class GuillotineAppbar extends StatelessWidget {
  const GuillotineAppbar({
    Key? key,
    required this.animationAppBarOppacity,
    required this.animationGuillotine,
    required this.barSize,
    required this.delta,
    required this.quarterTurns,
    required this.topAligment,
    required this.settings,
  }) : super(key: key);

  final Animation<double> animationAppBarOppacity;
  final Animation<double> animationGuillotine;
  final double barSize;
  final double delta;
  final int quarterTurns;
  final Alignment topAligment;

  final GuillotineSettings settings;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Visibility(
      visible: !settings.noAppBar,
      child: FadeTransition(
        opacity: settings.fixedAppBar
            ? animationAppBarOppacity
            : kAlwaysCompleteAnimation,
        child: Transform.rotate(
          angle: _appBarRotateAngle,
          origin: Offset(0, barSize),
          alignment: topAligment,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: barSize),
            child: RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                width: size.height,
                height: barSize,
                child: FittedBox(
                  alignment: Alignment.topLeft,
                  child: RotatedBox(
                    quarterTurns: quarterTurns,
                    child: SizedBox(
                      width: size.width,
                      height: barSize,
                      child: SafeArea(
                        bottom: false,
                        child: Center(
                          child: settings.appBar,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double get _appBarRotateAngle =>
      delta * (settings.fixedAppBar ? animationGuillotine.value : math.pi / 2);
}
