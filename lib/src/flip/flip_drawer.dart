import 'dart:math';

import 'package:flutter/material.dart';

class FlipDrawer extends StatefulWidget {
  const FlipDrawer({
    Key? key,
    this.duration = const Duration(milliseconds: 700),
  }) : super(key: key);

  final Duration duration;
  @override
  _FlipDrawerState createState() => _FlipDrawerState();
}

class _FlipDrawerState extends State<FlipDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animationFlip;

  double value = 0.0;
  int maxSlide = 250;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    animationFlip = Tween(begin: 0.0, end: 0.75).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Transform.translate(
        offset: Offset(maxSlide * animationController.value, 0),
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(-animationFlip.value * pi / 2),
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
      )
    ]);
  }
}
