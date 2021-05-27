import 'package:flutter/animation.dart';
import 'package:tale_drawer/tale_drawer.dart';

class GuillotineSettings {
  const GuillotineSettings({
    this.duration = const Duration(milliseconds: 1000),
    this.iconCurve = Curves.linear,
    this.guillotineCurveIn = Curves.bounceIn,
    this.guillotineCurveOut = Curves.bounceOut,
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.rotateIconMenu = true,
    this.hideAppBar = true,
  });

  final Duration duration;
  final Curve iconCurve;
  final Curve guillotineCurveIn;
  final Curve guillotineCurveOut;
  final SideState sideState;
  final DrawerState drawerState;
  final bool rotateIconMenu;
  final bool hideAppBar;
}
