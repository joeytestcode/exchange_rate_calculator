import 'package:exchange_rate_calculator/data/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySettings extends StatelessWidget {
  const MySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: const [
          MyFilterListWidget(),
        ],
      ),
    );
  }
}

class MyFilterListWidget extends StatelessWidget {
  const MyFilterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExchangeRate>(
      builder: (context, exchangeRate, child) {
        List<String> currencyKeys = exchangeRate.currencies.keys.toList();

        return Expanded(
          child: ListView.builder(
            itemCount: currencyKeys.length,
            itemBuilder: (context, index) {
              bool isChecked =
                  !exchangeRate.filter.contains(currencyKeys[index]);
              return ListTile(
                title: Text(
                    exchangeRate.currencies[currencyKeys[index]].toString()),
                trailing: Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    if (value != null) {
                      isChecked = value;
                      if (value) {
                        if (exchangeRate.filter.contains(currencyKeys[index])) {
                          exchangeRate.removeFilter(currencyKeys[index]);
                        }
                      } else {
                        if (!exchangeRate.filter
                            .contains(currencyKeys[index])) {
                          exchangeRate.addFilter(currencyKeys[index]);
                        }
                      }
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
