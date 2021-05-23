import 'package:flutter/material.dart';

class MenuIconWidget extends StatelessWidget {
  const MenuIconWidget({
    Key? key,
    required this.animationIcon,
    this.iconMenu,
    required this.rotateIconMenu,
    required this.delta,
  }) : super(key: key);

  final Animation<double> animationIcon;
  final Widget? iconMenu;
  final bool rotateIconMenu;
  final double delta;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: iconMenu != null,
      child: FittedBox(
        alignment: Alignment.topLeft,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.rotate(
              angle: iconRotateAngle,
              child: iconMenu,
            ),
          ),
        ),
      ),
    );
  }

  double get iconRotateAngle =>
      rotateIconMenu ? -delta * animationIcon.value : 0.0;
}
