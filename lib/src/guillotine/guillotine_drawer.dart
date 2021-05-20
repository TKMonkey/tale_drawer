import 'dart:math';

import 'package:flutter/material.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                      child: Container(
                        width: 150,
                        height: 50,
                        color: Colors.green,
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
      ),
    );
  }
}
