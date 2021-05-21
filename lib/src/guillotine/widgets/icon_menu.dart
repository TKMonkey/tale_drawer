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
    return const Icon(Icons.menu, color: Colors.white);
  }
}
