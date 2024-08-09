import 'package:flutter/material.dart';
import 'greeting_page.dart';
import 'calculator_page.dart';
import 'exchange_list_page.dart';
import 'notes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => GreetingPage(),
        '/calculator': (context) => CalculatorPage(),
        '/exchangeList': (context) => ExchangeListPage(),
        '/notes': (context) => NotesPage(),
      },
    );
  }
}
