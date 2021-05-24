import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

class DrawerListener {
  DrawerListener({this.onOpen, this.onClose});

  final VoidCallback? onOpen;
  final VoidCallback? onClose;
}

void statusListener(AnimationStatus status, DrawerListener? listener) {
  if (status == AnimationStatus.completed) {
    listener?.onOpen?.call();
  } else if (status == AnimationStatus.dismissed) {
    listener?.onClose?.call();
  }
}
