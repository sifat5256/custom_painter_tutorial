import 'dart:math';
import 'package:flutter/material.dart';

class FireworkParticle {
  Offset position;
  Offset velocity;
  Color color;
  double radius;
  double life;

  FireworkParticle(this.position, this.velocity, this.color, this.radius, this.life);
}

class FireworksPainter extends CustomPainter {
  final List<FireworkParticle> particles;

  FireworksPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    for (var particle in particles) {
      paint.color = particle.color.withOpacity(particle.life);
      canvas.drawCircle(particle.position, particle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(FireworksPainter oldDelegate) {
    return true;
  }
}


class FireworksAnimation extends StatefulWidget {
  @override
  _FireworksAnimationState createState() => _FireworksAnimationState();
}

class _FireworksAnimationState extends State<FireworksAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<FireworkParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addListener(() {
      _updateParticles();
    })..repeat();

    _generateParticles();
  }

  void _generateParticles() {
    _particles.clear();
    Random random = Random();

    for (int i = 0; i < 50; i++) {
      _particles.add(FireworkParticle(
        Offset(200, 400), // শুরুর পজিশন (X, Y)
        Offset(random.nextDouble() * 4 - 2, random.nextDouble() * -4), // স্পিড (X, Y)
        Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1), // র‍্যান্ডম কালার
        random.nextDouble() * 5 + 2, // র‍্যান্ডম সাইজ
        1.0, // লাইফটাইম শুরুতে 1.0
      ));
    }
  }

  void _updateParticles() {
    setState(() {
      for (var particle in _particles) {
        particle.position += particle.velocity; // কণাগুলোর মুভমেন্ট
        particle.life -= 0.02; // ধীরে ধীরে ম্লান হওয়া

        if (particle.life <= 0) {
          _generateParticles(); // নতুন আতশবাজি তৈরি করো
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FireworksPainter(_particles),
      size: Size.infinite,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
