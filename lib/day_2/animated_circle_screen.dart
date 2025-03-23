import 'package:flutter/material.dart';



class AnimatedCircleScreen extends StatefulWidget {
  @override
  _AnimatedCircleScreenState createState() => _AnimatedCircleScreenState();
}

class _AnimatedCircleScreenState extends State<AnimatedCircleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(200, 200),
              painter: AnimatedCirclePainter(_controller.value),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedCirclePainter extends CustomPainter {
  final double progress;
  AnimatedCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    double radius = (size.width / 2) * progress; // Scale the radius

    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
