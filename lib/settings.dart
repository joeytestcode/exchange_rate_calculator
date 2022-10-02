import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
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
