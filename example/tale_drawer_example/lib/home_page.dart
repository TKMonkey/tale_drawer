import 'package:flutter/material.dart';
import 'package:tale_drawer_example/zoom_example_page.dart';

import 'flip_example_page.dart';
import 'guillotine_example_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    FlipExamplePage(),
    GuillotineExamplePage(),
    ZoomExamplePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.flip),
            label: 'Flip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games_rounded),
            label: 'Guillotine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Zoom',
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
