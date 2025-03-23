import 'dart:math';
import 'package:flutter/material.dart';

class FireflyPainter extends CustomPainter {
  final List<Offset> fireflyPositions;
  final List<Color> fireflyColors;
  final List<double> fireflyOpacities;

  FireflyPainter(this.fireflyPositions, this.fireflyColors, this.fireflyOpacities);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fireflyPaint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < fireflyPositions.length; i++) {
      fireflyPaint.color = fireflyColors[i].withOpacity(fireflyOpacities[i]);
      canvas.drawCircle(fireflyPositions[i], 4.0, fireflyPaint); // Firefly size
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint for animations
  }
}

class FireflyAnimation extends StatefulWidget {
  @override
  _FireflyAnimationState createState() => _FireflyAnimationState();
}

class _FireflyAnimationState extends State<FireflyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _fireflyOffsets;
  late List<Animation<Color>> _fireflyColors;
  late List<Animation<double>> _fireflyOpacities;
  final Random _random = Random();
  final int _fireflyCount = 20; // Number of fireflies

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Animation duration
    )..repeat(reverse: true);

    // Initialize firefly animations
    _fireflyOffsets = List.generate(_fireflyCount, (index) {
      return Tween<Offset>(
        begin: Offset(_random.nextDouble() * 300, _random.nextDouble() * 600),
        end: Offset(_random.nextDouble() * 300, _random.nextDouble() * 600),
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    });

    _fireflyColors = List.generate(_fireflyCount, (index) {
      return ColorTween(
        begin: Colors.white,
        end: Colors.yellow,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      )) as Animation<Color>; // Explicitly cast to Animation<Color>
    });

    _fireflyOpacities = List.generate(_fireflyCount, (index) {
      return Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for fireflies
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          List<Offset> fireflyPositions =
          _fireflyOffsets.map((e) => e.value).toList();
          List<Color> fireflyColors = _fireflyColors.map((e) => e.value).toList();
          List<double> fireflyOpacities =
          _fireflyOpacities.map((e) => e.value).toList();

          return CustomPaint(
            painter: FireflyPainter(fireflyPositions, fireflyColors, fireflyOpacities),
            size: Size.infinite,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

