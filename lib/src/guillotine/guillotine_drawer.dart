import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'widget/app_bar_widget.dart';
import 'widget/content_widget.dart';
import 'widget/menu_icon_widget.dart';

const duration = Duration(milliseconds: 700);

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
    this.iconMenu,
    this.appBar,
    this.body = const SizedBox(),
    this.drawerContent = const SizedBox(),
    this.backgroundColor = const Color(0xff2E2C3C),
    this.leftSide = true,
    this.startOpen = false,
    this.rotateIconMenu = true,
    this.hideAppBar = true,
    this.onOpen,
    this.onClose,
  }) : super(key: key);

  final Widget? appBar;
  final Widget? iconMenu;
  final Widget body;
  final Widget drawerContent;
  final Color backgroundColor;
  final bool leftSide;
  final bool startOpen;
  final bool rotateIconMenu;
  final bool hideAppBar;
  final VoidCallback? onOpen;
  final VoidCallback? onClose;

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

  double value = 0.0;
  double rotation = 1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    )..addStatusListener(statusListener);

    initControllFlags();
    initAnimations();
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
            left: widget.leftSide ? 0.0 : null,
            right: !widget.leftSide ? 0.0 : null,
            child: MenuIconWidget(
              animationIcon: animationIcon,
              iconMenu: widget.iconMenu,
              rotateIconMenu: widget.rotateIconMenu,
              delta: delta,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (animationController.status ==
                        AnimationStatus.completed) {
                      animationController.reverse();
                    } else {
                      animationController.forward();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: Colors.blue,
                  ),
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.star,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Slider(
                  value: value,
                  max: animationController.upperBound,
                  onChanged: (v) {
                    setState(() {
                      value = v;
                      animationController.value = v;
                    });
                  },
                ),
                Text('Value ${value.toStringAsFixed(2)}')
              ],
            ),
          )
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
    animationController.value = !widget.startOpen ? 0.0 : 1.0;
    value = !widget.startOpen ? 0.0 : animationController.upperBound;
    rotation = widget.leftSide ? -1 : 1;
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
}
