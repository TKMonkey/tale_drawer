import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/zoom_settings.dart';

/// {@template zoom_body}
///
/// This widget is to create a body of [TaleDrawer] when is [ZoomDrawerWidget]
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the zoom animation
/// Zoom animation is compose by: `Translate`, `Scale` and `RotateZ`(Optional)
///
/// This widget can use the `radius` param from [ZoomSettings]
/// With this, the widget creates a Clipper when animationStarted
///
/// This widget can use the `rotation` param from [ZoomSettings]
/// With this, the widget enable the `RotationZ` when animationStarted
///
/// {@endtemplate}
class ZoomDrawerBody extends StatelessWidget {
  const ZoomDrawerBody({
    Key? key,
    required this.body,
    required this.animationController,
    required this.slideSize,
    required this.settings,
    required this.centerAligment,
  }) : super(key: key);

  final Widget body;
  final AnimationController animationController;

  final double slideSize;
  final ZoomSettings settings;
  final Alignment centerAligment;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
          ..translate(slideSize * animValue)
          ..rotateZ(animValue * degToRad(settings.rotation))
          ..scale(contentScaleX, contentScaleY),
        alignment: centerAligment,
        child: ClipRRect(
          borderRadius: startAnimated
              ? BorderRadius.circular(settings.radius)
              : BorderRadius.zero,
          child: body,
        ),
      ),
    );
    // ..scale(contentScaleX, contentScaleY)
  }

  double get animValue => animationController.value;
  double get contentScaleX => 1.0 - (0.3 * animValue);
  double get contentScaleY =>
      1.0 - ((0.3 - settings.addHeightScale) * animValue);

  bool get startAnimated => animationController.value != 0;
  double degToRad(double deg) => deg * (math.pi / 180.0);
}
