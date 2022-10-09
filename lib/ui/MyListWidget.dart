import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/exchange_rate.dart';

class MyListWidget extends StatefulWidget {
  const MyListWidget({super.key, required this.exchangeRate});
  final ExchangeRate exchangeRate;

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> listForListView = widget.exchangeRate.rates.keys
        .where(
          (element) =>
              element != widget.exchangeRate.selectedCurrency &&
              !widget.exchangeRate.filter.contains(element),
        )
        .toList();
    return ReorderableListView.builder(
      itemCount: listForListView.length,
      itemBuilder: (context, index) {
        final String currency = listForListView[index];
        final formatCurrency = NumberFormat.simpleCurrency(
            name: currency.toUpperCase(), decimalDigits: 2);
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
                  child: Text(widget.exchangeRate.currencies[currency] ?? ''),
                ),
                Expanded(
                  flex: 20,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(formatCurrency.format(
                        widget.exchangeRate.money /
                            widget.exchangeRate
                                .rates[widget.exchangeRate.selectedCurrency]! *
                            widget.exchangeRate.rates[currency]!)),
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
          final rate = listForListView.removeAt(oldIndex);
          listForListView.insert(newIndex, rate);
        });
      },
    );
  }
}
