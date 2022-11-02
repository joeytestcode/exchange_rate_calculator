import 'package:exchange_rate_calculator/settings.dart';

const String sharedPreferencesExchangeRateKey = 'data';
const String sharedPreferencesSettingsKey = 'settings';
// Site providing Exchange rate : https://github.com/fawazahmed0/currency-api
const String webPageCurrencies =
    'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.min.json';
const String webPageRatesBasedOnBTC =
    'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/btc.json';
const String webKeyDate = 'date';
const String webKeyBTC = 'btc';

enum Titles {
  title,
  updateCurrencyRates,
  filters,
  language,
  resetAllSettings,
  about,
  updateButton,
}

const Map titles = {
  Language.ENGLISH: {
    Titles.title: 'Exchange Rate Calculator',
    Titles.updateCurrencyRates: '  Update currency rates',
    Titles.filters: '  Filters',
    Titles.language: '  Language',
    Titles.resetAllSettings: '  Reset all settings',
    Titles.about: '  About',
    Titles.updateButton: 'Updated in'
  },
  Language.KOREAN: {
    Titles.title: '환율 계산기',
    Titles.updateCurrencyRates: '  환율 정보 업데이트',
    Titles.filters: '  필터',
    Titles.language: '  언어',
    Titles.resetAllSettings: '  세팅 초기화',
    Titles.about: '  About',
    Titles.updateButton: '업데이트'
  },
};
