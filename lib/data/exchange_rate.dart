import 'dart:convert';
import 'package:exchange_rate_calculator/tool/web_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _defaultDate = '2022.10.04';
const double _defaultMoney = 1000.0;
const String _defaultSelectedCurrency = 'krw';
const List<String> _defaultFilter = [
  '1inch',
  'aave',
  'ada',
  'algo',
  'amp',
  'ar',
  'atom',
  'avax',
  'axs',
  'bat',
  'bch',
  'bnb',
  'bsv',
  'btc',
  'btcb',
  'btg',
  'cake',
  'celo',
  'chz',
  'cro',
  'crv',
  'dai',
  'dash',
  'dcr',
  'dfi',
  'doge',
  'dot',
  'egld',
  'enj',
  'eos',
  'etb',
  'etc',
  'eth',
  'fil',
  'flow',
  'frax',
  'ftm',
  'ftt',
  'gala',
  'ggp',
  'gno',
  'grt',
  'gt',
  'hbar',
  'hnt',
  'hot',
  'imp',
  'inj',
  'kava',
  'kcs',
  'kda',
  'klay',
  'knc',
  'ksm',
  'leo',
  'link',
  'lrc',
  'ltc',
  'luna',
  'mana',
  'matic',
  'mina',
  'miota',
  'mkr',
  'near',
  'neo',
  'nexo',
  'okb',
  'paxg',
  'pen',
  'qnt',
  'qtum',
  'rune',
  'sand',
  'sol',
  'stx',
  'theta',
  'trx',
  'ttt',
  'uni',
  'usdc',
  'usdp',
  'usdt',
  'vet',
  'waves',
  'wbtc',
  'wemix',
  'xau',
  'xdc',
  'xdr',
  'xec',
  'xem',
  'xlm',
  'xmr',
  'xrp',
  'xtz',
  'zec',
  'zil',
];
const Map<String, String> _defaultCurrencies = {
  '1inch': '1inch Network',
  'aave': 'Aave',
  'ada': 'Cardano',
  'aed': 'United Arab Emirates Dirham',
  'afn': 'Afghan afghani',
  'algo': 'Algorand',
  'all': 'Albanian lek',
  'amd': 'Armenian dram',
  'amp': 'Synereo',
  'ang': 'Netherlands Antillean Guilder',
  'aoa': 'Angolan kwanza',
  'ar': 'Arweave',
  'ars': 'Argentine peso',
  'atom': 'Atomic Coin',
  'aud': 'Australian dollar',
  'avax': 'Avalanche',
  'awg': 'Aruban florin',
  'axs': 'AXS',
  'azn': 'Azerbaijani manat',
  'bam': 'Bosnia-Herzegovina Convertible Mark',
  'bat': 'Basic Attention Token',
  'bbd': 'Bajan dollar',
  'bch': 'Bitcoin Cash',
  'bdt': 'Bangladeshi taka',
  'bgn': 'Bulgarian lev',
  'bhd': 'Bahraini dinar',
  'bif': 'Burundian Franc',
  'bmd': 'Bermudan dollar',
  'bnb': 'Binance Coin',
  'bnd': 'Brunei dollar',
  'bob': 'Bolivian boliviano',
  'brl': 'Brazilian real',
  'bsd': 'Bahamian dollar',
  'bsv': 'Bitcoin SV',
  'btc': 'Bitcoin',
  'btcb': 'Bitcoin BEP2',
  'btg': 'Bitcoin Gold',
  'btn': 'Bhutan currency',
  'busd': 'Binance USD',
  'bwp': 'Botswanan Pula',
  'byn': 'New Belarusian Ruble',
  'byr': 'Belarusian Ruble',
  'bzd': 'Belize dollar',
  'cad': 'Canadian dollar',
  'cake': 'PancakeSwap',
  'cdf': 'Congolese franc',
  'celo': 'Celo',
  'chf': 'Swiss franc',
  'chz': 'Chiliz',
  'clf': 'Chilean Unit of Account (UF)',
  'clp': 'Chilean peso',
  'cny': 'Chinese Yuan',
  'comp': 'Compound Coin',
  'cop': 'Colombian peso',
  'crc': 'Costa Rican Colón',
  'cro': 'Crypto.com Chain Token',
  'crv': 'Cravy',
  'cuc': 'Cuban peso',
  'cup': 'Cuban Peso',
  'cve': 'Cape Verdean escudo',
  'cvx': 'Convex Finance',
  'czk': 'Czech koruna',
  'dai': 'Dai',
  'dash': 'Dash',
  'dcr': 'Decred',
  'dfi': 'DfiStarter',
  'djf': 'Djiboutian franc',
  'dkk': 'Danish krone',
  'doge': 'Dogecoin',
  'dop': 'Dominican peso',
  'dot': 'Dotcoin',
  'dzd': 'Algerian dinar',
  'egld': 'Elrond',
  'egp': 'Egyptian pound',
  'enj': 'Enjin Coin',
  'eos': 'EOS',
  'ern': 'Eritrean nakfa',
  'etb': 'Ethiopian birr',
  'etc': 'Ethereum Classic',
  'eth': 'Ether',
  'eur': 'Euro',
  'fei': 'Fei USD',
  'fil': 'FileCoin',
  'fjd': 'Fijian dollar',
  'fkp': 'Falkland Islands pound',
  'flow': 'Flow',
  'frax': 'Frax',
  'ftm': 'Fantom',
  'ftt': 'FarmaTrust',
  'gala': 'Gala',
  'gbp': 'Pound sterling',
  'gel': 'Georgian lari',
  'ggp': 'GGPro',
  'ghs': 'Ghanaian cedi',
  'gip': 'Gibraltar pound',
  'gmd': 'Gambian dalasi',
  'gnf': 'Guinean franc',
  'gno': 'Gnosis',
  'grt': 'Golden Ratio Token',
  'gt': 'GateToken',
  'gtq': 'Guatemalan quetzal',
  'gyd': 'Guyanaese Dollar',
  'hbar': 'Hedera',
  'hkd': 'Hong Kong dollar',
  'hnl': 'Honduran lempira',
  'hnt': 'Helium',
  'hot': 'Hydro Protocol',
  'hrk': 'Croatian kuna',
  'ht': 'Huobi Token',
  'htg': 'Haitian gourde',
  'huf': 'Hungarian forint',
  'icp': 'Internet Computer',
  'idr': 'Indonesian rupiah',
  'ils': 'Israeli New Shekel',
  'imp': 'CoinIMP',
  'inj': 'Injective',
  'inr': 'Indian rupee',
  'iqd': 'Iraqi dinar',
  'irr': 'Iranian rial',
  'isk': 'Icelandic króna',
  'jep': 'Jersey Pound',
  'jmd': 'Jamaican dollar',
  'jod': 'Jordanian dinar',
  'jpy': 'Japanese yen',
  'kava': 'Kava',
  'kcs': 'Kucoin',
  'kda': 'Kadena',
  'kes': 'Kenyan shilling',
  'kgs': 'Kyrgystani Som',
  'khr': 'Cambodian riel',
  'klay': 'Klaytn',
  'kmf': 'Comorian franc',
  'knc': 'Kyber Network',
  'kpw': 'North Korean won',
  'krw': 'South Korean won',
  'ksm': 'Kusama',
  'kwd': 'Kuwaiti dinar',
  'kyd': 'Cayman Islands dollar',
  'kzt': 'Kazakhstani tenge',
  'lak': 'Laotian Kip',
  'lbp': 'Lebanese pound',
  'leo': 'LEOcoin',
  'link': 'ChainLink',
  'lkr': 'Sri Lankan rupee',
  'lrc': 'Loopring',
  'lrd': 'Liberian dollar',
  'lsl': 'Lesotho loti',
  'ltc': 'Litecoin',
  'ltl': 'Lithuanian litas',
  'luna': 'Luna Coin',
  'lvl': 'Latvian lats',
  'lyd': 'Libyan dinar',
  'mad': 'Moroccan dirham',
  'mana': 'Decentraland',
  'matic': 'Polygon',
  'mdl': 'Moldovan leu',
  'mga': 'Malagasy ariary',
  'mina': 'Mina',
  'miota': 'IOTA',
  'mkd': 'Macedonian denar',
  'mkr': 'Maker',
  'mmk': 'Myanmar Kyat',
  'mnt': 'Mongolian tugrik',
  'mop': 'Macanese pataca',
  'mro': 'Mauritanian ouguiya',
  'mur': 'Mauritian rupee',
  'mvr': 'Maldivian rufiyaa',
  'mwk': 'Malawian kwacha',
  'mxn': 'Mexican peso',
  'myr': 'Malaysian ringgit',
  'mzn': 'Mozambican Metical',
  'nad': 'Namibian dollar',
  'near': 'NEAR Protocol',
  'neo': 'NEO',
  'nexo': 'NEXO',
  'ngn': 'Nigerian naira',
  'nio': 'Nicaraguan córdoba',
  'nok': 'Norwegian krone',
  'npr': 'Nepalese rupee',
  'nzd': 'New Zealand dollar',
  'okb': 'Okex',
  'omr': 'Omani rial',
  'one': 'Menlo One',
  'pab': 'Panamanian balboa',
  'paxg': 'PAX Gold',
  'pen': 'Sol',
  'pgk': 'Papua New Guinean kina',
  'php': 'Philippine peso',
  'pkr': 'Pakistani rupee',
  'pln': 'Poland złoty',
  'pyg': 'Paraguayan guarani',
  'qar': 'Qatari Rial',
  'qnt': 'Quant',
  'qtum': 'QTUM',
  'ron': 'Romanian leu',
  'rsd': 'Serbian dinar',
  'rub': 'Russian ruble',
  'rune': 'THORChain (ERC20)',
  'rwf': 'Rwandan Franc',
  'sand': 'BeachCoin',
  'sar': 'Saudi riyal',
  'sbd': 'Solomon Islands dollar',
  'scr': 'Seychellois rupee',
  'sdg': 'Sudanese pound',
  'sek': 'Swedish krona',
  'sgd': 'Singapore dollar',
  'shib': 'Shiba Inu',
  'shp': 'Saint Helena pound',
  'sll': 'Sierra Leonean leone',
  'sol': 'Sola',
  'sos': 'Somali shilling',
  'srd': 'Surinamese dollar',
  'std': 'São Tomé and Príncipe Dobra (pre-2018)',
  'stx': 'Stox',
  'svc': 'Salvadoran Colón',
  'syp': 'Syrian pound',
  'szl': 'Swazi lilangeni',
  'thb': 'Thai baht',
  'theta': 'Theta',
  'tjs': 'Tajikistani somoni',
  'tmt': 'Turkmenistani manat',
  'tnd': 'Tunisian dinar',
  'top': 'Tongan Paʻanga',
  'trx': 'TRON',
  'try': 'Turkish lira',
  'ttd': 'Trinidad & Tobago Dollar',
  'ttt': 'Tap Project',
  'tusd': 'True USD',
  'twd': 'New Taiwan dollar',
  'tzs': 'Tanzanian shilling',
  'uah': 'Ukrainian hryvnia',
  'ugx': 'Ugandan shilling',
  'uni': 'Universe',
  'usd': 'United States dollar',
  'usdc': 'USD Coin',
  'usdp': 'USDP Stablecoin',
  'usdt': 'Tether',
  'uyu': 'Uruguayan peso',
  'uzs': 'Uzbekistani som',
  'vet': 'Vechain',
  'vnd': 'Vietnamese dong',
  'vuv': 'Vanuatu vatu',
  'waves': 'Waves',
  'wbtc': 'Wrapped Bitcoin',
  'wemix': 'WEMIX',
  'wst': 'Samoan tala',
  'xaf': 'Central African CFA franc',
  'xag': 'Silver Ounce',
  'xau': 'XauCoin',
  'xcd': 'East Caribbean dollar',
  'xdc': 'XDC Network',
  'xdr': 'Special Drawing Rights',
  'xec': 'Eternal Coin',
  'xem': 'NEM',
  'xlm': 'Stellar',
  'xmr': 'Monero',
  'xof': 'West African CFA franc',
  'xpf': 'CFP franc',
  'xrp': 'XRP',
  'xtz': 'Tezos',
  'yer': 'Yemeni rial',
  'zar': 'South African rand',
  'zec': 'ZCash',
  'zil': 'Zilliqa',
  'zmk': 'Zambian kwacha',
  'zmw': 'Zambian Kwacha',
  'zwl': 'Zimbabwean Dollar'
};
const Map<String, dynamic> _defaultRates = {
  '1inch': 0.001154,
  'aave': 0.000009,
  'ada': 0.001653,
  'aed': 0.002578,
  'afn': 0.061057,
  'algo': 0.002072,
  'all': 0.083727,
  'amd': 0.28392,
  'amp': 0.140129,
  'ang': 0.001264,
  'aoa': 0.308205,
  'ar': 0.000077,
  'ars': 0.104722,
  'atom': 0.000054,
  'aud': 0.0011,
  'avax': 0.000041,
  'awg': 0.001265,
  'axs': 0.000056,
  'azn': 0.001196,
  'bam': 0.0014,
  'bat': 0.002332,
  'bbd': 0.001416,
  'bch': 0.000006,
  'bdt': 0.072643,
  'bgn': 0.001408,
  'bhd': 0.000265,
  'bif': 1.438687,
  'bmd': 0.000702,
  'bnb': 0.000002,
  'bnd': 0.001002,
  'bob': 0.004847,
  'brl': 0.003653,
  'bsd': 0.000701,
  'bsv': 0.000014,
  'btc': 0,
  'btcb': 0,
  'btg': 0.000035,
  'btn': 0.057764,
  'busd': 0.000702,
  'bwp': 0.009339,
  'byn': 0.001779,
  'byr': 13.755251,
  'bzd': 0.001414,
  'cad': 0.000964,
  'cake': 0.000153,
  'cdf': 1.43483,
  'celo': 0.000902,
  'chf': 0.000698,
  'chz': 0.003184,
  'clf': 0.000024,
  'clp': 0.658519,
  'cny': 0.004994,
  'comp': 0.000012,
  'cop': 3.242316,
  'crc': 0.445137,
  'cro': 0.006509,
  'crv': 0.000778,
  'cuc': 0.000702,
  'cup': 0.018598,
  'cve': 0.079198,
  'cvx': 0.000126,
  'czk': 0.017641,
  'dai': 0.000702,
  'dash': 0.000016,
  'dcr': 0.000027,
  'dfi': 0.037125,
  'djf': 0.124724,
  'dkk': 0.005359,
  'doge': 0.011242,
  'dop': 0.037599,
  'dot': 0.00011,
  'dzd': 0.098556,
  'egld': 0.000013,
  'egp': 0.0138,
  'enj': 0.00156,
  'eos': 0.000622,
  'ern': 0.010527,
  'etb': 0.036917,
  'etc': 0.000026,
  'eth': 0.000001,
  'eur': 0.000721,
  'fei': 0.000711,
  'fil': 0.000128,
  'fjd': 0.001624,
  'fkp': 0.000607,
  'flow': 0.000415,
  'frax': 0.000703,
  'ftm': 0.003144,
  'ftt': 0.000029,
  'gala': 0.017268,
  'gbp': 0.000633,
  'gel': 0.001962,
  'ggp': 0.000607,
  'ghs': 0.007334,
  'gip': 0.000607,
  'gmd': 0.039023,
  'gnf': 6.144246,
  'gno': 0.000006,
  'grt': 0.00714,
  'gt': 0.000159,
  'gtq': 0.005537,
  'gyd': 0.14673,
  'hbar': 0.011683,
  'hkd': 0.005509,
  'hnl': 0.017384,
  'hnt': 0.000145,
  'hot': 0.00423,
  'hrk': 0.005421,
  'ht': 0.00016,
  'htg': 0.085219,
  'huf': 0.306056,
  'icp': 0.000118,
  'idr': 10.730991,
  'ils': 0.002484,
  'imp': 0.000607,
  'inj': 0.000355,
  'inr': 0.058126,
  'iqd': 1.024626,
  'irr': 29.686078,
  'isk': 0.101193,
  'jep': 0.000607,
  'jmd': 0.107553,
  'jod': 0.000498,
  'jpy': 0.102038,
  'kava': 0.000457,
  'kcs': 0.000077,
  'kda': 0.000498,
  'kes': 0.08485,
  'kgs': 0.057068,
  'khr': 2.898428,
  'klay': 0.00373,
  'kmf': 0.352215,
  'knc': 0.000618,
  'kpw': 0.631619,
  'krw': 1,
  'ksm': 0.000016,
  'kwd': 0.000218,
  'kyd': 0.000584,
  'kzt': 0.330807,
  'lak': 11.667401,
  'lbp': 1.068138,
  'leo': 0.000171,
  'link': 0.000092,
  'lkr': 0.256004,
  'lrc': 0.002425,
  'lrd': 0.107832,
  'lsl': 0.012576,
  'ltc': 0.000013,
  'ltl': 0.002072,
  'luna': 0.00028,
  'lvl': 0.000425,
  'lyd': 0.003502,
  'mad': 0.007686,
  'mana': 0.001007,
  'matic': 0.000843,
  'mdl': 0.013624,
  'mga': 2.954572,
  'mina': 0.001202,
  'miota': 0.002597,
  'mkd': 0.044112,
  'mkr': 0.000001,
  'mmk': 1.472898,
  'mnt': 2.262909,
  'mop': 0.005671,
  'mro': 0.250542,
  'mur': 0.03183,
  'mvr': 0.01085,
  'mwk': 0.714784,
  'mxn': 0.014062,
  'myr': 0.003255,
  'mzn': 0.044796,
  'nad': 0.012576,
  'near': 0.000197,
  'neo': 0.000082,
  'nexo': 0.000802,
  'ngn': 0.304384,
  'nio': 0.025251,
  'nok': 0.007518,
  'npr': 0.092426,
  'nzd': 0.001253,
  'okb': 0.000045,
  'omr': 0.00027,
  'one': 1.307676,
  'pab': 0.000701,
  'paxg': 0,
  'pen': 0.002784,
  'pgk': 0.002474,
  'php': 0.041446,
  'pkr': 0.156501,
  'pln': 0.003501,
  'pyg': 4.972878,
  'qar': 0.002555,
  'qnt': 0.000005,
  'qtum': 0.000249,
  'ron': 0.003559,
  'rsd': 0.08449,
  'rub': 0.043757,
  'rune': 0.000443,
  'rwf': 0.731274,
  'sand': 0.000838,
  'sar': 0.002638,
  'sbd': 0.005724,
  'scr': 0.009523,
  'sdg': 0.401429,
  'sek': 0.007869,
  'sgd': 0.001006,
  'shib': 63.185537,
  'shp': 0.000967,
  'sll': 11.404226,
  'sol': 0.000021,
  'sos': 0.398273,
  'srd': 0.01937,
  'std': 14.525812,
  'stx': 0.185302,
  'svc': 0.006137,
  'syp': 1.76329,
  'szl': 0.012576,
  'thb': 0.026367,
  'theta': 0.000657,
  'tjs': 0.007094,
  'tmt': 0.002456,
  'tnd': 0.002296,
  'top': 0.00171,
  'trx': 0.011219,
  'try': 0.013041,
  'ttd': 0.004765,
  'ttt': 0.036085,
  'tusd': 0.000702,
  'twd': 0.022265,
  'tzs': 1.636594,
  'uah': 0.025905,
  'ugx': 2.678584,
  'uni': 17.933902,
  'usd': 0.000702,
  'usdc': 0.000702,
  'usdp': 0.000703,
  'usdt': 0.000702,
  'uyu': 0.028753,
  'uzs': 7.772419,
  'vet': 0.030159,
  'vnd': 16.762458,
  'vuv': 0.083487,
  'waves': 0.000185,
  'wbtc': 0,
  'wemix': 0.000391,
  'wst': 0.001913,
  'xaf': 0.469594,
  'xag': 0.000035,
  'xau': 0,
  'xcd': 0.001897,
  'xdc': 0.022028,
  'xdr': 0.000545,
  'xec': 16.604337,
  'xem': 0.017217,
  'xlm': 0.0057,
  'xmr': 0.000005,
  'xof': 0.463889,
  'xpf': 0.08562,
  'xrp': 0.001353,
  'xtz': 0.000496,
  'yer': 0.175625,
  'zar': 0.012623,
  'zec': 0.000013,
  'zil': 0.022067,
  'zmk': 6.317031,
  'zmw': 0.011103,
  'zwl': 0.225979
};

const String _webPageCurrencies =
    'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.min.json';
const String _webPageRatesBasedOnKRW =
    'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/krw.json';

enum KeyOfPreference {
  selectedCurrency,
  money,
  date,
  currencies,
  fullNames,
  rates,
  filter,
  orderedList,
}

class ExchangeRate extends ChangeNotifier {
  ExchangeRate() {
    isReady = getInitialValues();
    // readRate();
  }

  late Future<bool> isReady;

  Future<bool> getInitialValues() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      _money = prefs.getDouble(KeyOfPreference.money.name) ?? _defaultMoney;
      _date = prefs.getString(KeyOfPreference.date.name) ?? _defaultDate;

      var tempFilter =
          prefs.getStringList(KeyOfPreference.filter.name) ?? _defaultFilter;
      _filter.clear();
      _filter.addAll(tempFilter);

      var tempCurrencies =
          prefs.getStringList(KeyOfPreference.currencies.name) ??
              _defaultCurrencies.keys.toList();
      var tempFullNames = prefs.getStringList(KeyOfPreference.fullNames.name) ??
          tempCurrencies.map((e) => _defaultCurrencies[e]).toList();
      var tempRates = prefs
              .getStringList(KeyOfPreference.rates.name)
              ?.map((e) => double.parse(e))
              .toList() ??
          tempCurrencies.map((e) => _defaultRates[e]).toList();

      _currencies.clear();
      _rates.clear();
      for (int i = 0; i < tempCurrencies.length; i++) {
        _currencies[tempCurrencies[i]] = tempFullNames[i] ?? '';
        _rates[tempCurrencies[i]] = tempRates[i] ?? '';
      }

      _selectedCurrency =
          prefs.getString(KeyOfPreference.selectedCurrency.name) ??
              _defaultSelectedCurrency;
      if (filter.contains(_selectedCurrency)) {
        _selectedCurrency = _currencies.keys
            .where(
              (element) => !filter.contains(element),
            )
            .toList()[0];
      }
      var tempOrderedList =
          prefs.getStringList(KeyOfPreference.orderedList.name) ?? [];
      if (tempOrderedList.length != _currencies.length - _filter.length - 1) {
        tempOrderedList = _currencies.keys
            .where((element) =>
                !_filter.contains(element) && element != _selectedCurrency)
            .toList();
      }
      _orderedList.clear();
      _orderedList.addAll(tempOrderedList);
    } on Exception catch (e) {
      await readRate();
    }

    return true;
  }

  final Map<String, String> _currencies = {};
  Map<String, String> get currencies => _currencies;

  final Map<String, dynamic> _rates = {};
  Map<String, dynamic> get rates {
    Map<String, dynamic> result = Map.from(_rates);
    for (var element in _filter) {
      result.remove(element);
    }
    return result;
  }

  String _selectedCurrency = _defaultSelectedCurrency;
  String get selectedCurrency => _selectedCurrency;

  set selectedCurrency(String value) {
    _orderedList.insert(0, _selectedCurrency);
    _orderedList.remove(value);
    _selectedCurrency = value;
    notifyListeners();
    _setValueTOPreference(KeyOfPreference.selectedCurrency, value);
    _setValueTOPreference(KeyOfPreference.orderedList, _orderedList);
  }

  late double _money;
  double get money => _money;

  set money(double value) {
    _money = value;
    notifyListeners();
    _setValueTOPreference(KeyOfPreference.money, value);
  }

  String _date = _defaultDate;
  String get date => _date;

  set date(String value) {
    _date = value;
    notifyListeners();
    _setValueTOPreference(KeyOfPreference.date, value);
  }

  final List<String> _filter = [];
  List<String> get filter => _filter;

  void addFilter(String currency) {
    if (currencies.keys.contains(currency) && !filter.contains(currency)) {
      _filter.add(currency);
      if (_selectedCurrency == currency) {
        _selectedCurrency = _currencies.keys
            .where((element) => !filter.contains(element))
            .toList()[0];
      }
      _orderedList.remove(currency);
      notifyListeners();
      _setValueTOPreference(KeyOfPreference.filter, _filter);
      _setValueTOPreference(KeyOfPreference.orderedList, _orderedList);
    }
  }

  void removeFilter(String currency) {
    _filter.remove(currency);
    _orderedList.add(currency);
    notifyListeners();
    _setValueTOPreference(KeyOfPreference.filter, _filter);
    _setValueTOPreference(KeyOfPreference.orderedList, _orderedList);
  }

  final List<String> _orderedList = [];
  List<String> get orderedList => _orderedList;

  void insertToOrderedList(int index, String element) {
    _orderedList.insert(index, element);
    _setValueTOPreference(KeyOfPreference.orderedList, _orderedList);
  }

  String removeAtFromOrderedList(int index) {
    var result = _orderedList.removeAt(index);
    _setValueTOPreference(KeyOfPreference.orderedList, _orderedList);
    return result;
  }

  Future<void> readRate() async {
    var page1 = await WebFetcher.getPage(_webPageCurrencies);
    _currencies.clear();
    _currencies.addAll((jsonDecode(page1.body) as Map).map(
      (key, value) => MapEntry(key, value as String),
    ));

    var tempKeys = _currencies.keys.toList();
    _setValueTOPreference(KeyOfPreference.currencies, tempKeys);
    _setValueTOPreference(KeyOfPreference.fullNames,
        tempKeys.map((e) => _currencies[e].toString()).toList());

    var page2 = await WebFetcher.getPage(_webPageRatesBasedOnKRW);
    String keyDate = 'date';
    String keyKRW = 'krw';

    Map<String, dynamic> fullMap = jsonDecode(page2.body);

    _date = fullMap[keyDate];
    _setValueTOPreference(KeyOfPreference.date, _date);

    _rates.clear();
    _rates.addAll(fullMap[keyKRW]);

    _setValueTOPreference(KeyOfPreference.rates,
        tempKeys.map((e) => _rates[e].toString()).toList());

    if (filter.contains(_selectedCurrency) ||
        !_currencies.keys.contains(_selectedCurrency)) {
      _selectedCurrency = _currencies.keys
          .where(
            (element) => !filter.contains(element),
          )
          .toList()[0];
    }

    notifyListeners();
  }

  void _setValueTOPreference(KeyOfPreference key, dynamic data) {
    SharedPreferences.getInstance().then(
      (value) {
        if (key == KeyOfPreference.money) {
          value.setDouble(key.name, data as double);
        } else if (key == KeyOfPreference.filter ||
            key == KeyOfPreference.currencies ||
            key == KeyOfPreference.fullNames ||
            key == KeyOfPreference.rates ||
            key == KeyOfPreference.orderedList) {
          value.setStringList(key.name, data as List<String>);
        } else {
          value.setString(key.name, data);
        }
      },
    );
  }
}
