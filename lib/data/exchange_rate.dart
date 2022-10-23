enum KeyOfPreference {
  money,
  date,
  currencies,
  rates,
  orderedList,
  language,
  autoUpdateAtStarting
}

class ExchangeRate {
  ExchangeRate({
    required this.currencies,
    required this.rates,
    required this.orderedList,
    required this.date,
  });

  late Map<String, Map<String, String>> currencies;
  late Map<String, dynamic> rates;
  late List<String> orderedList;
  late String date;

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    Map<String, Map<String, String>> currencies =
        (json[KeyOfPreference.currencies.name] as Map).map(
      (key, value) => MapEntry(
          key,
          (value as Map).map(
            (key, value) => MapEntry(key, value),
          )),
    );
    Map<String, dynamic> rates = (json[KeyOfPreference.rates.name] as Map).map(
      (key, value) => MapEntry(key, value),
    );
    List<String> orderedList = (json[KeyOfPreference.orderedList.name] as List)
        .map(
          (e) => e.toString(),
        )
        .toList();
    String date = json[KeyOfPreference.date.name];
    return ExchangeRate(
      currencies: currencies,
      rates: rates,
      orderedList: orderedList,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KeyOfPreference.currencies.name: currencies,
      KeyOfPreference.rates.name: rates,
      KeyOfPreference.orderedList.name: orderedList,
      KeyOfPreference.date.name: date,
    };
  }
}
