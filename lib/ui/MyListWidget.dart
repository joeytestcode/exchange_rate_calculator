import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/exchange_rate.dart';

class MyListWidget extends StatefulWidget {
  MyListWidget(
      {super.key,
      required this.rates,
      required this.money,
      required this.selectedCurrency});
  final List<Map<String, double>> rates;
  double money;
  String selectedCurrency;

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, double>> filteredRates =
        _filterSelected(widget.rates);
    return ReorderableListView.builder(
      itemCount: filteredRates.length,
      itemBuilder: (context, index) {
        final formatCurrency = NumberFormat.simpleCurrency(
            decimalDigits: 2,
            locale: currencyLocale[filteredRates[index].keys.first]);
        return Card(
          key: Key('$index'),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
          elevation: 2,
          child: ListTile(
            tileColor: Theme.of(context).colorScheme.onBackground,
            style: ListTileStyle.drawer,
            title: Row(
              children: [
                Text(filteredRates[index].keys.first),
                Expanded(
                  flex: 10,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(formatCurrency.format(widget.money /
                        _getSelectedCurrencyValue(
                            widget.rates, widget.selectedCurrency) *
                        filteredRates[index].values.first)),
                  ),
                ),
                const Spacer(flex: 1),
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
          final rate = filteredRates.removeAt(oldIndex);
          filteredRates.insert(newIndex, rate);
        });
      },
    );
  }

  double _getSelectedCurrencyValue(List<Map> rates, currencyLocale) {
    for (var e in rates) {
      if (e.containsKey(currencyLocale)) {
        return e.values.first;
      }
    }
    return -1.0;
  }

  int _getSelectedIndex(List<Map> rates, String selectedCurrency) {
    int selectedIndex = -1;
    rates.asMap().forEach((key, value) {
      if (value.containsKey(selectedCurrency)) {
        selectedIndex = key;
      }
    });
    return selectedIndex;
  }

  List<Map<String, double>> _filterSelected(List<Map<String, double>> rates) {
    final List<Map<String, double>> result = List.from(rates);

    for (var e in rates) {
      if (e.containsKey(widget.selectedCurrency)) {
        result.remove(e);
      }
    }
    return result;
  }
}
