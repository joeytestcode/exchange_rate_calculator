import 'data/exchange_rate.dart';

enum Language { ENGLISH, KOREAN }

class Settings {
  Settings(
      {required this.money,
      required this.language,
      required this.autoUpdateAtStarting});
  late double money;
  late Language language;
  late bool autoUpdateAtStarting;

  static Settings getDefaultSettings() {
    return Settings(
      autoUpdateAtStarting: true,
      language: Language.KOREAN,
      money: 10000.0,
    );
  }

  factory Settings.fromJson(Map<String, dynamic> json) {
    double money =
        json[KeyOfPreference.money.name] ?? getDefaultSettings().money;
    Language language = getDefaultSettings().language;
    try {
      language = Language.values.byName(json[KeyOfPreference.language.name]);
    } on Exception catch (e) {
      language = getDefaultSettings().language;
    }

    bool autoUpdateAtStarting = json[KeyOfPreference.autoUpdateAtStarting] ??
        getDefaultSettings().autoUpdateAtStarting;
    return Settings(
      money: money,
      language: language,
      autoUpdateAtStarting: autoUpdateAtStarting,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      KeyOfPreference.money.name: money,
      KeyOfPreference.language.name: language.name,
      KeyOfPreference.autoUpdateAtStarting.name: autoUpdateAtStarting,
    };
  }
}
