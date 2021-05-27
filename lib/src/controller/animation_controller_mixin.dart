import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

mixin AnimationControllerMixin {
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
  bool get isAnimating => animationController.isAnimating;
  double get drawerPosition => animationController.value;
}
