import 'package:flutter/material.dart';
import 'club_page.dart';
import 'college_page.dart';
import 'home_page.dart';
import 'companies_page.dart';
import 'facts_page.dart';
import 'starry_background.dart';
import 'hangman.dart';
import 'chatbot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Club App',
      initialRoute: '/',
      routes: {
        '/': (context) => StarryBackground(child: HomePage()),
        '/college': (context) => StarryBackground(child: CollegePage()),
        '/companies': (context) => StarryBackground(child: CompaniesPage()),
        '/club': (context) => StarryBackground(child: ClubPage()),
        '/facts': (context) => StarryBackground(child: FactsPage()),
        '/hangman': (context) => StarryBackground(child: HangmanGame()),
        '/chatbot': (context) => StarryBackground(child: ChatbotScreen()),
      },
      theme: ThemeData.dark(),
    );
  }
}