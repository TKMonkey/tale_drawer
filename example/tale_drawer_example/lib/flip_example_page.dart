import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class FlipExamplePage extends StatelessWidget {
  const FlipExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipDrawer(
      body: Container(
        color: Colors.red,
        child: Text('James'),
      ),
      drawer: Container(
        color: Colors.amber,
        child: Text('James'),
      ),
      type: DrawerAnimation.STATIC,
      drawerState: DrawerState.CLOSED,
      sideState: SideState.RIGHT,
    );
  }
}
