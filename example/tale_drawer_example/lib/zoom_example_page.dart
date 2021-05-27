// import 'package:flutter/material.dart';
// import 'package:tale_drawer/tale_drawer.dart';

// import 'misc/content_widget.dart';
// import 'misc/run_actions_widget.dart';

// class ZoomExamplePage extends StatelessWidget {
//   const ZoomExamplePage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ZoomDrawer(
//         drawer: const ContentWidget(),
//         body: Scaffold(
//           appBar: AppBar(
//             backgroundColor: const Color(0xff2E2C3C),
//             leading: IconButton(
//               icon: Icon(Icons.menu),
//               onPressed: () {
//                 // controller.start();
//               },
//             ),
//             title: Text('Flip Example'),
//           ),
//           body: Stack(
//             children: [
//               Container(
//                 color: Colors.white,
//                 child: Center(child: Text('Hello')),
//               ),
//               // Positioned(
//               //   bottom: 0,
//               //   child: RunActionsWidget(controller: controller),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
