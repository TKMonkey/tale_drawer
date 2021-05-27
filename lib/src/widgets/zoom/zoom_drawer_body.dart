import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/zoom_settings.dart';

class ZoomDrawerBody extends StatelessWidget {
  const ZoomDrawerBody({
    Key? key,
    required this.body,
    required this.animationController,
    required this.delta,
    required this.settings,
    required this.centerAligment,
  }) : super(key: key);

  final Widget body;
  final AnimationController animationController;
  final double delta;
  final ZoomSettings settings;
  final Alignment centerAligment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final animValue = animationController.value;
        final slideAmount = delta *
            (settings.maxSlide + size.width * settings.rotation.abs() / 100);

        final contentScaleX = 1.0 - (0.3 * animValue);
        final contentScaleY = 1.0 - ((0.3 + settings.heightScale) * animValue);
        return Transform(
          transform: Matrix4.translationValues(slideAmount * animValue, 0, 0)
            ..rotateZ(animValue * degToRad(settings.rotation))
            ..scale(contentScaleX, contentScaleY),
          alignment: centerAligment,
          child: ClipRRect(
            borderRadius: startAnimated
                ? BorderRadius.circular(settings.radius)
                : BorderRadius.zero,
            child: body,
          ),
        );
      },
    );
    // ..scale(contentScaleX, contentScaleY)
  }

  bool get startAnimated => animationController.value != 0;

  double degToRad(double deg) => deg * (math.pi / 180.0);
}
