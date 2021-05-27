import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class RunActionsWidget extends StatelessWidget {
  const RunActionsWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TaleController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              controller.open();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Colors.blue,
            ),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Column(
                children: [
                  Icon(Icons.open_in_browser),
                  Text('Open'),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.close();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Colors.blue,
            ),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Column(
                children: [
                  Icon(Icons.close),
                  Text('Close'),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('before start isOpen: ${controller.isDrawerOpen}');
              print('before start isClosed: ${controller.isDrawerClosed}');
              controller.start();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              primary: Colors.blue,
            ),
            child: SizedBox(
              width: 50,
              height: 50,
              child: Column(
                children: [
                  Icon(Icons.play_arrow),
                  Text('Start'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
