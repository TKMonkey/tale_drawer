import 'dart:math';

import 'package:flutter/material.dart';

import 'widgets/top_bar_widget.dart';

const duration = Duration(milliseconds: 600);

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _GuillotineDrawerState createState() => _GuillotineDrawerState();
}

class _GuillotineDrawerState extends State<GuillotineDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  double value = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              color: Colors.purple,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 50,
                    child: Transform(
                      alignment: Alignment.topLeft,
                      transform: Matrix4.identity()..rotateZ(-pi * value),
                      child: Container(
                        width: 150,
                        height: 250,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: TopBarWidget(
                      appBar: PreferredSize(
                        preferredSize: Size.fromHeight(
                          MediaQuery.of(context).padding.top + kToolbarHeight,
                        ),
                        child: Container(
                          width: size.width,
                          color: Colors.green,
                          child: const SafeArea(
                            bottom: false,
                            child: Center(
                              child: Text(
                                'My App Drawer',
                                style: TextStyle(
                                  fontSize: 18,
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
            ),
          ),
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
              });
            },
          ),
          Text('Value $value')
        ],
      ),
    );
  }
}

class NAMEWidget extends StatelessWidget {
  const NAMEWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: Center(
        child: Text('Hello'),
      ),
    );
  }
}
