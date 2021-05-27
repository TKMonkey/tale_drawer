import 'package:flutter/material.dart';

class ZoomDrawerContent extends StatelessWidget {
  const ZoomDrawerContent({
    Key? key,
    required this.drawer,
    required this.drawerBackground,
  }) : super(key: key);

  final Widget drawer;
  final Color drawerBackground;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: drawerBackground,
      child: drawer,
    );
  }
}
