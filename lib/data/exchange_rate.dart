import 'dart:convert';
import 'package:html/dom.dart';
import 'package:exchange_rate_calculator/tool/web_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

const currencyLocale = {
  "대한민국 KRW": "ko_KR",
  "미국 USD": "en_US",
  "일본 JPY 100": "ja_JP",
  "유로 EUR": "en_IE",
  "중국 CNY": "zh_CN",
  "홍콩 HKD": "zh_HK",
  "태국 THB": "th_TH",
  "대만 TWD": "zh_TW",
  "필리핀 PHP": "en_PH",
  "싱가포르 SGD": "zh_SG",
  "호주 AUD": "en_AU",
  "베트남 VND 100": "vi_VN",
  "영국 GBP": "en_GB",
  "캐나다 CAD": "en_CA",
  "말레이시아 MYR": "ms_MY",
  "러시아 RUB": "ru_RU",
  "남아공화국 ZAR": "en_ZA",
  "노르웨이 NOK": "nb_NO",
  "뉴질랜드 NZD": "en_NZ",
  "덴마크 DKK": "da_DK",
  "멕시코 MXN": "es_MX",
  "몽골 MNT": "mn_MN",
  "바레인 BHD": "ar_BH",
  "방글라데시 BDT": "bn_BD",
  "브라질 BRL": "pt_BR",
  "브루나이 BND": "ms_BN",
  "사우디아라비아 SAR": "ar_SA",
  "스리랑카 LKR": "si_LK",
  "스웨덴 SEK": "sv_SE",
  "스위스 CHF": "de_CH",
  "아랍에미리트공화국 AED": "ar_AE",
  "알제리 DZD": "ar_DZ",
  "오만 OMR": "ar_OM",
  "요르단 JOD": "ar_JO",
  "이스라엘 ILS": "he_IL",
  "이집트 EGP": "ar_EG",
  "인도 INR": "hi_IN",
  "인도네시아 IDR 100": "id_ID",
  "체코 CZK": "cs_CZ",
  "칠레 CLP": "es_CL",
  "카자흐스탄 KZT": "kk_KZ",
  "카타르 QAR": "ar_QA",
  "케냐 KES": "sw_KE",
  "콜롬비아 COP": "es_CO",
  "쿠웨이트 KWD": "ar_KW",
  "탄자니아 TZS": "en_TZ",
  "터키 TRY": "tr_TR",
  "파키스탄 PKR": "ur_PK",
  "폴란드 PLN": "pl_PL",
  "헝가리 HUF": "hu_HU",
  "네팔 NPR": "ne_NP",
  "마카오 MOP": "en_MO",
  "캄보디아 KHR": "km_KH",
  "피지 FJD": "en_FJ",
  "리비아 LYD": "ar_LY",
  "루마니아 RON": "ro_RO",
  "미얀마 MMK": "my_MM",
  "에티오피아 ETB": "am_ET",
  "우즈베키스탄 UZS": "uz_UZ",
};

class ExchangeRate extends ChangeNotifier {
  ExchangeRate() {
    readRate();
  }

  final String _webPage =
      'https://www.hanabank.com/cont/mall/mall15/mall1501/index.jsp';
  final String _currencyKorea = '대한민국 KRW';
  final List<Map<String, double>> _rates = [];

  List<Map<String, double>> get rates => _rates;

  String _selectedCurrency = '대한민국 KRW';
  String get selectedCurrency {
    _readSelectedCurrency();
    return _selectedCurrency;
  }

  set selectedCurrency(String value) {
    _selectedCurrency = value;
    writeSelectedCurrency(value);
  }

  double _money = 1000.0;
  double get money {
    _readMoney();
    return _money;
  }

  set money(double value) {
    _money = value;
    writeMoney(value);
  }

  Future<void> readRate() async {
    const String selectorDate = '#searchContentDiv';
    Response page = await WebFetcher.getPage(_webPage);
    // String pageString = cp949toUni(page.body.codeUnits);
    Document document = parse(page.body);
    var temp = document.querySelector(selectorDate)?.text;

    print(page.body.toString());
    print(temp);

    // List<Map> fullRates = _readJson(pageString);

    // List<Map<String, double>> returnRates = fullRates.map(
    //   (e) {
    //     return {
    //       e.values.first.toString(): 1.0 / double.parse(e.values.last.trim())
    //     };
    //   },
    // ).toList();
    // returnRates.insert(0, {_currencyKorea: 1.0});

    // _rates.clear();
    // _rates.addAll(returnRates);
    // notifyListeners();
  }

  void _readSelectedCurrency() {
    SharedPreferences.getInstance().then(
      (value) {
        _selectedCurrency = value.getString('selectedCurrency') ?? '대한민국 KRW';
        notifyListeners();
      },
    );
  }

  void writeSelectedCurrency(String currency) {
    SharedPreferences.getInstance().then(
      (value) {
        value.setString('selectedCurrency', currency);
      },
    );
  }

  void _readMoney() {
    SharedPreferences.getInstance().then(
      (value) {
        _money = value.getDouble('money') ?? 0.0;
        notifyListeners();
      },
    );
  }

  void writeMoney(double money) {
    SharedPreferences.getInstance().then(
      (value) {
        value.setDouble('money', money);
      },
    );
  }

  List<Map> _readJson(String json) {
    List<Map> rates = [];
    RegExp re = RegExp(r'\{[^\{\}]*\}');
    Iterable list = re.allMatches(json);

    for (var item in list) {
      rates.add(jsonDecode(item.group(0).toString()));
    }
    return rates;
  }
}
