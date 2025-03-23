import 'package:flutter/material.dart';



class PulsatingCircle extends StatefulWidget {
  @override
  _PulsatingCircleState createState() => _PulsatingCircleState();
}

class _PulsatingCircleState extends State<PulsatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    // Define the animation
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(200, 200), // Set the size of the canvas
          painter: PulsatingCirclePainter(_animation.value),
        );
      },
    );
  }
}

class PulsatingCirclePainter extends CustomPainter {
  final double progress;
  PulsatingCirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue.withOpacity(1 - progress);
    double radius = (size.width / 2) * progress;

    canvas.drawCircle(size.center(Offset.zero), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}