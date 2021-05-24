import 'dart:math';

import 'package:flutter/material.dart';

import 'drawer_animation.dart';

class FlipDrawer extends StatefulWidget {
  const FlipDrawer({
    Key? key,
    required this.drawer,
    required this.body,
    this.duration = const Duration(milliseconds: 700),
    this.drawerWidth = 250.0,
    this.flipMaxValue = 0.95,
    this.type = DrawerAnimation.FLIP,
  })  : assert(flipMaxValue >= 0.75 && flipMaxValue <= 1.0),
        super(key: key);

  final Widget drawer;
  final Widget body;
  final Duration duration;
  final double drawerWidth;
  final double flipMaxValue;
  final DrawerAnimation type;

  @override
  _FlipDrawerState createState() => _FlipDrawerState();
}

class _FlipDrawerState extends State<FlipDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationFlip;

  double value = 0.0;
  double staticAnimation = 1.0;
  double translateAnimation = 1.0;
  double delta = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    animationFlip =
        Tween(begin: 0.0, end: widget.flipMaxValue * pi / 2).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    if (widget.type == DrawerAnimation.STATIC) {
      staticAnimation = 0.0;
    } else if (widget.type == DrawerAnimation.TRANSLATE) {
      translateAnimation = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: Offset(
              widget.drawerWidth *
                  (animationController.value - 1) *
                  staticAnimation,
              0,
            ),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animationFlip.value *
                    (1 - animationController.value) *
                    staticAnimation *
                    translateAnimation),
              alignment: Alignment.centerRight,
              child: Container(
                width: widget.drawerWidth,
                height: size.height,
                color: Colors.red,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(
              widget.drawerWidth * animationController.value,
              0,
            ),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-animationFlip.value),
              alignment: Alignment.centerLeft,
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
}
