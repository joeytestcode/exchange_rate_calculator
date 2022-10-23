import 'package:exchange_rate_calculator/data/data_adapter.dart';
import 'package:exchange_rate_calculator/ui/MyAbout.dart';
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
    return AppBar(
      title: Text(widget.title),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(Icons.update, color: Colors.blue),
                      Text('  Update currency rates'),
                    ],
                  )),
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, color: Colors.blue),
                      Text('  Filters'),
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(Icons.settings, color: Colors.blue),
                      Text('  Language'),
                    ],
                  )),
              PopupMenuItem(
                  value: 1000,
                  child: Row(
                    children: const [
                      Icon(Icons.question_mark, color: Colors.blue),
                      Text('  About...'),
                    ],
                  )),
            ];
          },
          onSelected: (value) {
            switch (value) {
              case 0:
                Provider.of<DataAdapter>(context, listen: false).readRate();
                break;
              case 1:
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const MyFilters())));
                break;
              case 2:
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('Select Language...'),
                    content: MyLanguageSelect(),
                  ),
                );
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
