import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/config.dart';

import 'tale_settings.dart';

/// {@template guillotine_settings}
///
/// Data class to handle the particular settings for [GuillotineDrawerWidget]
/// This class help a [TaleDrawer] to build the `Drawer` and define some special characteristics
///
/// {@endtemplate}
class GuillotineSettings implements TaleSettings {
  const GuillotineSettings({
    this.iconMenu,
    this.appBar,
    this.iconCurve = Curves.linear,
    this.guillotineCurveIn = Curves.bounceIn,
    this.guillotineCurveOut = Curves.bounceOut,
    this.rotateIconMenu = true,
    this.fixedAppBar = true,
  });

  /// Set a custom appBar widget, with this you can hide the app bar when guillotine animation start
  final Widget? appBar;

  /// Fix the app bar when the animation start
  final bool fixedAppBar;

  /// Set a custom icon for the menu
  final Widget? iconMenu;

  /// Disable the rotation for the `iconMenu`
  final bool rotateIconMenu;

  /// Curve for the rotation animation in `iconMenu`
  final Curve iconCurve;

  /// Curve for guillotine animation when reverse start
  final Curve guillotineCurveIn;

  /// Curve for guillotine animation when start
  final Curve guillotineCurveOut;

  @override
  Duration get duration => const Duration(milliseconds: 1000);

  /// Flag for no show appBar
  bool get noAppBar => appBar == null;

  /// Flag for no show iconMenu
  bool get menuVisible => iconMenu != null;
}
