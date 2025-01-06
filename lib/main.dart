import 'package:flutter/material.dart';
import 'club_page.dart';
import 'college_page.dart';
import 'home_page.dart';
import 'companies_page.dart';
import 'facts_page.dart';

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
        '/': (context) => HomePage(),
        '/college': (context) => CollegePage(),
        '/companies': (context) => CompaniesPage(),
        '/club': (context) => ClubPage(),
        '/facts': (context) => FactsPage(),
      },
      theme: ThemeData.dark(),
    );
  }
}
