import 'dart:math';
import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final double waveHeight;
  final double waveOffset;

  WavePainter(this.waveHeight, this.waveOffset);

  @override
  void paint(Canvas canvas, Size size) {
    Paint wavePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    Path wavePath = Path();

    for (double i = 0; i <= size.width; i++) {
      double y = size.height / 2 + waveHeight * sin((i + waveOffset) * 0.02);
      if (i == 0) {
        wavePath.moveTo(i, y);
      } else {
        wavePath.lineTo(i, y);
      }
    }

    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.drawPath(wavePath, wavePaint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.waveHeight != waveHeight ||
        oldDelegate.waveOffset != waveOffset;
  }
}


class AnimatedWave extends StatefulWidget {
  @override
  _AnimatedWaveState createState() => _AnimatedWaveState();
}

class _AnimatedWaveState extends State<AnimatedWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WavePainter(20, _animation.value),
      size: Size(double.infinity, 200),
    );
  }
}
