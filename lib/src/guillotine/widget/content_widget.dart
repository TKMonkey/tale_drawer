import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.drawerContent,
    required this.animationGuillotine,
    required this.animationContentOppacity,
    required this.barSize,
    required this.width,
    required this.height,
    required this.hideAppBar,
    required this.leftSide,
    required this.backgroundColor,
  }) : super(key: key);

  final Widget drawerContent;
  final Animation<double> animationGuillotine;
  final Animation<double> animationContentOppacity;
  final double barSize;
  final double width;
  final double height;
  final bool hideAppBar;
  final bool leftSide;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animationGuillotine.value,
      origin: Offset(0, barSize),
      alignment: leftSide ? Alignment.topLeft : Alignment.topRight,
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(
            top: hideAppBar ? 0.0 : barSize,
          ),
          child: ColoredBox(
            color: backgroundColor,
            child: FadeTransition(
              opacity: animationContentOppacity,
              child: drawerContent,
            ),
          ),
        ),
      ),
    );
  }
}
