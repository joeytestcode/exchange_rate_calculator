import 'package:exchange_rate_calculator/data/data_adapter.dart';
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
    return ChangeNotifierProvider<DataAdapter>(
      create: (context) => DataAdapter(),
      child: MaterialApp(
        title: 'Exchange Rate Calculator',
        theme: ThemeData.dark(),
        home: const MyHomePage(title: 'Exchange Rate Calculator'),
      ),
    );
  }
}
