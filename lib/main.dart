import 'package:exchange_rate_calculator/data/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ExchangeRate>(
      create: (context) => ExchangeRate(),
      child: MaterialApp(
        title: 'Exchange Rate Calculator',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: MyHomePage(title: 'Exchange Rate Calculator'),
      ),
    );
  }
}
