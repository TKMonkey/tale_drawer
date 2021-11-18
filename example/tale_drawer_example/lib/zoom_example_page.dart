import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

import 'misc/content_widget.dart';

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
            Center(child: Text('Hello TKMonkey')),
          ],
        ),
      ),
      drawer: ContentWidget(
        alignment: side == SideState.LEFT
            ? Alignment.centerRight
            : Alignment.centerLeft,
      ),
      sideState: side,
      settings: ZoomSettings(
        closeOnTapBody: true,
      ),
      controller: controller,
    );
  }
}
