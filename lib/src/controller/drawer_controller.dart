import 'mixn_controller_methods.dart';

class TaleDrawerController<State extends ControllerMethods> {
  State? _drawerState;

  // ignore: use_setters_to_change_properties
  void addState(State guillotineState) {
    _drawerState = guillotineState;
  }

  bool get isAttached => _drawerState != null;

  void close() {
    assert(isAttached, 'DrawerController must be attached to a DrawerWidget');
    return _drawerState!.close();
  }

  void open() {
    assert(isAttached, 'DrawerController must be attached to a DrawerWidget');
    return _drawerState!.open();
  }

  void start() {
    assert(isAttached, 'DrawerController must be attached to a DrawerWidget');
    return _drawerState!.start();
  }

  bool get isDrawerOpen {
    assert(isAttached, 'DrawerController must be attached to a DrawerWidget');
    return _drawerState!.isDrawerOpen;
  }

  bool get isDrawerClosed {
    assert(isAttached, 'DrawerController must be attached to a DrawerWidget');
    return _drawerState!.isDrawerClosed;
  }

  double get panelPosition {
    assert(isAttached, "DrawerController must be attached to a DrawerWidget");
    return _drawerState!.drawerPosition;
  }
}
