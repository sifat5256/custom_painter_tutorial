import 'package:flutter/material.dart';

class ElephantPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // Head (বুক)
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.4), 50, paint);

    // Ears (কান)
    paint.color = Colors.grey.shade700;
    canvas.drawOval(Rect.fromCircle(center: Offset(size.width * 0.3, size.height * 0.35), radius: 40), paint);
    canvas.drawOval(Rect.fromCircle(center: Offset(size.width * 0.7, size.height * 0.35), radius: 40), paint);

    // Trunk (সুঁড়)
    paint.color = Colors.grey;
    Path trunkPath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.4)
      ..cubicTo(size.width * 0.55, size.height * 0.5, size.width * 0.45, size.height * 0.7, size.width * 0.5, size.height * 0.8);
    canvas.drawPath(trunkPath, paint);

    // Body (শরীর)
    paint.color = Colors.grey;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.25, size.height * 0.5, size.width * 0.5, size.height * 0.3), paint);

    // Legs (পা)
    paint.color = Colors.grey.shade700;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.3, size.height * 0.8, 30, 50), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.6, size.height * 0.8, 30, 50), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
