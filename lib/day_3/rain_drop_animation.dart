import 'dart:math';
import 'package:flutter/material.dart';

class RainDrop {
  double x, y, speed, length;

  RainDrop(this.x, this.y, this.speed, this.length);
}

class RainPainter extends CustomPainter {
  final List<RainDrop> drops;

  RainPainter(this.drops);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dropPaint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (var drop in drops) {
      canvas.drawLine(Offset(drop.x, drop.y), Offset(drop.x, drop.y + drop.length), dropPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class RainAnimation extends StatefulWidget {
  @override
  _RainAnimationState createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<RainDrop> drops = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 100; i++) {
      drops.add(RainDrop(
        _random.nextDouble() * 400, // x position
        _random.nextDouble() * 600, // y position
        _random.nextDouble() * 4 + 2, // speed
        _random.nextDouble() * 20 + 5, // length
      ));
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 50),
    )..addListener(() {
      setState(() {
        for (var drop in drops) {
          drop.y += drop.speed;
          if (drop.y > 600) {
            drop.y = 0;
            drop.x = _random.nextDouble() * 400;
          }
        }
      });
    })..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RainPainter(drops),
      size: Size(400, 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
