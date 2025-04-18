import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data_adapter.dart';
import '../settings.dart';

class MyLanguageSelect extends StatefulWidget {
  const MyLanguageSelect({super.key});

  @override
  State<MyLanguageSelect> createState() => _MyLanguageSelectState();
}

class _MyLanguageSelectState extends State<MyLanguageSelect> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataAdapter>(builder: (context, dataAdapter, child) {
      return SizedBox(
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
                  setState(
                    () {
                      if (value != null) {
                        dataAdapter.language = value;
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}
