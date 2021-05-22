import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

class GuillotineExamplePage extends StatelessWidget {
  const GuillotineExamplePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GuillotineDrawer(
      backgroundColor: const Color(0xff2E2C3C).withOpacity(0.9),
      hideAppBar: false,
      body: Container(
        child: const Center(
          child: Text(
            'Body Example',
          ),
        ),
      ),
      iconMenu: const Icon(
        Icons.menu_sharp,
        color: Colors.white,
      ),
    );
  }
}
