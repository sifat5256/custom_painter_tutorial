

import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint =Paint()
        ..color = Colors.amber
        ..style = PaintingStyle.fill;
    Path path = Path()
    ..moveTo(size.width/2, 0)
    ..lineTo(size.width, size.height)
    ..lineTo(0, size.height)
    ..close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }


}