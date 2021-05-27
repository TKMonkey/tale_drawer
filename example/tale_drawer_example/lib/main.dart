import 'package:flutter/material.dart';

import 'flip_example_page.dart';
import 'guillotine_example_page.dart';
import 'zoom_example_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: FlipExamplePage(),
    );
  }
}
