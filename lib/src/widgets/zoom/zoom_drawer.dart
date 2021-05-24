import 'package:flutter/material.dart';

class ZoomDrawer extends StatefulWidget {
  const ZoomDrawer({
    Key? key,
    this.duration = const Duration(milliseconds: 700),
  }) : super(key: key);

  final Duration duration;
  @override
  _ZoomDrawerState createState() => _ZoomDrawerState();
}

class _ZoomDrawerState extends State<ZoomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  double value = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(),
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
