import 'package:flutter/material.dart';

class RhombusContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  RhombusContainer(
      {required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: ParallelogramPainter(color),
    );
  }
}

class RhombusPainter extends CustomPainter {
  final Color color;

  RhombusPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    Path path = Path()
      ..moveTo(size.width / 2, 0) // Top point
      ..lineTo(size.width, size.height / 2) // Right point
      ..lineTo(size.width / 2, size.height) // Bottom point
      ..lineTo(0, size.height / 2) // Left point
      ..close(); // Closing path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ParallelogramPainter extends CustomPainter {
  final Color color;

  ParallelogramPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    Path path = Path()
      ..moveTo(0, 0) // Top-left point
      ..lineTo(size.width * 0.8, 0)
      // ..lineTo(size.width * .5, size.width)
      // ..lineTo(size.width, size.width)

      // Top-right point
      //   ..lineTo(size.width, size.height) // Bottom-right point
      ..lineTo(0, size.height * 0.8) // Bottom-right point

      ..lineTo(0, size.height) // Bottom-left point
      ..close(); // Closing path // Closing path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
