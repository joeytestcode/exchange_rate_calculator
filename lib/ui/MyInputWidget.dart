import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../data/exchange_rate.dart';

class MyInputWidget extends StatefulWidget {
  const MyInputWidget({
    super.key,
    required this.onChangeCurrency,
    required this.onChangeMoney,
    required this.exchangeRate,
  });
  final Function onChangeCurrency;
  final Function onChangeMoney;
  final ExchangeRate exchangeRate;

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = _getFormattedCurrencyString(
        widget.exchangeRate.money, widget.exchangeRate.selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ExchangeRate exchangeRate = widget.exchangeRate;
    var listOfCurrencies = exchangeRate.currencies.keys
        .where(
          (element) => !exchangeRate.filter.contains(element),
        )
        .toList();
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButton(
                underline: Container(),
                dropdownColor: Theme.of(context).colorScheme.background,
                value: exchangeRate.selectedCurrency,
                items: listOfCurrencies
                    .map((element) => DropdownMenuItem(
                        value: element,
                        child: Text(
                          ' ${widget.exchangeRate.currencies[element]}',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )))
                    .toList(),
                onChanged: (String? selected) {
                  if (selected != null) {
                    exchangeRate.selectedCurrency = selected;
                    widget.onChangeCurrency(selected);
                    _controller.text = _getFormattedCurrencyString(
                        exchangeRate.money, selected);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: ElevatedButton(
                child: Center(child: Text('Updated in\n${exchangeRate.date} ')),
                onPressed: () {
                  exchangeRate.readRate();
                },
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: TextFormField(
            enableInteractiveSelection: true,
            autofocus: true,
            decoration:
                const InputDecoration(contentPadding: EdgeInsets.all(2)),
            controller: _controller,
            cursorColor: Colors.white,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d\.]'))
            ],
            textAlign: TextAlign.right,
            onTap: () {
              _selectAllText(_controller);
            },
            onChanged: (value) {
              widget.onChangeMoney(_parseInputStringToDouble(value));
            },
            onEditingComplete: () {
              _controller.text = _getFormattedCurrencyString(
                  _parseInputStringToDouble(_controller.text),
                  exchangeRate.selectedCurrency);
              _selectAllText(_controller);
            },
          ),
        ),
      ],
    );
  }

  double _parseInputStringToDouble(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      return double.parse(value.replaceAll(RegExp(r'[^\d.]+'), ''));
    }
  }

  void _selectAllText(TextEditingController controller) {
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
  }

  String _getFormattedCurrencyString(double money, String locale) {
    final formatCurrency = NumberFormat.simpleCurrency(
        name: locale.toUpperCase(), decimalDigits: 2);
    return formatCurrency.format(money);
  }
}
