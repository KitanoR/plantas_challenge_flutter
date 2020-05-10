import 'package:flutter/material.dart';

class PainterWidget extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    double radius = 10.0;
    Paint paint = new Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.width - radius);
    path.quadraticBezierTo(0, size.width, radius, size.width);
    path.lineTo(size.width, size.width);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PainterWidget oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PainterWidget oldDelegate) => false;
}