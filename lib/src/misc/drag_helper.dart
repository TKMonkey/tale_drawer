import 'package:flutter/material.dart';

class DragUtils {
  DragUtils({
    required this.animationController,
    required this.maxSlide,
    required this.maxDragStartEdge,
    required this.minDragStartEdge,
    required this.delta,
    this.dissableDrag = false,
    this.isLeftSide = true,
  });

  final double maxSlide;

  final double minDragStartEdge;
  final double maxDragStartEdge;
  final double delta;
  final AnimationController animationController;
  final bool dissableDrag;
  final bool isLeftSide;

  bool canBeDragged = false;

  void onDragStart(DragStartDetails details) {
    if (dissableDrag) return;
    final bool isDragStartFromLeft = animationStatudisBySideLeft(!isLeftSide) &&
        details.localPosition.dx < minDragStartEdge;
    final bool isDragFinishFromRight =
        animationStatudisBySideLeft(isLeftSide) &&
            details.localPosition.dx > maxDragStartEdge;

    canBeDragged = isDragFinishFromRight || isDragStartFromLeft;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (dissableDrag) return;

    if (canBeDragged) {
      final double steps = (details.primaryDelta ?? 0) / maxSlide;
      animationController.value = animationController.value + delta * steps;
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

  bool animationStatudisBySideLeft(bool side) =>
      side ? animationController.isDismissed : animationController.isCompleted;

  bool animationStatudisBySideRight(bool side) =>
      side ? animationController.isCompleted : animationController.isDismissed;

  void close() => animationController.reverse();

  void open() => animationController.forward();
}
