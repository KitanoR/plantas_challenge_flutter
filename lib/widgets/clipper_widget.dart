import 'package:flutter/material.dart';

class ClipperWidget extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(0, 100);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}