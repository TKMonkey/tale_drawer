import 'package:flutter/material.dart';

class DefaultAppBarWidget extends StatelessWidget {
  const DefaultAppBarWidget({Key? key}) : super(key: key);

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
