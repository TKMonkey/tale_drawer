import 'animation_controller_mixin.dart';

class TaleController<State extends AnimationControllerMixin> {
  State? _drawerState;

  // ignore: use_setters_to_change_properties
  void addState(State guillotineState) {
    _drawerState = guillotineState;
  }

  bool get isAttached => _drawerState != null;

  void close() {
    assert(isAttached, 'TaleController must be attached to a DrawerWidget');
    return _drawerState!.close();
  }

  void open() {
    assert(isAttached, 'TaleController must be attached to a DrawerWidget');
    return _drawerState!.open();
  }

  void start() {
    assert(isAttached, 'TaleController must be attached to a DrawerWidget');
    return _drawerState!.start();
  }

  bool get isDrawerOpen {
    assert(isAttached, 'TaleController must be attached to a DrawerWidget');
    return _drawerState!.isDrawerOpen;
  }

  bool get isDrawerClosed {
    assert(isAttached, 'TaleController must be attached to a DrawerWidget');
    return _drawerState!.isDrawerClosed;
  }

  double get panelPosition {
    assert(isAttached, "TaleController must be attached to a DrawerWidget");
    return _drawerState!.drawerPosition;
  }
}
