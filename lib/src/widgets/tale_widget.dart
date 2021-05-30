import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/config.dart';
import 'package:tale_drawer/src/controller/tale_controller.dart';
import 'package:tale_drawer/src/misc/tale_listener.dart';
import 'package:tools_tkmonkey/tools_tkmonkey_flutter.dart';

import 'flip/flip_body.dart';
import 'flip/flip_content.dart';
import 'guillotine/guillotine_app_bar.dart';
import 'guillotine/guillotine_content.dart';
import 'guillotine/guillotine_menu_icon.dart';
import 'zoom/zoom_body.dart';
import 'zoom/zoom_content.dart';

part 'flip/flip_drawer_widget.dart';
part 'guillotine/guillotine_drawer_widget.dart';
part 'zoom/zoom_drawer_widget.dart';

/// {@template tale_widget}
///
/// Set the definition for drawer and configure the params to have a different options
///
/// This widget transform the `type` into a `Flip`, `Guillotine` or `Zoom`
/// And define the states to change the animation behavior
///
/// `delta`: Depends of the [SideState] delta is positive or negative to change the animation behavior
/// with this param you manipulate the direction or the animation
///
/// `dragUtils`: Is the helper to drag the `Flip` or `Zoom`
///
/// {@endtemplate}
class TaleDrawer extends StatefulWidget {
  const TaleDrawer({
    Key? key,
    required this.drawer,
    required this.settings,
    required this.body,
    this.drawerBackground = const Color(0xff2E2C3C),
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.listener,
    this.controller,
  }) : super(key: key);

  /// The widget that represented the content in the drawer
  final Widget drawer;

  /// The Widget displayed overtop the `drawer`, like Scaffold body
  final Widget body;

  /// Background of drawer content widget
  final Color drawerBackground;

  /// Chooose between Left and Right side to change animation direction
  final SideState sideState;

  /// Choose the drawer start open or close
  final DrawerState drawerState;

  /// Set specific settings for the type of `drawer`, help to set a custom behavior for `TaleDrawer`
  final TaleSettings settings;

  /// Set listener to get updates, of changes in state
  final TaleListener? listener;

  /// Create a custom controller to control the animation behavior and state  of the `drawer`
  final TaleController? controller;

  @override
  // ignore: no_logic_in_create_state
  TaleDrawerState createState() => settings.createState();
}

abstract class TaleDrawerState<T extends TaleSettings> extends State<TaleDrawer>
    with SingleTickerProviderStateMixin, TKMControllerMixin {
  TaleDrawerState(this._settings);

  void initControllFlags();

  void initAnimations();

  void initDragUtils(Size size);

  final T _settings;

  T get settings => _settings;
  late TKMDragHelper dragUtils;
  late double delta;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: settings.duration,
    );

    if (widget.listener != null &&
        (widget.listener?.onOpen != null || widget.listener?.onClose != null)) {
      animationController
          .addStatusListener((s) => statusListener(s, widget.listener));
    }

    if (widget.listener != null && widget.listener?.onAnimated != null) {
      animationController.addListener(() {
        if (animationController.isAnimating) {
          statusListenerAnimated(animationController.value, widget.listener);
        }
      });
    }

    animationController.value = isStartedOpen ? 1.0 : 0.0;
    widget.controller?.addState = this;

    initAnimations();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  bool get isLeftSide => widget.sideState == SideState.LEFT;

  bool get isStartedOpen => widget.drawerState == DrawerState.OPEN;

  Alignment get centerAligment =>
      isLeftSide ? Alignment.centerRight : Alignment.centerLeft;

  Alignment get topAligment =>
      isLeftSide ? Alignment.topLeft : Alignment.topRight;
}
