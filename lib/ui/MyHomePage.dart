import 'package:exchange_rate_calculator/data/exchange_rate.dart';
import 'package:flutter/material.dart';

import 'MyAppBar.dart';
import 'MyInputWidget.dart';
import 'MyListWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List> _rates;
  String _selectedCurrency = ExchangeRate.currencyKorea;
  double _money = 1000.0;

  @override
  void initState() {
    super.initState();
    _rates = ExchangeRate.readRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(widget: widget),
      body: Center(
        child: FutureBuilder(
          future: _rates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              final rates = snapshot.data as List<Map<String, double>>;
              final filteredRates = _filter(rates);
              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: MyListWidget(
                        selectedCurrency: _selectedCurrency,
                        money: _money,
                        rates: filteredRates,
                      ),
                    ),
                    MyInputWidget(
                      onChangeCurrency: _onChangeCurrency,
                      onChangeMoney: _onChangeMoney,
                      rates: filteredRates,
                      initialMoney: 1000.0,
                      initialSelectedCurrency: _selectedCurrency,
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  void _onChangeCurrency(String selectedCurrency) {
    setState(() {
      _selectedCurrency = selectedCurrency;
    });
  }

  void _onChangeMoney(double money) {
    setState(() {
      _money = money;
    });
  }

  List<Map<String, double>> _filter(List<Map<String, double>> rates) {
    final List<Map<String, double>> result = List.from(rates);

    // todo

    return result;
  }
}
