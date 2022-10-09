import 'package:exchange_rate_calculator/data/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(widget: widget),
      body: FutureBuilder(
        future: Provider.of<ExchangeRate>(context, listen: false).isReady,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return Center(
              child: Consumer<ExchangeRate>(
                builder: (context, exchangeRate, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: MyListWidget(
                          exchangeRate: exchangeRate,
                        ),
                      ),
                      MyInputWidget(
                        onChangeCurrency: (String currency) =>
                            exchangeRate.selectedCurrency = currency,
                        onChangeMoney: (double money) =>
                            exchangeRate.money = money,
                        exchangeRate: exchangeRate,
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
