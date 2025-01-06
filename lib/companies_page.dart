import 'package:flutter/material.dart';

class CompaniesPage extends StatelessWidget {
  final List<String> companies = ["Apple", "Google", "Amazon", "Microsoft"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Default background
      appBar: AppBar(
        title: Text("Fortune 500 Companies"),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                companies[index],
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CompaniesPageDetail(company: companies[index]),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.easeInOut;

                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(position: offsetAnimation, child: child);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CompaniesPageDetail extends StatelessWidget {
  final String company;

  CompaniesPageDetail({required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Center(
        child: Text(
          "$company is a leading Fortune 500 company.",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
