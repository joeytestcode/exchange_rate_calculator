import 'dart:convert';

import 'package:common/get_webpage.dart';
import 'package:exchange_rate_calculator/data/exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../settings.dart';
import '../strings.dart';

class DataAdapter with ChangeNotifier {
  DataAdapter() {
    isReady = init();
  }

  ExchangeRate _exchangeRate = ExchangeRate.getDefaultExchangeRate();
  Settings _settings = Settings.getDefaultSettings();
  late Future<bool> isReady;

  Language get language => _settings.language;
  set language(Language language) {
    _settings.language = language;
    saveSettings();
    notifyListeners();
  }

  String get date => _exchangeRate.date;

  String get selectedCurrency => _exchangeRate.orderedList[0];
  set selectedCurrency(String currency) {
    _exchangeRate.orderedList.insert(
        0,
        _exchangeRate.orderedList
            .removeAt(_exchangeRate.orderedList.indexOf(currency)));
    notifyListeners();
  }

  double get money => _settings.money;
  set money(double value) {
    _settings.money = value;
    notifyListeners();
    saveSettings();
  }

  List<String> get orderedList => _exchangeRate.orderedList;

  String removeAtFromOrderedList(int index) {
    final String result = _exchangeRate.orderedList.removeAt(index);
    notifyListeners();
    return result;
  }

  void insertToOrderedList(int index, String data) {
    _exchangeRate.orderedList.insert(index, data);
    notifyListeners();
  }

  Map<String, String> get currencies =>
      _exchangeRate.currencies[_settings.language.name]!;

  Map<String, dynamic> get rates => _exchangeRate.rates;

  void addToOrderedList(String currency) {
    if (!_exchangeRate.orderedList.contains(currency)) {
      _exchangeRate.orderedList.add(currency);
      notifyListeners();
    }
  }

  void removeFromOrderedList(String currency) {
    if (_exchangeRate.orderedList.contains(currency)) {
      _exchangeRate.orderedList.remove(currency);
      notifyListeners();
    }
  }

  Future<bool> init() async {
    await readSharedReferences();
    if (_settings.autoUpdateAtStarting) readRate();
    return true;
  }

  Future<void> resetAllValue() async {
    _exchangeRate = ExchangeRate.getDefaultExchangeRate();
    _settings = Settings.getDefaultSettings();
    await saveExchangeRate();
    await saveSettings();
    notifyListeners();
  }

  Future<void> readSharedReferences() async {
    final prefs = await SharedPreferences.getInstance();
    final decodedMap1 =
        jsonDecode(prefs.getString(sharedPreferencesExchangeRateKey) ?? '{}')
            as Map<String, dynamic>;

    _exchangeRate = decodedMap1.isNotEmpty
        ? ExchangeRate.fromJson(decodedMap1)
        : ExchangeRate.getDefaultExchangeRate();

    final decodedMap2 =
        jsonDecode(prefs.getString(sharedPreferencesSettingsKey) ?? '{}')
            as Map<String, dynamic>;

    _settings = decodedMap2.isNotEmpty
        ? Settings.fromJson(decodedMap2)
        : Settings.getDefaultSettings();
  }

  void decodeCurrencies(Map<String, dynamic> map) {
    _exchangeRate.currencies = {
      Language.ENGLISH.name:
          map.map((key, value) => MapEntry(key, value.toString())),
      Language.KOREAN.name: map.map((key, value) => MapEntry(
          key, _exchangeRate.currencies[Language.KOREAN.name]?[key] ?? value))
    };
  }

  void decodeDateAndRates(Map<String, dynamic> map) {
    _exchangeRate.date = map[webKeyDate];
    _exchangeRate.rates = map[webKeyBTC];
  }

  Future<void> readRate() async {
    var page1 = await GetWebpage.get(webPageCurrencies);
    decodeCurrencies(jsonDecode(page1.data));

    var page2 = await GetWebpage.get(webPageRatesBasedOnBTC);
    decodeDateAndRates(jsonDecode(page2.data));

    notifyListeners();
  }

  Future<void> saveExchangeRate() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        sharedPreferencesExchangeRateKey, jsonEncode(_exchangeRate.toJson()));
  }

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        sharedPreferencesSettingsKey, jsonEncode(_settings.toJson()));
  }
}
