import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("College Club App"),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionCard(
              title: "Fortune 500 Companies",
              onTap: () => Navigator.pushNamed(context, '/companies'),
            ),
            OptionCard(
              title: "About Our College",
              onTap: () => Navigator.pushNamed(context, '/college'),
            ),
            OptionCard(
              title: "About Our Club",
              onTap: () => Navigator.pushNamed(context, '/club'),
            ),
            OptionCard(
              title: "101 Things About Our College",
              onTap: () => Navigator.pushNamed(context, '/facts'),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  OptionCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurple[700],
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent,
              blurRadius: 8,
              spreadRadius: 2,
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
