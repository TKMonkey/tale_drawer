import 'package:flutter/animation.dart';
import 'package:tale_drawer/src/config/config.dart';

import 'tale_settings.dart';

class GuillotineSettings implements TaleSettings {
  const GuillotineSettings({
    this.iconCurve = Curves.linear,
    this.guillotineCurveIn = Curves.bounceIn,
    this.guillotineCurveOut = Curves.bounceOut,
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.rotateIconMenu = true,
    this.hideAppBar = true,
  });

  final Curve iconCurve;
  final Curve guillotineCurveIn;
  final Curve guillotineCurveOut;
  final SideState sideState;
  final DrawerState drawerState;
  final bool rotateIconMenu;
  final bool hideAppBar;

  @override
  Duration get duration => const Duration(milliseconds: 1000);
}
