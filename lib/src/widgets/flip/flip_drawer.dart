import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/controller/drawer_controller.dart';
import 'package:tale_drawer/src/controller/mixn_controller_methods.dart';
import 'package:tale_drawer/src/drawer_states.dart';
import 'package:tale_drawer/src/misc/drawer_listener.dart';

import 'components/body_component.dart';
import 'components/drawer_content_component.dart';
import 'drawer_animation.dart';

class FlipDrawer extends StatefulWidget {
  const FlipDrawer({
    Key? key,
    required this.drawer,
    required this.body,
    this.duration = const Duration(milliseconds: 700),
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.drawerWidth = 250.0,
    this.flipMaxValue = 0.95,
    this.toggleToClose = true,
    this.type = DrawerAnimation.FLIP,
    this.listener,
    this.controller,
  })  : assert(flipMaxValue >= 0.75 && flipMaxValue <= 1.0),
        super(key: key);

  final Widget drawer;
  final Widget body;
  final Duration duration;
  final SideState sideState;
  final DrawerState drawerState;
  final double drawerWidth;
  final double flipMaxValue;
  final bool toggleToClose;
  final DrawerAnimation type;
  final DrawerListener? listener;
  final TaleDrawerController? controller;

  @override
  _FlipDrawerState createState() => _FlipDrawerState();
}

class _FlipDrawerState extends State<FlipDrawer>
    with SingleTickerProviderStateMixin, ControllerMethods {
  late Animation<double> animationFlip;
  late Animation<double> animationTranslate;

  double rotate = 1.0;

  late bool leftSide;
  late bool startOpen;
  late double delta;
  late double translate;
  late double wSize;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((s) => statusListener(s, widget.listener));

    initControllFlags();
    initAnimations();

    widget.controller?.addState(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Stack(
          children: [
            DrawerContentWidget(
              animationTranslate: animationTranslate,
              animationFlip: animationFlip,
              type: widget.type,
              delta: delta,
              rotate: rotate,
              leftSide: leftSide,
              drawerWidth: widget.drawerWidth,
              wSize: wSize,
              translate: translate,
              drawerContent: widget.drawer,
            ),
            GestureDetector(
              onTap: () {
                if (isDrawerOpen && widget.toggleToClose) {
                  start();
                }
              },
              behavior: HitTestBehavior.translucent,
              child: BodyWidget(
                animationTranslate: animationTranslate,
                animationFlip: animationFlip,
                delta: delta,
                drawerWidth: widget.drawerWidth,
                leftSide: leftSide,
                body: widget.body,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void initAnimations() {
    animationFlip =
        Tween(begin: 0.0, end: widget.flipMaxValue * pi / 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    animationTranslate = CurvedAnimation(
      parent: animationController,
      curve: Curves.linear,
    );
  }

  void initControllFlags() {
    leftSide = widget.sideState == SideState.LEFT;
    startOpen = widget.drawerState == DrawerState.OPEN;
    animationController.value = !startOpen ? 0.0 : 1.0;

    delta = leftSide ? 1.0 : -1.0;
    translate = leftSide ? 1.0 : 0.0;
    wSize = delta * translate - delta;

    if (widget.type != DrawerAnimation.FLIP) {
      rotate = 0.0;
    }
  }
}
