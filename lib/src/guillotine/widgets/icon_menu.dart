import 'package:flutter/material.dart';

class IconMenuAppBar extends StatelessWidget {
  const IconMenuAppBar({
    Key? key,
    this.color = Colors.black,
    this.icon = Icons.menu,
  }) : super(key: key);

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
