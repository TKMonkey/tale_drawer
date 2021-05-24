import 'package:flutter/animation.dart';

mixin ControllerMethods {
  late AnimationController animationController;

  void open() {
    animationController.forward();
  }

  void close() {
    animationController.reverse();
  }

  void start() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (animationController.status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  bool get isDrawerOpen => animationController.value == 1.0;
  bool get isDrawerClosed => animationController.value == 0.0;
  double get drawerPosition => animationController.value;
}
