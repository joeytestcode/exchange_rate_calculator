import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySettings extends StatefulWidget {
  const MySettings({super.key});

  @override
  State<MySettings> createState() => _MySettingState();
}

class _MySettingState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> setReferences(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedCurrency', list);
  }

  Future<List<String>> getReferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('selectedCurrency') ?? [];
  }
}
