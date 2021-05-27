import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/zoom_settings.dart';

class ZoomDrawerBody extends StatelessWidget {
  const ZoomDrawerBody({
    Key? key,
    required this.animationController,
    required this.delta,
    required this.settings,
    required this.isLeftSide,
  }) : super(key: key);

  final AnimationController animationController;
  final double delta;
  final ZoomSettings settings;
  final bool isLeftSide;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final animValue = animationController.value;
        final slideAmount = delta * settings.maxSlide * animValue;
        final contentScale = 1.0 - (0.3 * animValue);
        return Transform(
          transform: Matrix4.translationValues(slideAmount, 0, 0)
            ..rotateZ(animValue * degToRad(5))
            ..scale(contentScale, contentScale + 0.1),
          alignment: isLeftSide ? Alignment.centerLeft : Alignment.centerRight,
          child: AnimatedContainer(
            width: size.width,
            height: size.height,
            duration: const Duration(milliseconds: 150),
            curve: Curves.fastLinearToSlowEaseIn,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: startAnimated
                  ? BorderRadius.circular(settings.radius)
                  : BorderRadius.zero,
            ),
          ),
        );
      },
    );
  }

  bool get startAnimated => animationController.value != 0;

  double degToRad(double deg) => deg * (math.pi / 180.0);
}
