import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tale_drawer/src/controller/tale_controller.dart';
import 'package:tale_drawer/src/controller/animation_controller_mixin.dart';
import 'package:tale_drawer/src/config/drawer_states.dart';
import 'package:tale_drawer/src/misc/drawer_listener.dart';
import 'package:tale_drawer/tale_drawer.dart';

import 'components/app_bar_widget.dart';
import 'components/drawer_content_widget.dart';
import 'components/menu_icon_widget.dart';
import 'guillotine_settings.dart';

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
    required this.body,
    required this.drawer,
    this.iconMenu,
    this.appBar,
    this.backgroundColor = const Color(0xff2E2C3C),
    this.settings = const GuillotineSettings(),
    this.listener,
    this.controller,
  }) : super(key: key);

  final Widget body;
  final Widget drawer;
  final Widget? appBar;
  final Widget? iconMenu;
  final Color backgroundColor;
  final GuillotineSettings settings;
  final DrawerListener? listener;
  final TaleController? controller;

  @override
  _GuillotineDrawerState createState() => _GuillotineDrawerState();
}

class _GuillotineDrawerState extends State<GuillotineDrawer>
    with SingleTickerProviderStateMixin, AnimationControllerMixin {
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
      duration: widget.settings.duration,
    )..addStatusListener((s) => statusListener(s, widget.listener));

    initControllFlags();
    initAnimations();

    widget.controller?.addState(this);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final height = size.height;
    final width = size.width;
    final barSize = noBar ? 0.0 : mediaQuery.padding.top + kToolbarHeight;

    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Stack(
          children: [
            widget.body,
            Stack(
              children: [
                DrawerContentWidget(
                  drawerContent: widget.drawer,
                  animationGuillotine: animationGuillotine,
                  animationContentOppacity: animationContentOppacity,
                  barSize: barSize,
                  width: width,
                  height: height,
                  hideAppBar: widget.settings.hideAppBar,
                  leftSide: leftSide,
                  backgroundColor: widget.backgroundColor,
                ),
                Positioned(
                  left: leftSide ? 0.0 : null,
                  right: !leftSide ? 0.0 : null,
                  child: AppbarWidget(
                    appBar: widget.appBar,
                    animationAppBarOppacity: animationAppBarOppacity,
                    animationGuillotine: animationGuillotine,
                    noBar: noBar,
                    barSize: barSize,
                    width: width,
                    height: height,
                    hideAppBar: widget.settings.hideAppBar,
                    delta: delta,
                    leftSide: leftSide,
                  ),
                ),
              ],
            ),
            Positioned(
              left: leftSide ? 0.0 : null,
              right: !leftSide ? 0.0 : null,
              child: MenuIconWidget(
                animationIcon: animationIcon,
                iconMenu: widget.iconMenu,
                rotateIconMenu: widget.settings.rotateIconMenu,
                delta: delta,
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
    animationGuillotine = Tween(begin: delta / 2, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.8,
          curve: widget.settings.guillotineCurveOut,
        ),
        reverseCurve: Interval(
          0.0,
          0.8,
          curve: widget.settings.guillotineCurveIn,
        ),
      ),
    );

    animationIcon = Tween(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: widget.settings.iconCurve,
      ),
    );

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
        curve: const Interval(0.27, 0.3),
        reverseCurve: const Interval(0.7, 0.72),
      ),
    );
  }

  void initControllFlags() {
    leftSide = widget.settings.sideState == SideState.LEFT;
    startOpen = widget.settings.drawerState == DrawerState.OPEN;

    animationController.value = !startOpen ? 0.0 : 1.0;
    rotation = leftSide ? -1 : 1;
    delta = rotation * pi;

    noBar = widget.appBar == null;
  }
}
