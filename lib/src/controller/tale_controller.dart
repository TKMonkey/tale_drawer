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
    with OpenFunction, CloseFunction, StartFunction, GetPositionFunction {
  void open() => openFunction();

  void close() => closeFunction();

  void start() => startFunction();

  bool get isDrawerOpen => isOpenFunction;

  bool get isDrawerClosed => isClosedFunction;

  double get drawerPosition => getPositionFunction;
}
