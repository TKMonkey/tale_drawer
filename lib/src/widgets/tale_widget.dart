import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/config.dart';
import 'package:tale_drawer/src/controller/animation_controller_mixin.dart';
import 'package:tale_drawer/src/controller/tale_controller.dart';
import 'package:tale_drawer/src/misc/drag_helper.dart';
import 'package:tale_drawer/src/misc/drawer_listener.dart';

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

class TaleDrawer extends StatefulWidget {
  const TaleDrawer({
    Key? key,
    required this.type,
    required this.drawer,
    required this.body,
    this.drawerBackground = const Color(0xff2E2C3C),
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.settings,
    this.listener,
    this.controller,
  })  : assert(settings == null ||
            (type == TaleType.Flip && settings is FlipSettings) ||
            (type == TaleType.Guillotine && settings is GuillotineSettings) ||
            (type == TaleType.Zoom && settings is ZoomSettings)),
        super(key: key);

  final TaleType type;
  final Widget drawer;
  final Widget body;
  final Color drawerBackground;
  final SideState sideState;
  final DrawerState drawerState;
  final TaleSettings? settings;
  final DrawerListener? listener;
  final TaleController? controller;

  @override
  // ignore: no_logic_in_create_state
  TaleDrawerState createState() {
    switch (type) {
      case TaleType.Flip:
        return FlipDrawerWidget();
      case TaleType.Guillotine:
        return GuillotineDrawerWidget();
      case TaleType.Zoom:
        return ZoomDrawerWidget();
    }
  }
}

abstract class TaleDrawerState extends State<TaleDrawer>
    with SingleTickerProviderStateMixin, AnimationControllerMixin {
  void initControllFlags();
  void initAnimations();
  void initDragUtils();
  TaleSettings get settings;
  late DragUtils dragUtils;

  late double delta;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: settings.duration,
    )
      ..addStatusListener((s) => statusListener(s, widget.listener))
      ..addListener(() {
        if (animationController.isAnimating) {
          statusListenerAnimated(animationController.value, widget.listener);
        }
      });

    animationController.value = isStartedOpen ? 1.0 : 0.0;
    widget.controller?.addState(this);

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
