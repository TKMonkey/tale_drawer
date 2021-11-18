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
          ..translate(slideSize * _animValue)
          ..rotateZ(_animValue * _degToRad(settings.rotation))
          ..scale(_contentScaleX, _contentScaleY),
        alignment: centerAligment,
        child: ClipRRect(
          borderRadius: _startAnimated
              ? BorderRadius.circular(settings.radius)
              : BorderRadius.zero,
          child: Stack(
            children: [
              body,
              if (_isOpen && settings.closeOnTapBody)
                GestureDetector(
                  onTap: () {
                    _run(animationController);
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    // ..scale(contentScaleX, contentScaleY)
  }

  double get _animValue => animationController.value;
  double get _contentScaleX => 1.0 - (0.3 * _animValue);
  double get _contentScaleY =>
      1.0 - ((0.3 - settings.addHeightScale) * _animValue);

  bool get _startAnimated => animationController.value != 0;
  double _degToRad(double deg) => deg * (math.pi / 180.0);
  bool get _isOpen => animationController.isCompleted;

  bool get _isAnimationDismissed =>
      animationController.status == AnimationStatus.dismissed;
  bool get _isAnimationCompleted =>
      animationController.status == AnimationStatus.completed;

  void _run(AnimationController animationController) {
    if (_isAnimationCompleted) {
      animationController.reverse();
    } else if (_isAnimationDismissed) {
      animationController.forward();
    }
  }
}
