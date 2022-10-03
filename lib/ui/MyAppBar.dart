import 'package:flutter/material.dart';

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
      backgroundColor: Theme.of(context).colorScheme.primary,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
