import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

class DrawerListener {
  DrawerListener({
    this.onOpen,
    this.onClose,
    this.onAnimated,
  });

  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final ValueChanged<double>? onAnimated;
}

void statusListener(AnimationStatus status, DrawerListener? listener) {
  if (status == AnimationStatus.completed) {
    listener?.onOpen?.call();
  } else if (status == AnimationStatus.dismissed) {
    listener?.onClose?.call();
  }
}

void statusListenerAnimated(double value, DrawerListener? listener) {
  listener?.onAnimated?.call(value);
}
