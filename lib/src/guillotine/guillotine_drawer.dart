import 'dart:math';

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
  double value = 0.0;
  double position = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );

    if (!widget.startOpen) {
      animationController.value = 1.0;
      value = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = 420.0;
    final w = 220.0;
    final b = MediaQuery.of(context).padding.top + kToolbarHeight;

    if (!widget.leftSide) {
      position = w;
    }

    print('msg =  $b ${b / h}');

    return Container(
      color: Colors.orange,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: widget.leftSide ? -b : null,
                  right: !widget.leftSide ? -b : null,
                  child: Transform.rotate(
                    alignment: AlignmentDirectional(b / w, -1),
                    angle: pi * animationController.value / 2,
                    child: SizedBox(
                      width: w + b,
                      height: h,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: widget.leftSide ? b : null,
                            right: !widget.leftSide ? b : null,
                            child: Container(
                              width: w,
                              height: h,
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            left: widget.leftSide ? 0.0 : null,
                            right: !widget.leftSide ? 0.0 : null,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Container(
                                width: h,
                                height: b,
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
                  child: widget.iconMenu,
                ),
              ],
            ),
          ),
          Row(
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
                onChanged: (v) {
                  setState(() {
                    value = v;
                    animationController.value = v;
                  });
                },
              ),
              Text('Value ${value.toStringAsFixed(2)}')
            ],
          )
        ],
      ),
    );
  }
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
