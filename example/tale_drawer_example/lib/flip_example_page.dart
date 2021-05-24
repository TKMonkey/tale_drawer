import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class FlipExamplePage extends StatelessWidget {
  const FlipExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlipDrawer(),
    );
  }
}
