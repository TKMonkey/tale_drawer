import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/config/config.dart';
import 'package:tale_drawer/src/misc/tale_listener.dart';
import 'package:tools_tkmonkey/tools_tkmonkey.dart';

import '../../tale_drawer.dart';
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

abstract class TaleDrawerState<T extends TaleSettings> extends State<TaleDrawer>
    with SingleTickerProviderStateMixin, TKMControllerMixin {
  final T _internalSettings;

  void initControlFlags();

  void initAnimations();

  void initDragUtils(Size size);

  T get settings => _internalSettings;

  late TKMDragHelper dragUtils;
  late double delta;

  TaleDrawerState(this._internalSettings);

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
