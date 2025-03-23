import 'package:flutter/material.dart';


class TouchDrawingScreen extends StatefulWidget {
  @override
  _TouchDrawingScreenState createState() => _TouchDrawingScreenState();
}

class _TouchDrawingScreenState extends State<TouchDrawingScreen> {
  List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          setState(() {
            points.add(details.localPosition);
          });
        },
        child: CustomPaint(
          painter: DotsPainter(points),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class DotsPainter extends CustomPainter {
  final List<Offset> points;
  DotsPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    for (var point in points) {
      canvas.drawCircle(point, 5, paint);
    }
  }

  @override
  bool shouldRepaint(DotsPainter oldDelegate) => true;
}
