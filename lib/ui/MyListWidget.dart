import 'package:exchange_rate_calculator/data/data_adapter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyListWidget extends StatefulWidget {
  const MyListWidget({super.key});

  @override
  State<MyListWidget> createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<DataAdapter>(builder: (context, dataAdapter, child) {
        return ReorderableListView.builder(
          itemCount: dataAdapter.orderedList.length - 1,
          itemBuilder: (context, index) {
            final String currentCurrency = dataAdapter.orderedList[index + 1];
            final formatCurrency = NumberFormat.simpleCurrency(
                name: currentCurrency.toUpperCase(), decimalDigits: 2);
            return Card(
              key: Key('$index'),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              elevation: 2,
              child: ListTile(
                style: ListTileStyle.drawer,
                title: Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child:
                          Text(dataAdapter.currencies[currentCurrency] ?? ''),
                    ),
                    Expanded(
                      flex: 20,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(formatCurrency.format(dataAdapter.money /
                            dataAdapter.rates[dataAdapter.selectedCurrency]! *
                            dataAdapter.rates[currentCurrency]!)),
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
              if (newIndex <= oldIndex) {
                newIndex = newIndex + 1;
              }
              final rate = dataAdapter.removeAtFromOrderedList(oldIndex + 1);
              dataAdapter.insertToOrderedList(newIndex, rate);
            });
          },
        );
      }),
    );
  }
}
