import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/zoom_settings.dart';

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
