import 'package:flutter/material.dart';

/// {@template guillotine_content}
///
/// This widget is to create content drawer of [TaleDrawer] when is [GuillotineDrawerWidget]
/// This widget isn't public for final users
///
///
/// The purpose of this widget is to create the guillotine animation
/// Guillotine animation is composed by: `Rotate` and `Fade`
///
/// This widget can use the `fixedAppBar` param from [GuillotineSettings]
/// With this, the widget hide the AppBar or not
///
/// {@endtemplate}
class GuillotineContent extends StatelessWidget {
  const GuillotineContent({
    Key? key,
    required this.drawerContent,
    required this.animationGuillotine,
    required this.animationContentOppacity,
    required this.delta,
    required this.barSize,
    required this.fixedAppBar,
    required this.topAligment,
    required this.backgroundColor,
  }) : super(key: key);

  final Widget drawerContent;
  final Animation<double> animationGuillotine;
  final Animation<double> animationContentOppacity;
  final double delta;
  final double barSize;
  final bool fixedAppBar;
  final Color backgroundColor;
  final Alignment topAligment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: delta * animationGuillotine.value,
      origin: Offset(0, barSize),
      alignment: topAligment,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: EdgeInsets.only(
            top: fixedAppBar ? 0.0 : barSize,
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
