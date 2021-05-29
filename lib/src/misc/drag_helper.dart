import 'package:flutter/material.dart';

class DragUtils {
  DragUtils({
    required this.animationController,
    required this.maxSlide,
    required this.maxDragStartEdge,
    required this.minDragStartEdge,
    required this.orientation,
    this.dissableDrag = false,
  });

  /// Limit to slide in the widget or screen
  final double maxSlide;

  /// Edge minimum to start the drag
  final double minDragStartEdge;

  /// Edge maximum to start the drag
  final double maxDragStartEdge;

  /// Animation controller to link animation with the drag
  final AnimationController animationController;

  /// If the user want to disable drag in some cases
  final bool dissableDrag;

  ///This argument is to indicate the direction of start to end
  final DragOrientation orientation;

  /// Flag to indicate is possible to drag the widget
  bool canBeDragged = false;

  /// When drag is start
  void onDragStart(DragStartDetails details) {
    if (dissableDrag) return;

    final bool dragStartLeftToRight = animationStatusBySideLeft &&
        details.localPosition.dx < minDragStartEdge;

    final bool dragStartRightToLeft = animationStatusBySideRight &&
        details.localPosition.dx > maxDragStartEdge;
    canBeDragged = dragStartLeftToRight || dragStartRightToLeft;
  }

  /// When drag is update, update the animationController value
  void onDragUpdate(DragUpdateDetails details) {
    if (dissableDrag) return;

    if (canBeDragged) {
      final double steps = (details.primaryDelta ?? 0) / maxSlide;
      animationController.value = animationController.value + delta * steps;
    }
  }

  /// When drag is end, if is necessary complete or dismiss the animation
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

  bool get animationStatusBySideLeft =>
      orientation == DragOrientation.LeftToRight
          ? animationController.isDismissed
          : animationController.isCompleted;

  bool get animationStatusBySideRight =>
      orientation == DragOrientation.LeftToRight
          ? animationController.isCompleted
          : animationController.isDismissed;

  void close() => animationController.reverse();

  void open() => animationController.forward();

  double get delta => orientation == DragOrientation.LeftToRight ? 1.0 : -1.0;
}

enum DragOrientation {
  LeftToRight,
  RigthtToLeft,
}

// class DragUtils {
//   DragUtils({
//     required this.animationController,
//     required this.maxSlide,
//     required this.maxDragStartEdge,
//     required this.minDragStartEdge,
//     required this.delta,
//     this.dissableDrag = false,
//     this.isLeftSide = true,
//   });

//   final double maxSlide;

//   final double minDragStartEdge;
//   final double maxDragStartEdge;
//   final double delta;
//   final AnimationController animationController;
//   final bool dissableDrag;
//   final bool isLeftSide;

//   bool canBeDragged = false;

//   void onDragStart(DragStartDetails details) {
//     if (dissableDrag) return;
//     final bool isDragStartFromLeft = animationStatudisBySideLeft(isLeftSide) &&
//         details.localPosition.dx < minDragStartEdge;
//     final bool isDragFinishFromRight =
//         animationStatudisBySideRight(isLeftSide) &&
//             details.localPosition.dx > maxDragStartEdge;

//     canBeDragged = isDragFinishFromRight || isDragStartFromLeft;
//   }

//   void onDragUpdate(DragUpdateDetails details) {
//     if (dissableDrag) return;

//     if (canBeDragged) {
//       final double steps = (details.primaryDelta ?? 0) / maxSlide;
//       animationController.value = animationController.value + delta * steps;
//     }
//   }

//   void onDragEnd(DragEndDetails details) {
//     if (dissableDrag) return;

//     if (animationController.isCompleted || animationController.isDismissed) {
//       return;
//     }
//     if (details.velocity.pixelsPerSecond.dx.abs() >= 365) {
//       final double visualVelocity =
//           details.velocity.pixelsPerSecond.dx / maxSlide;
//       animationController.fling(velocity: visualVelocity);
//     } else if (animationController.value < 0.5) {
//       close();
//     } else {
//       open();
//     }
//   }

//   bool animationStatudisBySideLeft(bool side) =>
//       side ? animationController.isCompleted : animationController.isDismissed;

//   bool animationStatudisBySideRight(bool side) =>
//       side ? animationController.isDismissed : animationController.isCompleted;

//   void close() => animationController.reverse();

//   void open() => animationController.forward();
// }
