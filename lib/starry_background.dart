import 'package:flutter/material.dart';
import 'package:flutter_background/flutter_background.dart';
import 'dart:math' as math;

class StarryBackground extends StatefulWidget {
  final Widget child;

  StarryBackground({required this.child});

  @override
  _StarryBackgroundState createState() => _StarryBackgroundState();
}

class _StarryBackgroundState extends State<StarryBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<Star> stars = [];
  final int starCount = 150;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Initialize stars with random properties
    final random = math.Random();
    for (int i = 0; i < starCount; i++) {
      stars.add(Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 2 + 0.5, // Stars between 0.5 and 2.5 in size
        twinkleOffset: random.nextDouble() * math.pi * 2, // Random phase offset
        twinkleSpeed: random.nextDouble() * 2 + 1, // Random twinkling speed
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black, // Night sky background
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: StarryPainter(
                    _animation.value,
                    stars,
                  ),
                );
              },
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double twinkleOffset;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.twinkleOffset,
    required this.twinkleSpeed,
  });
}

class StarryPainter extends CustomPainter {
  final double animationValue;
  final List<Star> stars;

  StarryPainter(this.animationValue, this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      // Calculate star opacity based on time and its unique properties
      final twinkle = math.sin(
          (animationValue * math.pi * 2 * star.twinkleSpeed) + star.twinkleOffset
      );

      // Create a radial gradient for each star
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.8 + (twinkle * 0.2)),
            Colors.white.withOpacity(0),
          ],
          stops: [0.1, 1.0],
        ).createShader(
          Rect.fromCircle(
            center: Offset(
              star.x * size.width,
              star.y * size.height,
            ),
            radius: star.size * 2,
          ),
        );

      // Draw the star
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size * (0.8 + (twinkle * 0.2)), // Size varies slightly with twinkle
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant StarryPainter oldDelegate) {
    return true;
  }
}