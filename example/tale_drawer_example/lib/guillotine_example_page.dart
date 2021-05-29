import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

import 'misc/content_widget.dart';

class GuillotineExamplePage extends StatelessWidget {
  GuillotineExamplePage({
    Key? key,
  }) : super(key: key);

  final controller = TaleController();

  @override
  Widget build(BuildContext context) {
    return TaleDrawer(
      type: TaleType.Guillotine,
      controller: controller,
      body: Container(
        child: const Center(
          child: Text(
            'Body Example',
          ),
        ),
      ),
      drawer: const ContentWidget(),
      settings: GuillotineSettings(
        appBar: const AppBarWidget(),
        iconMenu: GestureDetector(
          onTap: () {
            controller.start();
          },
          child: const Icon(
            Icons.menu_sharp,
            color: Colors.white,
          ),
        ),
      ),
      listener: TaleListener(
        onOpen: () {
          print('OnOpen');
        },
        onClose: () {
          print('OnClose');
        },
        onAnimated: (v) {
          print('onAnimated $v');
        },
      ),
      sideState: SideState.LEFT,
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'GUILLOTINE',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
