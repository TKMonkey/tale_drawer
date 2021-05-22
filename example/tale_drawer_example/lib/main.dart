import 'package:flutter/material.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   leading: Icon(Icons.menu),
        //   title: Text('James'),
        // ),
        body: HomePage(),
      ),
    );
  }
}
