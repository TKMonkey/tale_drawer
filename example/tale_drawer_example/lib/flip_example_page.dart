import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';
import 'package:tale_drawer_example/misc/content_widget.dart';

import 'misc/run_actions_widget.dart';

class FlipExamplePage extends StatelessWidget {
  FlipExamplePage({
    Key? key,
  }) : super(key: key);

  final controller = TaleController();

  @override
  Widget build(BuildContext context) {
    return TaleDrawer(
      type: TaleType.Flip,
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2E2C3C),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              controller.start();
            },
          ),
          title: Text('Flip Example'),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.white,
              child: Center(child: Text('Hello')),
            ),
            Positioned(
              bottom: 0,
              child: RunActionsWidget(controller: controller),
            )
          ],
        ),
      ),
      drawer: Container(
        color: const Color(0xff2E2C3C),
        child: const ContentWidget(),
      ),
      controller: controller,
      drawerState: DrawerState.OPEN,
      sideState: SideState.RIGHT,
      listener: DrawerListener(
        onOpen: () {
          print('OnOpen');
        },
        onClose: () {
          print('OnClose');
        },
      ),
      settings: FlipSettings(
        type: DrawerAnimation.TRANSLATE,
      ),
    );
  }
}
