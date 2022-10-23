import 'package:exchange_rate_calculator/data/data_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyInputWidget extends StatefulWidget {
  const MyInputWidget({super.key});

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    DataAdapter dataAdapter = Provider.of<DataAdapter>(context, listen: false);
    _controller.text = _getFormattedCurrencyString(
        dataAdapter.money, dataAdapter.selectedCurrency);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataAdapter>(builder: (context, dataAdapter, child) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton(
                  underline: Container(),
                  dropdownColor: Theme.of(context).colorScheme.background,
                  value: dataAdapter.selectedCurrency,
                  items: dataAdapter.orderedList
                      .map((element) => DropdownMenuItem(
                          value: element,
                          child: Text(
                            ' ${dataAdapter.currencies[element]}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )))
                      .toList(),
                  onChanged: (String? selected) {
                    if (selected != null) {
                      dataAdapter.selectedCurrency = selected;
                      _controller.text = _getFormattedCurrencyString(
                          dataAdapter.money, selected);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: ElevatedButton(
                  child:
                      Center(child: Text('Updated in\n${dataAdapter.date} ')),
                  onPressed: () {
                    dataAdapter.readRate();
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
                dataAdapter.money = _parseInputStringToDouble(value);
              },
              onEditingComplete: () {
                _controller.text = _getFormattedCurrencyString(
                    _parseInputStringToDouble(_controller.text),
                    dataAdapter.selectedCurrency);
                _selectAllText(_controller);
              },
            ),
          ),
        ],
      );
    });
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
