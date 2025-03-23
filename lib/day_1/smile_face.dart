import 'package:flutter/material.dart';

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // মুখ আঁকা (বড় বৃত্ত)
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 100, paint);

    // চোখ আঁকার জন্য কালো পেইন্ট তৈরি করা
    Paint eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // দুইটা চোখ আঁকা
    canvas.drawCircle(Offset(size.width / 2 - 40, size.height / 2 - 30), 10, eyePaint);
    canvas.drawCircle(Offset(size.width / 2 + 40, size.height / 2 - 30), 10, eyePaint);

    // মুখের জন্য পেইন্ট সেটআপ করা
    Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // মুখের অংশে একটি আরক (arc) আঁকা
    Rect mouthRect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2 + 20), radius: 40);
    canvas.drawArc(mouthRect, 0, 3.14, false, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
