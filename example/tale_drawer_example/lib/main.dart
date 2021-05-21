import 'package:flutter/material.dart';
import 'package:tale_drawer/tale_drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        // appBar: AppBar(
        //   leading: Icon(Icons.menu),
        //   title: Text('James'),
        // ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 200,
    //   height: 200,
    //   color: Colors.red,
    //   child: UnconstrainedBox(
    //     // padding: EdgeInsets.all(8),
    //     child: Container(
    //       constraints: BoxConstraints.tightFor(width: 80, height: 50),
    //       color: Colors.green,
    //     ),
    //   ),
    // );

    return const GuillotineDrawer(
        // startOpen: true,
        // rotateIconMenu: false,
        // iconMenu: Icon(Icons.star),
        );
  }
}
