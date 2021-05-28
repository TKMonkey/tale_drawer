import 'package:flutter/material.dart';

import 'tale_settings.dart';

class FlipSettings implements TaleSettings {
  const FlipSettings({
    this.drawerWidth = 250.0,
    this.flipPercent = 99,
    this.disableDrag = false,
    this.toggleToClose = true,
    this.type = DrawerAnimation.FLIP,
    this.shadowColor = Colors.black26,
    this.showShadow = true,
  }) : assert(flipPercent >= 75 && flipPercent <= 100);

  final double drawerWidth;
  final double flipPercent;
  final bool disableDrag;
  final bool toggleToClose;
  final bool showShadow;
  final Color shadowColor;
  final DrawerAnimation type;

  @override
  Duration get duration => const Duration(milliseconds: 400);
}

enum DrawerAnimation {
  STATIC,
  TRANSLATE,
  FLIP,
}
