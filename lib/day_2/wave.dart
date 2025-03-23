import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double waveHeight;
  WavePainter(this.waveHeight);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Path path = Path();
    for (double i = 0; i <= size.width; i++) {
      double y = size.height / 2 + waveHeight * sin(i * 0.02);
      if (i == 0) {
        path.moveTo(i, y);
      } else {
        path.lineTo(i, y);
      }
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
