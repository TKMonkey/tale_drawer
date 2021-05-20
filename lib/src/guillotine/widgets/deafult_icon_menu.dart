import 'package:flutter/material.dart';

class DefaultIconMenuAppBar extends StatelessWidget {
  const DefaultIconMenuAppBar({
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
          padding: EdgeInsets.only(left: 8.0),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }
}
