import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class FlipContent extends StatelessWidget {
  const FlipContent({
    Key? key,
    required this.drawerContent,
    required this.animationTranslate,
    required this.animationFlip,
    required this.type,
    required this.delta,
    required this.rotate,
    required this.centerAligment,
    required this.drawerWidth,
    required this.wSize,
    required this.translate,
  }) : super(key: key);

  final Widget drawerContent;
  final Animation<double> animationTranslate;
  final Animation<double> animationFlip;
  final DrawerAnimation type;
  final double delta;
  final double rotate;
  final Alignment centerAligment;
  final double drawerWidth;
  final double wSize;
  final double translate;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Transform.translate(
      offset: offsetForAnimationType(size),
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(delta *
              animationFlip.value *
              (1 - animationTranslate.value) *
              rotate),
        alignment: centerAligment,
        child: SizedBox(
          width: drawerWidth,
          height: size.height,
          child: drawerContent,
        ),
      ),
    );
  }

  Offset offsetForAnimationType(Size size) {
    switch (type) {
      case DrawerAnimation.STATIC:
        return Offset((size.width - drawerWidth) * wSize, 0);

      default:
        return Offset(
          (wSize * size.width) -
              -delta * drawerWidth * (animationTranslate.value - 1 * translate),
          0,
        );
    }
  }
}
