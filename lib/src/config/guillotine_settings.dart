import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/config.dart';

import 'tale_settings.dart';

class GuillotineSettings implements TaleSettings {
  const GuillotineSettings({
    this.iconMenu,
    this.appBar,
    this.iconCurve = Curves.linear,
    this.guillotineCurveIn = Curves.bounceIn,
    this.guillotineCurveOut = Curves.bounceOut,
    this.rotateIconMenu = true,
    this.hideAppBar = true,
  });

  final Widget? appBar;
  final Widget? iconMenu;
  final Curve iconCurve;
  final Curve guillotineCurveIn;
  final Curve guillotineCurveOut;
  final bool rotateIconMenu;
  final bool hideAppBar;

  @override
  Duration get duration => const Duration(milliseconds: 1000);

  bool get noAppBar => appBar == null;
  bool get menuVisible => iconMenu != null;
}
