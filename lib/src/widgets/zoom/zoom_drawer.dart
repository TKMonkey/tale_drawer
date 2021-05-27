import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tale_drawer/src/controller/mixn_controller_methods.dart';
import 'package:tale_drawer/src/drawer_states.dart';

class ZoomDrawer extends StatefulWidget {
  const ZoomDrawer({
    Key? key,
    required this.drawer,
    required this.body,
    this.duration = const Duration(milliseconds: 700),
    this.sideState = SideState.LEFT,
    this.drawerState = DrawerState.CLOSED,
    this.maxSlide = 250,
    this.radius = 34,
    this.backgroundColor = const Color(0xff2E2C3C),
  }) : super(key: key);

  final Widget body;
  final Widget drawer;
  final Duration duration;
  final SideState sideState;
  final DrawerState drawerState;
  final double maxSlide;
  final double radius;
  final Color backgroundColor;

  @override
  _ZoomDrawerState createState() => _ZoomDrawerState();
}

class _ZoomDrawerState extends State<ZoomDrawer>
    with SingleTickerProviderStateMixin, ControllerMethods {
  double value = 0.0;

  late bool leftSide;
  late bool startOpen;
  late double delta;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    initControllFlags();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: widget.backgroundColor,
          child: widget.drawer,
        ),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            final animValue = animationController.value;
            final slideAmount = delta * widget.maxSlide * animValue;
            final contentScale = 1.0 - (0.3 * animValue);
            return Transform(
              transform: Matrix4.translationValues(slideAmount, 0, 0)
                ..rotateZ(animValue * degToRad(15))
                ..scale(contentScale, contentScale),
              alignment:
                  leftSide ? Alignment.centerLeft : Alignment.centerRight,
              child: AnimatedContainer(
                width: size.width,
                height: size.height,
                duration: const Duration(milliseconds: 150),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: drawerPosition != 0
                      ? BorderRadius.circular(widget.radius)
                      : BorderRadius.zero,
                ),
              ),
            );
          },
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
        )
      ],
    );
  }

  double degToRad(double deg) => deg * (pi / 180.0);

  void initControllFlags() {
    leftSide = widget.sideState == SideState.LEFT;
    startOpen = widget.drawerState == DrawerState.OPEN;
    animationController.value = !startOpen ? 0.0 : 1.0;

    delta = leftSide ? 1.0 : -1.0;
  }
}
