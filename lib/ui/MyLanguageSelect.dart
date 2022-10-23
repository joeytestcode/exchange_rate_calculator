import 'package:exchange_rate_calculator/data/data_adapter.dart';
import 'package:exchange_rate_calculator/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLanguageSelect extends StatefulWidget {
  const MyLanguageSelect({super.key});

  @override
  State<MyLanguageSelect> createState() => _MyLanguageSelectState();
}

class _MyLanguageSelectState extends State<MyLanguageSelect> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataAdapter>(builder: (context, dataAdapter, child) {
      return Container(
        width: double.minPositive,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Language.values.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(Language.values[index].name),
                leading: Radio<Language>(
                  groupValue: dataAdapter.language,
                  value: Language.values[index],
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        dataAdapter.language = value;
                      }
                    });
                  },
                ));
          },
        ),
      );
    });
  }
}
