import 'package:flutter/material.dart';
import 'starry_background.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.purple[300]!, Colors.deepPurple[400]!],
          ).createShader(bounds),
          child: Text(
            "P R i M E",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: StarryBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeonOptionCard(
                title: "Fortune 500 Companies",
                onTap: () => Navigator.pushNamed(context, '/companies'),
                glowColor: Colors.purple[300]!,
              ),
              NeonOptionCard(
                title: "About Our College",
                onTap: () => Navigator.pushNamed(context, '/college'),
                glowColor: Colors.deepPurple[300]!,
              ),
              NeonOptionCard(
                title: "About Our Club",
                onTap: () => Navigator.pushNamed(context, '/club'),
                glowColor: Colors.purple[400]!,
              ),
              NeonOptionCard(
                title: "101 Things About Our College",
                onTap: () => Navigator.pushNamed(context, '/facts'),
                glowColor: Colors.deepPurple[400]!,
              ),
              NeonOptionCard(
                title: "Game Time with Prime",
                onTap: () => Navigator.pushNamed(context, '/hangman'),
                glowColor: Colors.purple[500]!,
              ),
              NeonOptionCard(
                title: "Chat with Dexter",
                onTap: () => Navigator.pushNamed(context, '/chatbot'),
                glowColor: Colors.deepPurple[500]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NeonOptionCard extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final Color glowColor;

  NeonOptionCard({
    required this.title,
    required this.onTap,
    required this.glowColor,
  });

  @override
  _NeonOptionCardState createState() => _NeonOptionCardState();
}

class _NeonOptionCardState extends State<NeonOptionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 2.0, end: 4.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.6),
                    blurRadius: _glowAnimation.value * 5,
                    spreadRadius: _glowAnimation.value,
                  ),
                ],
                border: Border.all(
                  color: widget.glowColor,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      widget.glowColor,
                      Colors.white,
                      widget.glowColor,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ).createShader(bounds),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: widget.glowColor,
                          blurRadius: _glowAnimation.value * 3,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}