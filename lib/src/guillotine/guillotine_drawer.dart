import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'widgets/default_top_bar_widget.dart';
import 'widgets/icon_menu.dart';

const duration = Duration(milliseconds: 600);

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
    this.iconMenu = const IconMenuAppBar(),
    this.appBar = const DefaultAppBarWidget(),
    this.body = const SizedBox(),
    this.drawerContent = const SizedBox(),
    this.backgroundColor = const Color(0xff2E2C3C),
    this.leftSide = true,
    this.startOpen = false,
    this.rotateIconMenu = true,
    this.hideAppBar = true,
  }) : super(key: key);

  final Widget appBar;
  final Widget iconMenu;
  final Widget body;
  final Widget drawerContent;
  final Color backgroundColor;
  final bool leftSide;
  final bool startOpen;
  final bool rotateIconMenu;
  final bool hideAppBar;

  @override
  _GuillotineDrawerState createState() => _GuillotineDrawerState();
}

class _GuillotineDrawerState extends State<GuillotineDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationGuillotine;
  late Animation<double> animationAppBarOppacity;

  late double delta;

  double value = 0.0;
  late double rotation = 1;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    animationController.value = widget.startOpen ? 0.0 : 1.0;
    value = widget.startOpen ? 0.0 : animationController.upperBound;
    rotation = widget.leftSide ? -1 : 1;
    delta = rotation * pi;

    animationGuillotine = Tween(begin: delta / 2, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );

    animationAppBarOppacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final height = size.height;
    final width = size.width;
    final barSize = mediaQuery.padding.top + kToolbarHeight;
    final alignmentXPoint = rotation * (1 - 2 * (barSize / (width + barSize)));

    print('msg & ${(barSize / (width + barSize))}');
    print('msg => ${(barSize / (width)) * width}');
    print('msg = ${mediaQuery.padding.top + kToolbarHeight}');

    return Stack(
      children: [
        widget.body,
        Stack(
          children: [
            Transform.rotate(
              angle: animationGuillotine.value,
              origin: Offset(0, barSize),
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: width,
                height: height,
                child: ColoredBox(
                  color: widget.backgroundColor,
                ),
              ),
            ),
            Transform.rotate(
              angle: appBarRotateAngle,
              origin: Offset(0, barSize),
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: barSize),
                child: RotatedBox(
                  quarterTurns: 1,
                  child: SizedBox(
                    width: height,
                    height: barSize,
                    child: FittedBox(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: width,
                        height: barSize,
                        color: Colors.amber,
                        child: SafeArea(
                          bottom: false,
                          child: Center(
                            child: widget.appBar,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: widget.leftSide ? 0.0 : null,
          right: !widget.leftSide ? 0.0 : null,
          child: FittedBox(
            alignment: Alignment.topLeft,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Transform.rotate(
                  angle: iconRotateAngle,
                  child: widget.iconMenu,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (animationController.status == AnimationStatus.completed) {
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
    );

    // return AnimatedBuilder(
    //   animation: animationGuillotine,
    //   builder: (context, child) => Stack(
    //     children: [
    //       widget.body,
    //       Positioned(
    //         top: 0,
    //         left: widget.leftSide ? -barSize : null,
    //         right: !widget.leftSide ? -barSize : null,
    //         child: Transform.rotate(
    //           alignment: AlignmentDirectional(alignmentXPoint, -1),
    //           angle: delta * animationGuillotine.value,
    //           child: SizedBox(
    //             width: width + barSize,
    //             height: height,
    //             child: ColoredBox(
    //               color: widget.backgroundColor,
    //               child: Stack(
    //                 children: [
    //                   Positioned(
    //                     top: 0,
    //                     left: widget.leftSide ? barSize : null,
    //                     right: !widget.leftSide ? barSize : null,
    //                     child: SizedBox(
    //                       width: width,
    //                       height: height,
    //                       child: widget.drawerContent,
    //                     ),
    //                   ),
    //                   Positioned(
    //                     left: widget.leftSide ? 0.0 : null,
    //                     right: !widget.leftSide ? 0.0 : null,
    //                     child: RotatedBox(
    //                       quarterTurns: 1,
    //                       child: SizedBox(
    //                         width: height,
    //                         height: barSize,
    //                         child: FittedBox(
    //                           alignment: Alignment.topLeft,
    //                           child: SizedBox(
    //                             width: width,
    //                             height: barSize,
    //                             child: SafeArea(
    //                               bottom: false,
    //                               child: Center(
    //                                 child: widget.appBar,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         left: widget.leftSide ? 0.0 : null,
    //         right: !widget.leftSide ? 0.0 : null,
    //         child: FittedBox(
    //           alignment: Alignment.topLeft,
    //           child: SafeArea(
    //             bottom: false,
    //             child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Transform.rotate(
    //                 angle: iconRotateAngle,
    //                 child: widget.iconMenu,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 0,
    //         child: Row(
    //           children: [
    //             const SizedBox(height: 20),
    //             ElevatedButton(
    //               onPressed: () {
    //                 if (animationController.status ==
    //                     AnimationStatus.completed) {
    //                   animationController.reverse();
    //                 } else {
    //                   animationController.forward();
    //                 }
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 shape: const CircleBorder(),
    //                 primary: Colors.blue,
    //               ),
    //               child: const SizedBox(
    //                 width: 50,
    //                 height: 50,
    //                 child: Icon(
    //                   Icons.star,
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Slider(
    //               value: value,
    //               max: animationController.upperBound,
    //               onChanged: (v) {
    //                 setState(() {
    //                   value = v;
    //                   animationController.value = v;
    //                 });
    //               },
    //             ),
    //             Text('Value ${value.toStringAsFixed(2)}')
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  double get iconRotateAngle => widget.rotateIconMenu
      ? -delta * (animationController.upperBound - animationController.value)
      : 0.0;

  double get appBarRotateAngle =>
      widget.hideAppBar ? animationGuillotine.value : delta / 2;
}
