import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data_adapter.dart';
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
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: const ColorScheme.dark(
                brightness: Brightness.dark, primary: Colors.blue)),
        home: const MyHomePage(title: 'Exchange Rate Calculator'),
      ),
    );
  }
}
