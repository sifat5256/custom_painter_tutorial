import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  final List<Offset?> points; // ইউজারের আঁকা পয়েন্ট লিস্ট

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        path.moveTo(points[i]!.dx, points[i]!.dy);
        path.lineTo(points[i + 1]!.dx, points[i + 1]!.dy);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}


class SignaturePad extends StatefulWidget {
  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  List<Offset?> _points = []; // ইউজারের টাচ পয়েন্ট গুলো স্টোর করবে

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _points.add(details.localPosition); // নতুন পয়েন্ট যোগ করা
              });
            },
            onPanEnd: (_) {
              _points.add(null); // নতুন লাইন শুরু করতে null যোগ করা
            },
            child: CustomPaint(
              painter: SignaturePainter(_points),
              size: Size.infinite,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _points.clear(); // ক্লিয়ার বাটন প্রেস করলে সব মুছে যাবে
            });
          },
          child: Text("Clear"),
        ),
      ],
    );
  }
}
