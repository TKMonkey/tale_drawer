import 'package:flutter/material.dart';

const duration = Duration(milliseconds: 1000);

class GuillotineDrawer extends StatefulWidget {
  const GuillotineDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _GuillotineDrawerState createState() => _GuillotineDrawerState();
}

class _GuillotineDrawerState extends State<GuillotineDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 250,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: Colors.blue,
              ),
              child: const SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.menu,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
