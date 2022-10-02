import 'package:exchange_rate_calculator/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List> _rates;
  final TextEditingController _controller = TextEditingController();
  String _selectedCurrency = ExchangeRate.currencyKorea;
  double _selectedCurrencyValue = 0.0;
  double _money = 1000.0;

  @override
  void initState() {
    super.initState();
    _rates = ExchangeRate.readRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: const [
                        Icon(Icons.settings, color: Colors.blue),
                        Text('  Settings'),
                      ],
                    )),
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: const [
                        Icon(Icons.question_mark, color: Colors.blue),
                        Text('  About'),
                      ],
                    )),
              ];
            },
            onSelected: (value) {},
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _rates,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              final rates = snapshot.data as List<Map<String, double>>;
              _selectedCurrencyValue = _getSelectedCurrencyValue(rates);
              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: _getListWidget(rates),
                    ),
                    _getInputWidget(rates),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  double _getSelectedCurrencyValue(List<Map> rates) {
    for (var e in rates) {
      if (e.containsKey(_selectedCurrency)) {
        return e.values.first;
      }
    }
    return -1.0;
  }

  ReorderableListView _getListWidget(List<Map<String, double>> rates) {
    return ReorderableListView.builder(
      itemCount: rates.length - 1,
      itemBuilder: (context, index) {
        final formatCurrency = NumberFormat.simpleCurrency(
            decimalDigits: 2,
            locale: ExchangeRate.currencyLocale[rates[index].keys.first]);
        return ListTile(
          style: ListTileStyle.drawer,
          key: Key('$index'),
          tileColor: index % 2 == 0 ? Colors.white : Colors.grey.shade200,
          title: Row(
            children: [
              Text(rates[index].keys.first),
              Expanded(
                flex: 10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(formatCurrency.format(_money /
                      _selectedCurrencyValue *
                      rates[index].values.first)),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        );
      },
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex = newIndex - 1;
          }
          final rate = rates.removeAt(oldIndex);
          rates.insert(newIndex, rate);
        });
      },
    );
  }

  Container _getInputWidget(List<Map<String, double>> rates) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue.shade900),
      child: Row(
        children: [
          DropdownButton(
            underline: Container(),
            value: _selectedCurrency,
            items: rates
                .map((e) => DropdownMenuItem(
                    value: e.keys.first,
                    child: Text(
                      ' ${e.keys.first}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCurrency = value ?? '';
                _selectedCurrencyValue = _getSelectedCurrencyValue(rates);
                _setTextFormCurrency();
              });
            },
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: TextFormField(
                autofocus: true,
                decoration:
                    const InputDecoration(contentPadding: EdgeInsets.all(2)),
                controller: _controller,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white, fontSize: 24),
                // initialValue: _money.toString(),
                maxLines: 1,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d\.]'))
                ],
                textAlign: TextAlign.right,
                onTap: () {
                  _selectAllText();
                },
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      _money = 0;
                    } else {
                      _money = double.parse(value);
                    }
                  });
                },
                onEditingComplete: () {
                  _setTextFormCurrency();
                  _selectAllText();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectAllText() {
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  void _setTextFormCurrency() {
    final formatCurrency = NumberFormat.simpleCurrency(
        decimalDigits: 2,
        locale: ExchangeRate.currencyLocale[_selectedCurrency]);
    _controller.text = formatCurrency.format(_money);
  }
}
