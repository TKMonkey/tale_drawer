import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'widgets/icon_menu.dart';
import 'widgets/top_bar_widget.dart';

const duration = Duration(milliseconds: 600);

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
    this.iconMenu = const IconMenuAppBar(),
    this.leftSide = true,
    this.startOpen = false,
    this.rotateIconMenu = true,
  }) : super(key: key);

  final Widget iconMenu;
  final bool leftSide;
  final bool startOpen;
  final bool rotateIconMenu;

  @override
  _GuillotineDrawerState createState() => _GuillotineDrawerState();
}

class _GuillotineDrawerState extends State<GuillotineDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late double delta;

  double value = 0.0;
  late double rotation = 1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
      upperBound: 0.5,
    );

    animationController.value = widget.startOpen ? 0.0 : 1.0;
    value = widget.startOpen ? 0.0 : animationController.upperBound;
    rotation = widget.leftSide ? -1 : 1;
    delta = rotation * pi;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final height = size.height;
    final width = size.width;
    final barSize = mediaQuery.padding.top + kToolbarHeight;
    final fixPoint = rotation * (1 - 2 * (barSize / (width + barSize)));

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: widget.leftSide ? -barSize : null,
          right: !widget.leftSide ? -barSize : null,
          child: Transform.rotate(
            alignment: AlignmentDirectional(fixPoint, -1),
            angle: delta * animationController.value,
            child: SizedBox(
              width: width + barSize,
              height: height,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: widget.leftSide ? barSize : null,
                    right: !widget.leftSide ? barSize : null,
                    child: Container(
                      width: width,
                      height: height,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    left: widget.leftSide ? 0.0 : null,
                    right: !widget.leftSide ? 0.0 : null,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        width: height,
                        height: barSize,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: widget.leftSide ? 0.0 : null,
          right: !widget.leftSide ? 0.0 : null,
          child: SafeArea(
            child: Transform.rotate(
              angle: iconRotateAngle,
              child: widget.iconMenu,
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
        )
      ],
    );
  }

  double get iconRotateAngle => widget.rotateIconMenu
      ? -delta * (animationController.upperBound - animationController.value)
      : 0.0;
}

// RotatedBox(
//                     quarterTurns: 0,
//                     child: TopBarWidget(
//                       appBar: PreferredSize(
//                         preferredSize: Size.fromHeight(
//                           MediaQuery.of(context).padding.top + kToolbarHeight,
//                         ),
//                         child: Container(
//                           width: size.width,
//                           color: Colors.green,
//                           child: const SafeArea(
//                             bottom: false,
//                             child: Center(
//                               child: Text(
//                                 'My App Drawer',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
