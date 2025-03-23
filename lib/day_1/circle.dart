
import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint()
       ..color = Colors.blue
       ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width/2,size.height/2), 50, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
   return false;
  }


}