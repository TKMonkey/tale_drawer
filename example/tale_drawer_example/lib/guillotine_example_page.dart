import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class GuillotineExamplePage extends StatelessWidget {
  GuillotineExamplePage({
    Key? key,
  }) : super(key: key);

  final controller = GuillotineController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GuillotineDrawer(
          controller: controller,
          backgroundColor: const Color(0xff2E2C3C),
          sideState: SideState.LEFT,
          drawerState: DrawerState.OPEN,
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
          body: Container(
            child: const Center(
              child: Text(
                'Body Example',
              ),
            ),
          ),
          drawerContent: const ContentWidget(),
          onOpen: () {
            print('OnOpen');
          },
          onClose: () {
            print('OnClose');
          },
        ),
        // Positioned(
        //   bottom: 0,
        //   child: SlideWidget(controller: controller),
        // )
      ],
    );
  }
}

class SlideWidget extends StatelessWidget {
  const SlideWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final GuillotineController controller;

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

class ContentWidget extends StatelessWidget {
  const ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Center(
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_tree_outlined,
                  color: Colors.white,
                ),
                title: const Text(
                  'Feed',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                title: const Text(
                  'Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
