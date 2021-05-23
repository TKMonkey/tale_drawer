import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class GuillotineExamplePage extends StatelessWidget {
  const GuillotineExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GuillotineDrawer(
        backgroundColor: const Color(0xff2E2C3C),
        appBar: const AppBarWidget(),
        iconMenu: const Icon(
          Icons.menu_sharp,
          color: Colors.white,
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
        });
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
