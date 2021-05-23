import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tale_drawer/src/guillotine/guillotine_states.dart';

import 'widget/app_bar_widget.dart';
import 'widget/content_widget.dart';
import 'widget/menu_icon_widget.dart';

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
    this.iconMenu,
    this.appBar,
    this.body = const SizedBox(),
    this.drawerContent = const SizedBox(),
    this.backgroundColor = const Color(0xff2E2C3C),
    this.duration = const Duration(milliseconds: 700),
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.rotateIconMenu = true,
    this.hideAppBar = true,
    this.onOpen,
    this.onClose,
    this.controller,
  }) : super(key: key);

  final Widget? appBar;
  final Widget? iconMenu;
  final Widget body;
  final Widget drawerContent;
  final Color backgroundColor;
  final Duration duration;
  final SideState sideState;
  final DrawerState drawerState;
  final bool rotateIconMenu;
  final bool hideAppBar;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;
  final GuillotineController? controller;

  @override
  _GuillotineDrawerState createState() => _GuillotineDrawerState();
}

class _GuillotineDrawerState extends State<GuillotineDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationGuillotine;
  late Animation<double> animationIcon;
  late Animation<double> animationAppBarOppacity;
  late Animation<double> animationContentOppacity;

  late double delta;
  late bool noBar;
  late bool leftSide;
  late bool startOpen;

  double rotation = 1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener(statusListener);

    initControllFlags();
    initAnimations();

    widget.controller?._addState(this);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final height = size.height;
    final width = size.width;
    final barSize = noBar ? 0.0 : mediaQuery.padding.top + kToolbarHeight;

    return Scaffold(
      body: Stack(
        children: [
          widget.body,
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => Stack(
              children: [
                ContentWidget(
                  drawerContent: widget.drawerContent,
                  animationGuillotine: animationGuillotine,
                  animationContentOppacity: animationContentOppacity,
                  barSize: barSize,
                  width: width,
                  height: height,
                  hideAppBar: widget.hideAppBar,
                  backgroundColor: widget.backgroundColor,
                ),
                AppbarWidget(
                  appBar: widget.appBar,
                  animationAppBarOppacity: animationAppBarOppacity,
                  animationGuillotine: animationGuillotine,
                  noBar: noBar,
                  barSize: barSize,
                  width: width,
                  height: height,
                  hideAppBar: widget.hideAppBar,
                  delta: delta,
                ),
              ],
            ),
          ),
          Positioned(
            left: leftSide ? 0.0 : null,
            right: !leftSide ? 0.0 : null,
            child: MenuIconWidget(
              animationIcon: animationIcon,
              iconMenu: widget.iconMenu,
              rotateIconMenu: widget.rotateIconMenu,
              delta: delta,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void initAnimations() {
    animationGuillotine = Tween(begin: delta / 2, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.bounceOut),
        reverseCurve: Curves.bounceIn,
      ),
    );

    animationIcon = Tween(begin: 0.0, end: 1.0).animate(animationController);

    animationAppBarOppacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.27),
        reverseCurve: const Interval(0.6, 0.67),
      ),
    );

    animationContentOppacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.27, 0.8),
        reverseCurve: const Interval(0.7, 0.72),
      ),
    );
  }

  void initControllFlags() {
    leftSide = widget.sideState == SideState.LEFT;
    startOpen = widget.drawerState == DrawerState.CLOSED;

    animationController.value = startOpen ? 0.0 : 1.0;
    rotation = leftSide ? -1 : 1;
    delta = rotation * pi;

    noBar = widget.appBar == null;
  }

  void statusListener(AnimationStatus status) {
    if (animationController.status == AnimationStatus.completed) {
      widget.onOpen?.call();
    } else if (animationController.status == AnimationStatus.dismissed) {
      widget.onClose?.call();
    }
  }

  void _open() {
    animationController.forward();
  }

  //close the panel
  void _close() {
    animationController.reverse();
  }

  void _start() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.reverse();
    } else if (animationController.status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }

  //returns whether or not the
  //panel is open
  bool get _isPanelOpen => animationController.value == 1.0;

  //returns whether or not the
  //panel is closed
  bool get _isPanelClosed => animationController.value == 0.0;
}

class GuillotineController {
  _GuillotineDrawerState? _guillotineState;

  // ignore: use_setters_to_change_properties
  void _addState(_GuillotineDrawerState guillotineState) {
    _guillotineState = guillotineState;
  }

  bool get isAttached => _guillotineState != null;

  void close() {
    assert(isAttached,
        'GuillotineController must be attached to a SlidingUpPanel');
    return _guillotineState!._close();
  }

  void open() {
    assert(isAttached,
        'GuillotineController must be attached to a SlidingUpPanel');
    return _guillotineState!._open();
  }

  void start() {
    assert(isAttached,
        'GuillotineController must be attached to a SlidingUpPanel');
    return _guillotineState!._start();
  }

  bool get isPanelOpen {
    assert(isAttached,
        'GuillotineController must be attached to a SlidingUpPanel');
    return _guillotineState!._isPanelOpen;
  }

  bool get isPanelClosed {
    assert(isAttached,
        'GuillotineController must be attached to a SlidingUpPanel');
    return _guillotineState!._isPanelClosed;
  }
}
