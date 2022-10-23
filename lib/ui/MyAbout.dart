import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String homePage = 'https://joeyhwang.tistory.com';

class MyAbout extends StatelessWidget {
  const MyAbout({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri uri = Uri.parse(homePage);
    return Column(
      children: [
        const Image(image: AssetImage('assets/icon/icon.png')),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: const Text(homePage),
              onTap: () => launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              ),
            )
          ],
        )
      ],
    );
  }
}
