import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedCircularProgress extends StatefulWidget {
  @override
  _AnimatedCircularProgressState createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // 3 সেকেন্ডের এনিমেশন
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {}); // Rebuild UI to show animation progress
      });

    _controller.repeat(reverse: false); // এনিমেশন চালু হবে এবং লুপ করবে
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircularProgressPainter(_animation.value),
      size: Size(150, 150), // Size of the circular progress
    );
  }
}


// Custom Painter ক্লাস তৈরি করা
class CircularProgressPainter extends CustomPainter {
  final double progress; // Progress value (0.0 থেকে 1.0)

  CircularProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for background circle
    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    // Paint for progress circle
    Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    // Center of the canvas
    Offset center = size.center(Offset.zero);
    double radius = size.width / 2;

    // Background circle draw
    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc draw
    double startAngle = -pi / 2; // Start from top
    double sweepAngle = 2 * pi * progress; // Convert progress to angle

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
