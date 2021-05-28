import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

import 'misc/content_widget.dart';
import 'misc/run_actions_widget.dart';

const side = SideState.RIGHT;

class ZoomExamplePage extends StatelessWidget {
  ZoomExamplePage({
    Key? key,
  }) : super(key: key);

  final controller = TaleController();

  @override
  Widget build(BuildContext context) {
    return TaleDrawer(
      type: TaleType.Zoom,
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff2E2C3C),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              controller.start();
            },
          ),
          title: Text('Zoom Example'),
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
      drawer: ContentWidget(
        alignment: side == SideState.RIGHT
            ? Alignment.centerRight
            : Alignment.centerLeft,
      ),
      sideState: side,
      settings: ZoomSettings(),
      controller: controller,
    );
  }
}
