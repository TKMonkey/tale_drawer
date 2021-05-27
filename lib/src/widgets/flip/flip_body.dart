import 'package:flutter/material.dart';

class FlipBody extends StatelessWidget {
  const FlipBody({
    Key? key,
    required this.body,
    required this.animationTranslate,
    required this.animationFlip,
    required this.delta,
    required this.drawerWidth,
    required this.centerAligment,
  }) : super(key: key);

  final Widget body;
  final Animation<double> animationTranslate;
  final Animation<double> animationFlip;
  final double delta;
  final double drawerWidth;
  final Alignment centerAligment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Transform.translate(
      offset: Offset(
        delta * drawerWidth * animationTranslate.value,
        0,
      ),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(-delta * animationFlip.value),
        alignment: centerAligment,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: body,
        ),
      ),
    );
  }
}
