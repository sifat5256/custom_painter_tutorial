import 'package:flutter/material.dart';

class ChickenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    double bodyWidth = size.width * 0.6;
    double bodyHeight = size.height * 0.4;
    double headRadius = size.width * 0.1;
    double eyeRadius = size.width * 0.015;
    double beakWidth = size.width * 0.1;
    double beakHeight = size.height * 0.05;
    double legWidth = size.width * 0.03;
    double legHeight = size.height * 0.15;
    double footWidth = size.width * 0.05;
    double footHeight = size.height * 0.03;

    // Body
    canvas.drawOval(Rect.fromLTWH(size.width * 0.2, size.height * 0.4, bodyWidth, bodyHeight), paint);

    // Head
    paint.color = Colors.yellow;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.25), headRadius, paint);

    // Beak
    paint.color = Colors.orange.shade600;
    Path beakPath = Path()
      ..moveTo(size.width * 0.5, size.height * 0.22)
      ..lineTo(size.width * 0.5 + beakWidth / 2, size.height * 0.2)
      ..lineTo(size.width * 0.5 - beakWidth / 2, size.height * 0.2)
      ..close();
    canvas.drawPath(beakPath, paint);

    // Comb
    paint.color = Colors.red;
    canvas.drawArc(Rect.fromCircle(center: Offset(size.width * 0.5, size.height * 0.15), radius: headRadius / 2), -0.5, 3.14, false, paint);

    // Wattle
    paint.color = Colors.red.shade700;
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.32), headRadius / 4, paint);

    // Eyes
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width * 0.47, size.height * 0.23), eyeRadius, paint);
    canvas.drawCircle(Offset(size.width * 0.53, size.height * 0.23), eyeRadius, paint);

    // Wings
    paint.color = Colors.orange.shade700;
    canvas.drawOval(Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.5), radius: bodyWidth * 0.15), paint);
    canvas.drawOval(Rect.fromCircle(center: Offset(size.width * 0.8, size.height * 0.5), radius: bodyWidth * 0.15), paint);

    // Legs
    paint.color = Colors.orange;
    canvas.drawRect(Rect.fromLTWH(size.width * 0.35, size.height * 0.75, legWidth, legHeight), paint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.6, size.height * 0.75, legWidth, legHeight), paint);

    // Feet with toes
    paint.color = Colors.orange.shade600;
    double leftFootX = size.width * 0.35;
    double rightFootX = size.width * 0.6;
    double footY = size.height * 0.9;

    canvas.drawLine(Offset(leftFootX, footY), Offset(leftFootX - footWidth, footY + footHeight), paint);
    canvas.drawLine(Offset(leftFootX, footY), Offset(leftFootX + footWidth, footY + footHeight), paint);
    canvas.drawLine(Offset(leftFootX, footY), Offset(leftFootX, footY + footHeight * 1.2), paint);

    canvas.drawLine(Offset(rightFootX, footY), Offset(rightFootX - footWidth, footY + footHeight), paint);
    canvas.drawLine(Offset(rightFootX, footY), Offset(rightFootX + footWidth, footY + footHeight), paint);
    canvas.drawLine(Offset(rightFootX, footY), Offset(rightFootX, footY + footHeight * 1.2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
