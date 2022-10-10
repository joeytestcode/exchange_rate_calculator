import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/exchange_rate.dart';

class MyListWidget extends StatefulWidget {
  const MyListWidget({super.key});

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ExchangeRate>(builder: (context, exchangeRate, child) {
        return ReorderableListView.builder(
          itemCount: exchangeRate.orderedList.length,
          itemBuilder: (context, index) {
            final String currentCurrency = exchangeRate.orderedList[index];
            final formatCurrency = NumberFormat.simpleCurrency(
                name: currentCurrency.toUpperCase(), decimalDigits: 2);
            return Card(
              key: Key('$index'),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              elevation: 2,
              child: ListTile(
                tileColor: Theme.of(context).colorScheme.onBackground,
                style: ListTileStyle.drawer,
                title: Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child:
                          Text(exchangeRate.currencies[currentCurrency] ?? ''),
                    ),
                    Expanded(
                      flex: 20,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(formatCurrency.format(exchangeRate.money /
                            exchangeRate.rates[exchangeRate.selectedCurrency]! *
                            exchangeRate.rates[currentCurrency]!)),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex = newIndex - 1;
              }
              final rate = exchangeRate.removeAtFromOrderedList(oldIndex);
              exchangeRate.insertToOrderedList(newIndex, rate);
            });
          },
        );
      }),
    );
  }
}
