import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../data/exchange_rate.dart';

class MyInputWidget extends StatefulWidget {
  const MyInputWidget({
    super.key,
    required this.onChangeCurrency,
    required this.onChangeMoney,
    required this.rates,
    required this.initialSelectedCurrency,
    required this.initialMoney,
  });
  final Function onChangeCurrency;
  final Function onChangeMoney;
  final List<Map<String, double>> rates;

  final String initialSelectedCurrency;
  final double initialMoney;

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  final TextEditingController _controller = TextEditingController();
  late String _selectedCurrency;
  late double _money;

  @override
  void initState() {
    _selectedCurrency = widget.initialSelectedCurrency;
    _money = widget.initialMoney;
    _controller.text = _getFormattedCurrencyString(_money, _selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.background),
      child: Row(
        children: [
          DropdownButton(
            underline: Container(),
            dropdownColor: Theme.of(context).colorScheme.background,
            value: _selectedCurrency,
            items: widget.rates
                .map((e) => DropdownMenuItem(
                    value: e.keys.first,
                    child: Text(
                      ' ${e.keys.first}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    )))
                .toList(),
            onChanged: (String? selected) {
              if (selected != null) {
                _selectedCurrency = selected;
                widget.onChangeCurrency(selected);
                _controller.text =
                    _getFormattedCurrencyString(_money, _selectedCurrency);
              }
            },
          ),
          Expanded(
            flex: 10,
            child: Padding(
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
                // initialValue: _money.toString(),
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
                  _money = _parseInputStringToDouble(value);
                  widget.onChangeMoney(_money);
                },
                onEditingComplete: () {
                  _controller.text = _getFormattedCurrencyString(
                      _parseInputStringToDouble(_controller.text),
                      _selectedCurrency);
                  _selectAllText(_controller);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _parseInputStringToDouble(String value) {
    if (value.isEmpty) {
      return 0;
    } else {
      return double.parse(value);
    }
  }

  void _selectAllText(TextEditingController controller) {
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
  }

  String _getFormattedCurrencyString(double money, String currencyLocale) {
    final formatCurrency = NumberFormat.simpleCurrency(
        decimalDigits: 2, locale: ExchangeRate.currencyLocale[currencyLocale]);
    return formatCurrency.format(money);
  }
}
