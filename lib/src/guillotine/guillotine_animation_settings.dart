import 'package:flutter/animation.dart';
import 'package:tale_drawer/tale_drawer.dart';

class GuillotineAnimationSettings {
  const GuillotineAnimationSettings({
    this.duration = const Duration(milliseconds: 700),
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
