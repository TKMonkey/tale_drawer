import 'package:flutter/material.dart';

class DragUtils {
  DragUtils({
    required this.animationController,
    required this.maxSlide,
    this.minDragStartEdge = 60,
    this.dissableDrag = false,
  }) : maxDragStartEdge = maxSlide - 16;

  final double maxSlide;
  final double minDragStartEdge;
  final double maxDragStartEdge;
  final AnimationController animationController;
  final bool dissableDrag;
  bool canBeDragged = false;

  void onDragStart(DragStartDetails details) {
    if (dissableDrag) return;

    final bool isDragStartFromLeft = animationController.isDismissed &&
        details.localPosition.dx < minDragStartEdge;
    final bool isDragFinishFromRight = animationController.isCompleted &&
        details.localPosition.dx > maxDragStartEdge;

    canBeDragged = isDragFinishFromRight || isDragStartFromLeft;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (dissableDrag) return;

    if (canBeDragged) {
      final double delta = (details.primaryDelta ?? 0) / maxSlide;
      animationController.value += delta;
    }
  }

  void onDragEnd(DragEndDetails details) {
    if (dissableDrag) return;

    if (animationController.isCompleted || animationController.isDismissed) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
      final double visualVelocity =
          details.velocity.pixelsPerSecond.dx / maxSlide;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  void close() => animationController.reverse();

  void open() => animationController.forward();
}
