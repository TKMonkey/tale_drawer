import 'package:flutter/material.dart';
import 'package:tale_drawer/src/widgets/tale_widget.dart';

import 'tale_settings.dart';

/// {@template flip_settings}
///
/// Data class to handle the particular settings for [FlipDrawerWidget]
/// This class help a [TaleDrawer] to build the `Drawer` and define some special characteristics
///
/// {@endtemplate}
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

  /// This is the with for the content of `Drawer` define in [FlipContent]
  final double drawerWidth;

  /// This is the rotation percent in `y` when flip animation is complete, it's like perspective
  final double flipPercent;

  /// Flag to control de drag to open or close in the `Drawer`
  final bool disableDrag;

  /// Flag to close when is tap in zone outside the `Drawer` content
  final bool toggleToClose;

  /// Show shadow(opacity) when flip animation is made in body
  final bool showShadow;

  /// The color of the shadow
  final Color shadowColor;

  /// The flip drawer have two types of animation behavior
  final DrawerAnimation type;

  @override
  Duration get duration => const Duration(milliseconds: 400);

  @override
  TaleDrawerState<TaleSettings> createState() => FlipDrawerWidget(this);
}

/// Is type of animation in the [FlipDrawerWidget]
/// `STATIC` the drawer content is static and flip the body
/// `FLIP` flip body and drawer content
enum DrawerAnimation {
  STATIC,
  FLIP,
}
