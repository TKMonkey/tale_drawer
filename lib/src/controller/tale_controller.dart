import 'package:tools_tkmonkey/tools_tkmonkey.dart';

/// {@template tale_controller}
///
/// Using `TKMController` to create a custom Controller for the drawer
///
/// The controller use: Open, Close, Start and GetPosition `mixin` from `TKMController`
/// https://github.com/TKMonkey/tools_tkmonkey_flutter
///
/// {@endtemplate}

class TaleController extends TKMController
    with
        ForwardFunction,
        ReverseFunction,
        RunFunction,
        GetPositionFunction,
        StateAnimationFunction {
  void open() => forwardFunction();

  void close() => reverseFunction();

  void start() => runFunction();

  bool get isDrawerOpen => isAnimationCompleted;

  bool get isDrawerClosed => isAnimationDismissed;

  double get drawerPosition => getPositionFunction;
}
