import 'package:exchange_rate_calculator/data/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyAppBar.dart';
import 'MyInputWidget.dart';
import 'MyListWidget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(widget: widget),
      body: Center(
        child: Consumer<ExchangeRate>(
          builder: (context, value, child) {
            List<Map<String, double>> filteredRates = _filter(value.rates);
            return Column(
              children: [
                Expanded(
                  child: MyListWidget(
                    selectedCurrency: value.selectedCurrency,
                    money: value.money,
                    rates: filteredRates,
                  ),
                ),
                MyInputWidget(
                  onChangeCurrency: (String currency) =>
                      value.writeSelectedCurrency(currency),
                  onChangeMoney: (double money) => value.writeMoney(money),
                  rates: filteredRates,
                  initialMoney: value.money,
                  initialSelectedCurrency: value.selectedCurrency,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Map<String, double>> _filter(List<Map<String, double>> rates) {
    final List<Map<String, double>> result = List.from(rates);

    // todo

    return result;
  }
}
