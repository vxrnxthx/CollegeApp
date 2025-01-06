import 'package:flutter/material.dart';
import 'dart:math';

class FactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("101 Things About BMSIT"),
        backgroundColor: Colors.deepPurple[900],
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
  final String fact = "First student of BMSIT was Dexter";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  void toggleCard() {
    if (isFlipped) {
      _controller.reverse();
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
        color: Colors.deepPurple[700],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          "Tap to reveal a fact!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildCardBack() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple[900],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          fact,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

