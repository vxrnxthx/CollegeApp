import 'package:flutter/material.dart';

class CollegePage extends StatelessWidget {
  final List<Map<String, String>> flashCards = [
    {
      'image': 'assets/images/college.jpg',  // Replace with your image path
      'caption': 'Our college building - where all the learning happens.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],  // Light purple background
      appBar: AppBar(
        title: Text('About Our College'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,  // Number of cards per row
          crossAxisSpacing: 10,  // Horizontal spacing between cards
          mainAxisSpacing: 10,   // Vertical spacing between cards
        ),
        padding: const EdgeInsets.all(10.0),
        itemCount: flashCards.length,
        itemBuilder: (context, index) {
          return FlashCard(
            imagePath: flashCards[index]['image']!,
            caption: flashCards[index]['caption']!,
          );
        },
      ),
    );
  }
}

class FlashCard extends StatelessWidget {
  final String imagePath;
  final String caption;

  FlashCard({
    required this.imagePath,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.deepPurple[700],
              title: Text(
                'College Info',
                style: TextStyle(color: Colors.white),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    caption,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple[700],  // Dark box for flash card
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    caption,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
