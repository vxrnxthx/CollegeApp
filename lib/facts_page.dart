import 'package:flutter/material.dart';
import 'dart:math';

class FactsPage extends StatelessWidget {
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
            "101 Things About BMSIT",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: FactCard(),
      ),
    );
  }
}

class FactCard extends StatefulWidget {
  @override
  _FactCardState createState() => _FactCardState();
}

class _FactCardState extends State<FactCard> with SingleTickerProviderStateMixin {
  bool isFlipped = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  late String currentFact;
  final Random _random = Random();

  final List<String> facts = [
    "BMSIT&M was established in 2002 by the BMS Educational Trust",
    "The college is located in Avalahalli, Yelahanka, Bangalore",
    "BMSIT&M offers 8 undergraduate engineering programs",
    "The college has a sprawling campus spread across 21 acres",
    "BMSIT&M is affiliated to Visvesvaraya Technological University (VTU)",
    "The college has been accredited by NAAC with 'A' grade",
    "The central library has a collection of over 50,000 books",
    "BMSIT&M has dedicated research centers in various departments",
    "The college has strong industry collaborations including IBM and Bosch",
    "BMSIT&M hosts an annual technical fest called 'Impulse'",
    "The college has a dedicated Training & Placement cell",
    "Over 90% of eligible students get placed every year",
    "The college has modern laboratories with state-of-the-art equipment",
    "BMSIT&M has an active NSS unit",
    "The college promotes entrepreneurship through its E-Cell",
    "Students have access to various sports facilities including indoor games",
    "BMSIT&M has a dedicated hostel facility for boys and girls",
    "The college runs various clubs including coding club and robotics club",
    "BMSIT&M has received grants from AICTE for research projects",
    "The college organizes regular industrial visits for practical exposure"
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
    currentFact = facts[_random.nextInt(facts.length)];
  }

  void toggleCard() {
    if (isFlipped) {
      _controller.reverse();
      // Update fact when card is flipped back
      setState(() {
        currentFact = facts[_random.nextInt(facts.length)];
      });
    } else {
      _controller.forward();
    }
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final isFrontVisible = _animation.value < pi / 2;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_animation.value),
            alignment: Alignment.center,
            child: isFrontVisible
                ? _buildCardFront()
                : Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: _buildCardBack(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardFront() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.purple[300]!,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple[300]!.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.purple[300]!,
              Colors.white,
              Colors.purple[300]!,
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            "Tap to reveal a fact!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.purple[300]!,
                  blurRadius: 12,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.deepPurple[400]!,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple[400]!.withOpacity(0.6),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.deepPurple[400]!,
              Colors.white,
              Colors.deepPurple[400]!,
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            currentFact,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.deepPurple[400]!,
                  blurRadius: 12,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}