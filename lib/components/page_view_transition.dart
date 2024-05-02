import 'dart:math' as math;

import 'package:flutter/material.dart';

class ThreeDPageView extends StatefulWidget {
  @override
  _ThreeDPageViewState createState() => _ThreeDPageViewState();
}

class _ThreeDPageViewState extends State<ThreeDPageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D Page View Transition'),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          // Calculate the scroll percentage
          double scrollPercent = (index - _pageController.page!.toDouble()).abs();

          // Calculate the rotation angle
          double angle = scrollPercent * math.pi / 2;

          // Apply perspective transform to the page
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: _buildPage(_colors[index], 'Page ${index + 1}'),
          );
        },
      ),
    );
  }

  final List<Color> _colors = [Colors.blue, Colors.green, Colors.red];

  Widget _buildPage(Color color, String text) {
    return Center(
      child: Container(
        width: 300.0,
        height: 200.0,
        child: Card(
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}


// class Pseudo3dRouteBuilder extends PageRouteBuilder {
//   final Widget enterPage;
//   final Widget exitPage;
//   Pseudo3dRouteBuilder(this.exitPage, this.enterPage)
//       : super(
//     pageBuilder: (context, animation, secondaryAnimation) => enterPage,
//     transitionsBuilder: _transitionsBuilder(exitPage, enterPage),
//   );
//
//   static _transitionsBuilder(exitPage, enterPage) =>
//           (context, animation, secondaryAnimation, child) {
//         return Stack(
//           children: <Widget>[
//             SlideTransition(
//               position: Tween<Offset>(
//                 begin: Offset.zero,
//                 end: Offset(-1.0, 0.0),
//               ).animate(animation),
//               child: Container(
//                 color: Colors.white,
//                 child: Transform(
//                   transform: Matrix4.identity()
//                     ..setEntry(3, 2, 0.003)
//                     ..rotateY(pi / 2 * animation.value),
//                   alignment: FractionalOffset.centerRight,
//                   child: exitPage,
//                 ),
//               ),
//             ),
//             SlideTransition(
//               position: Tween<Offset>(
//                 begin: Offset(1.0, 0.0),
//                 end: Offset.zero,
//               ).animate(animation),
//               child: Container(
//                 color: Colors.white,
//                 child: Transform(
//                   transform: Matrix4.identity()
//                     ..setEntry(3, 2, 0.003)
//                     ..rotateY(pi / 2 * (animation.value - 1)),
//                   alignment: FractionalOffset.centerLeft,
//                   child: enterPage,
//                 ),
//               ),
//             )
//           ],
//         );
//       };
// }