import 'package:flutter/material.dart';


class ClubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Our Club"),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Who are we section
              SectionCard(
                title: "Who are we?",
                content:
                "We are a group of enthusiastic students from various disciplines, united by a shared passion for learning and creativity. Our club fosters an inclusive and supportive environment for all students to grow and express themselves.",
              ),
              SizedBox(height: 20),

              // What we do section
              SectionCard(
                title: "What we do?",
                content:
                "Our club hosts various events, workshops, and seminars to promote creativity, technical skills, and personal development. From tech talks to cultural programs, we provide a platform for students to explore their interests.",
              ),
              SizedBox(height: 20),

              // Join us section
              SectionCard(
                title: "Join us",
                content:
                "Want to be a part of something exciting? Join our club today and engage in a variety of activities that will enhance your skills, broaden your network, and give you an opportunity to make lasting memories with like-minded peers.",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// A reusable card widget for each section
class SectionCard extends StatelessWidget {
  final String title;
  final String content;

  SectionCard({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[900],
              ),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
