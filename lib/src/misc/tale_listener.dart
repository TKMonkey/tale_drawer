import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// {@template tale_listener}
///
/// Set this class to get callbacks when the drawer has some state changes
/// This is part of params in [TaleDrawer]
///
/// {@endtemplate}
class TaleListener {
  TaleListener({
    this.onOpen,
    this.onClose,
    this.onAnimated,
  });

  /// Callback when drawer is open
  final VoidCallback? onOpen;

  /// Callback when drawer is close
  final VoidCallback? onClose;

  /// Callback when drawer is animated
  /// Decimal between 0.0 and 1.0
  final ValueChanged<double>? onAnimated;
}

/// Method to attached the statusListener in [TaleDrawer]
/// Only is called when listener is not null
/// This method is hidden for a final user
void statusListener(AnimationStatus status, TaleListener? listener) {
  if (status == AnimationStatus.completed) {
    listener?.onOpen?.call();
  } else if (status == AnimationStatus.dismissed) {
    listener?.onClose?.call();
  }
}

/// Method to attached the listener in [TaleDrawer]
/// Only is called when listener is not null
/// This method is hidden for a final user
void statusListenerAnimated(double value, TaleListener? listener) {
  listener?.onAnimated?.call(value);
}
