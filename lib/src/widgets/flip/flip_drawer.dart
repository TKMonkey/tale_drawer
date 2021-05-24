import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/controller/drawer_controller.dart';
import 'package:tale_drawer/src/controller/mixn_controller_methods.dart';
import 'package:tale_drawer/src/drawer_states.dart';
import 'package:tale_drawer/src/misc/drawer_listener.dart';

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
  final DrawerAnimation type;
  final DrawerListener? listener;
  final TaleDrawerController? controller;

  @override
  _FlipDrawerState createState() => _FlipDrawerState();
}

class _FlipDrawerState extends State<FlipDrawer>
    with SingleTickerProviderStateMixin, ControllerMethods {
  late Animation<double> animationFlip;

  double value = 0.0;
  double staticAnimation = 1.0;
  double translateAnimation = 1.0;
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
    );

    initControllFlags();
    initAnimations();

    widget.controller?.addState(this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(
              (wSize * size.width) -
                  -delta *
                      widget.drawerWidth *
                      (animationController.value - 1 * translate) *
                      staticAnimation,
              0,
            ),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(delta *
                    animationFlip.value *
                    (1 - animationController.value) *
                    staticAnimation *
                    translateAnimation),
              alignment:
                  leftSide ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: widget.drawerWidth,
                height: size.height,
                color: Colors.red,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              delta * widget.drawerWidth * animationController.value,
              0,
            ),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-delta * animationFlip.value),
              alignment:
                  leftSide ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.amber,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
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
    animationFlip =
        Tween(begin: 0.0, end: widget.flipMaxValue * pi / 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  void initControllFlags() {
    leftSide = widget.sideState == SideState.LEFT;
    startOpen = widget.drawerState == DrawerState.OPEN;
    animationController.value = !startOpen ? 0.0 : 1.0;
    value = !startOpen ? 0.0 : 1.0;

    delta = leftSide ? 1.0 : -1.0;
    translate = leftSide ? 1.0 : 0.0;
    // wSize = leftSide ? 0.0 : 1.0;
    wSize = delta * translate - delta;
    print('msg  + $wSize');

    if (widget.type == DrawerAnimation.STATIC) {
      staticAnimation = 0.0;
    } else if (widget.type == DrawerAnimation.TRANSLATE) {
      translateAnimation = 0.0;
    }
  }
}
