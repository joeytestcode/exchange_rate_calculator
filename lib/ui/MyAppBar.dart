import 'package:common/my_about.dart';
import 'package:exchange_rate_calculator/data/data_adapter.dart';
import 'package:exchange_rate_calculator/strings.dart';
import 'package:exchange_rate_calculator/ui/MyFilters.dart';
import 'package:exchange_rate_calculator/ui/MyLanguageSelect.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'MyHomePage.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.widget,
  });

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataAdapter>(builder: (context, dataAdapter, child) {
      return AppBar(
        title: Text(titles[dataAdapter.language][Titles.title]),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: [
                        const Icon(Icons.update, color: Colors.blue),
                        Text(titles[dataAdapter.language]
                            [Titles.updateCurrencyRates]),
                      ],
                    )),
                PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        const Icon(Icons.settings, color: Colors.blue),
                        Text(titles[dataAdapter.language][Titles.filters]),
                      ],
                    )),
                PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        const Icon(Icons.settings, color: Colors.blue),
                        Text(titles[dataAdapter.language][Titles.language]),
                      ],
                    )),
                PopupMenuItem(
                    value: 3,
                    child: Row(
                      children: [
                        const Icon(Icons.settings, color: Colors.blue),
                        Text(titles[dataAdapter.language]
                            [Titles.resetAllSettings]),
                      ],
                    )),
                PopupMenuItem(
                    value: 1000,
                    child: Row(
                      children: [
                        const Icon(Icons.question_mark, color: Colors.blue),
                        Text(titles[dataAdapter.language][Titles.about]),
                      ],
                    )),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  dataAdapter.readRate();
                  break;
                case 1:
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const MyFilters())));
                  break;
                case 2:
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Select Language...'),
                      content: const MyLanguageSelect(),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                  break;
                case 3:
                  dataAdapter.resetAllValue();
                  break;
                case 1000:
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(content: MyAbout()),
                  );
                  break;
                default:
                  break;
              }
            },
          )
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
