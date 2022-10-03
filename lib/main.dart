import 'package:flutter/material.dart';

import 'ui/MyHomePage.dart';

void main() {
  print('test');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exchange Rate Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Exchange Rate Calculator'),
    );
  }
}
