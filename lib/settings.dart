import 'data/exchange_rate.dart';

enum Language { english, korean }

class DefaultSettings {
  static const String sharedPreferencesExchangeRateKey = 'data';
  static const String sharedPreferencesSettingsKey = 'settings';
  static const String webPageCurrencies =
      'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.min.json';
  static const String webPageRatesBasedOnBTC =
      'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/btc.json';
  static const String webKeyDate = 'date';
  static const String webKeyBTC = 'btc';

  static const Map<String, Map<String, String>> defaultCurrencies = {
    'english': {
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
    },
    'korean': {
      '1inch': '1인치네트워크',
      'aave': '에이브 코인',
      'ada': '카르다노 에이다 코인',
      'aed': '아랍에미리트 디르함',
      'afn': '아프가니스탄 아프가니',
      'algo': '알고랜드 코인',
      'all': '알바니아 렉',
      'amd': '아르메니아 드람',
      'amp': '시네로 코인',
      'ang': '네덜란드령 안틸레스 휠던',
      'aoa': '앙골라 콴자',
      'ar': '알위브 코인',
      'ars': '아르헨티나 페소',
      'atom': '아토믹 코인',
      'aud': '오스트레일리아 달러',
      'avax': '아발란체 코인',
      'awg': '아루바 플로린',
      'axs': '액시인피니티 코인',
      'azn': '아제르바이잔 마나트',
      'bam': '보스니아 헤르체고비나 마르크',
      'bat': '베이직어텐션토큰',
      'bbd': '바베이도스 달러',
      'bch': '비트코인캐시',
      'bdt': '방글라데시 타카',
      'bgn': '불가리아 레프',
      'bhd': '바레인 디나르',
      'bif': '부룬디 프랑',
      'bmd': '버뮤다 달러',
      'bnb': '바이넌스 코인',
      'bnd': '브루나이 달러',
      'bob': '볼리비아 볼리비아노',
      'brl': '브라질 헤알',
      'bsd': '바하마 달러',
      'bsv': '비트코인에스브이',
      'btc': '비트코인',
      'btcb': '비트코인 BEP2',
      'btg': '비트코인 골드',
      'btn': '부탄 눌트럼',
      'busd': '바이낸스 USD',
      'bwp': '보츠와나 풀라',
      'byn': '벨라루스 루블',
      'byr': '구 벨라루스 루블',
      'bzd': '벨리즈 달러',
      'cad': '캐나다 달러',
      'cake': '팬케이크스왑',
      'cdf': '콩고 프랑',
      'celo': '셀로',
      'chf': '스위스 프랑',
      'chz': '칠리즈',
      'clf': '칠레 우니다드 데 포멘토',
      'clp': '칠레 페소',
      'cny': '중국 위안',
      'comp': '컴파운드 코인',
      'cop': '콜롬비아 페소',
      'crc': '코스타리카 콜론',
      'cro': 'Crypto.com Chain Token',
      'crv': 'Cravy CRV',
      'cuc': '쿠바 페소 CUC',
      'cup': '쿠바 페소',
      'cve': '카보베르데 이스쿠두',
      'cvx': '컨벡스 파이낸스',
      'czk': '체코 코루나',
      'dai': '다이 코인',
      'dash': '대시 코인',
      'dcr': '디크레드 코인',
      'dfi': '디파이스타터 코인',
      'djf': '지부티 프랑',
      'dkk': '덴마크 크로네',
      'doge': '도지 코인',
      'dop': '도미니카 페소',
      'dot': '닷코인',
      'dzd': '알제리 디나르',
      'egld': '엘론드',
      'egp': '이집트 파운드',
      'enj': '엔진 코인',
      'eos': '이오스 코인',
      'ern': '에리트레아 낙파',
      'etb': '에티오피아 비르',
      'etc': '이더리움 클래식',
      'eth': '이더리움',
      'eur': '유럽 유로',
      'fei': '페이 토큰',
      'fil': '파일 코인',
      'fjd': '피지 달러',
      'fkp': '포클랜드 제도 파운드',
      'flow': '플로우 코인',
      'frax': '프락스 코인',
      'ftm': '팬텀 코인',
      'ftt': '파마트러스트',
      'gala': '갈라 코인',
      'gbp': '영국 파운드',
      'gel': '조지아 라리',
      'ggp': 'GGPro 코인',
      'ghs': '가나 세디',
      'gip': '지브랄타 파운드',
      'gmd': '감비아 달라시',
      'gnf': '기니 프랑',
      'gno': '노시스 코인',
      'grt': 'Golden Ratio Token',
      'gt': 'GateToken',
      'gtq': '과테말라 케찰',
      'gyd': '가이아나 달러',
      'hbar': '헤데라 코인',
      'hkd': '홍콩 달러',
      'hnl': '온두라스 렘피라',
      'hnt': '헬륨 코인',
      'hot': 'Hydro Protocol',
      'hrk': '크로아티아 쿠나',
      'ht': '후오비토큰',
      'htg': '아이티 구르드',
      'huf': '헝가리 포린트',
      'icp': 'Internet Computer',
      'idr': '인도네시아 루피아',
      'ils': '이스라엘 신 셰켈',
      'imp': 'CoinIMP',
      'inj': 'Injective',
      'inr': '인도 루피',
      'iqd': '이라크 디나르',
      'irr': '이란 리알',
      'isk': '아이슬란드 크로나',
      'jep': '저지 섬 파운드',
      'jmd': '자메이카 달러',
      'jod': '요르단 디나르',
      'jpy': '일본 엔',
      'kava': '카바 코인',
      'kcs': '쿠코인',
      'kda': '카데나 코인',
      'kes': '케냐 실링',
      'kgs': '키르기스스탄 솜',
      'khr': '캄보디아 리엘',
      'klay': '클레이튼',
      'kmf': '코모로 프랑',
      'knc': '카이버 네트워크',
      'kpw': '북한 원',
      'krw': '대한민국 원',
      'ksm': '쿠사마',
      'kwd': '쿠웨이트 디나르',
      'kyd': '케이맨 제도 달러',
      'kzt': '카자흐스탄 텡게',
      'lak': '라오스 킵',
      'lbp': '레바논 파운드',
      'leo': '레오코인',
      'link': '체인링크',
      'lkr': '스리랑카 루피',
      'lrc': '루프링',
      'lrd': '라이베리아 달러',
      'lsl': '레소토 로티',
      'ltc': '라이트코인',
      'ltl': '리투아니아 리타스',
      'luna': '루나 코인',
      'lvl': '라트비아 라츠',
      'lyd': '리비아 디나르',
      'mad': '모로코 디르함',
      'mana': '디센트럴랜드 코인',
      'matic': '폴리곤 코인',
      'mdl': '몰도바 레우',
      'mga': '몰도바 레우',
      'mina': '미나 코인',
      'miota': '아이오타 코인',
      'mkd': '마케도니아 데나르',
      'mkr': '메이커토큰',
      'mmk': '미얀마 캣',
      'mnt': '몽골 투그리크',
      'mop': '마카오 파타카',
      'mro': '모리타니 우기야',
      'mur': '모리셔스 루피',
      'mvr': '몰디브 루피야',
      'mwk': '말라위 콰차',
      'mxn': '멕시코 페소',
      'myr': '말레이시아 링깃',
      'mzn': '모잠비크 메티칼',
      'nad': '나미비아 달러',
      'near': '니어 프로토콜',
      'neo': '네오 코인',
      'nexo': '넥소 코인',
      'ngn': '나이지리아 나이라',
      'nio': '니카라과 코르도바',
      'nok': '노르웨이 크로네',
      'npr': '네팔 루피',
      'nzd': '뉴질랜드 달러',
      'okb': '오케이엑스 코인',
      'omr': '오만 리알',
      'one': 'Menlo One',
      'pab': '파나마 발보아',
      'paxg': '팍소스 골드',
      'pen': '페루 솔',
      'pgk': '파푸아 뉴기니 키나',
      'php': '필리핀 페소',
      'pkr': '파키스탄 루피',
      'pln': '폴란드 즈워티',
      'pyg': '파라과이 과라니',
      'qar': '카타르 리알',
      'qnt': '퀀트 코인',
      'qtum': '퀀텀 코인',
      'ron': '루마니아 레우',
      'rsd': '세르비아 디나르',
      'rub': '러시아 루블',
      'rune': '토르체인 코인',
      'rwf': '르완다 프랑',
      'sand': '비치 코인',
      'sar': '사우디아라비아 리얄',
      'sbd': '솔로몬 제도 달러',
      'scr': '세이셸 루피',
      'sdg': '수단 파운드',
      'sek': '스웨덴 크로나',
      'sgd': '싱가포르 달러',
      'shib': '시바이누 코인',
      'shp': '세인트헬레나 파운드',
      'sll': '시에라리온 레온',
      'sol': '솔라 코인',
      'sos': '소말리아 실링',
      'srd': '수리남 달러',
      'std': '상투메 프린시페 도브라 (pre-2018)',
      'stx': '스톡스 코인',
      'svc': '엘살바도르 콜론',
      'syp': '시리아 파운드',
      'szl': '스와질란드 릴랑게니',
      'thb': '타이 바트',
      'theta': '쎼타토큰 코인',
      'tjs': '타지키스탄 소모니',
      'tmt': '투르크메니스탄 마나트',
      'tnd': '튀니지 디나르',
      'top': '통가 파앙가',
      'trx': '트론코인',
      'try': '터키 리라',
      'ttd': '트리니다드 토바고 달러',
      'ttt': 'TAP 프로젝트',
      'tusd': 'True USD 코인',
      'twd': '신 타이완 달러',
      'tzs': '탄자니아 실링',
      'uah': '우크라이나 흐리브냐',
      'ugx': '우간다 실링',
      'uni': '유니버스 코인',
      'usd': '미국 달러',
      'usdc': 'USD 코인',
      'usdp': 'USDP Stablecoin',
      'usdt': '테더 코인',
      'uyu': '우루과이 페소',
      'uzs': '우즈베키스탄 솜',
      'vet': '비체인 코인',
      'vnd': '베트남 동',
      'vuv': '바누아투 바투',
      'waves': '웨이브 코인',
      'wbtc': '랩트비트코인',
      'wemix': '위믹스 코인',
      'wst': '사모아 탈라',
      'xaf': '중앙아프리카 CFA 프랑',
      'xag': '은값',
      'xau': '금트로이온스',
      'xcd': '동카리브 달러',
      'xdc': '엑스디시 네트워크 코인',
      'xdr': '특별인출권',
      'xec': '이터널 코인',
      'xem': '넴 코인',
      'xlm': '스텔라루멘 코인',
      'xmr': '모네로 코인',
      'xof': '서아프리카 CFA 프랑',
      'xpf': 'CFP 프랑',
      'xrp': '리플코인',
      'xtz': '테조스 코인',
      'yer': '예멘 리알',
      'zar': '남아프리카 공화국 랜드',
      'zec': '지캐시 코인',
      'zil': '질리카 코인',
      'zmk': '잠비아 콰차(ZMK)',
      'zmw': '잠비아 콰차(ZMW)',
      'zwl': '짐바브웨 달러'
    },
  };
  static const Map<String, dynamic> defaultRates = {
    "1inch": 33991.537894,
    "aave": 234.800741,
    "ada": 53576.821414,
    "aed": 70729.394532,
    "afn": 1684816.811341,
    "algo": 60864.153715,
    "all": 2285269.105683,
    "amd": 7778876.097609,
    "amp": 3941585.966823,
    "ang": 34686.691191,
    "aoa": 8624968.826072,
    "ar": 1904.676374,
    "ars": 2943120.069433,
    "atom": 1552.856035,
    "aud": 30498.157214,
    "avax": 1219.81746,
    "awg": 34709.908103,
    "axs": 1777.869411,
    "azn": 32752.755627,
    "bam": 38337.057542,
    "bat": 68093.504538,
    "bbd": 38859.604034,
    "bch": 177.60786,
    "bdt": 2036733.938564,
    "bgn": 38175.827903,
    "bhd": 7259.571011,
    "bif": 39514416.706429,
    "bmd": 19256.544104,
    "bnb": 70.759711,
    "bnd": 27357.996658,
    "bob": 132990.181257,
    "brl": 100927.313531,
    "bsd": 19245.570256,
    "bsv": 398.840459,
    "btc": 1,
    "btcb": 0.999944,
    "btg": 1081.609931,
    "btn": 1584118.562228,
    "busd": 19259.209105,
    "bwp": 257836.518105,
    "byn": 48803.62804,
    "byr": 377428151.702622,
    "bzd": 38794.932535,
    "cad": 26430.940876,
    "cake": 4346.314643,
    "cdf": 39379623.885247,
    "celo": 26119.014116,
    "chf": 19144.794409,
    "chz": 106113.253619,
    "clf": 679.206949,
    "clp": 18741424.87558,
    "cny": 138687.58019,
    "comp": 364.658349,
    "cop": 91701753.851215,
    "crc": 11856434.466566,
    "cro": 178526.522763,
    "crv": 21203.079232,
    "cuc": 19256.544104,
    "cup": 510298.272295,
    "cve": 2169730.856436,
    "cvx": 3730.581368,
    "czk": 479557.147853,
    "dai": 19259.341515,
    "dash": 474.607605,
    "dcr": 741.246508,
    "dfi": 1101545.508882,
    "djf": 3422275.500273,
    "dkk": 145261.031899,
    "doge": 323074.270284,
    "dop": 1035043.399809,
    "dot": 3142.259773,
    "dzd": 2700028.535908,
    "egld": 341.936184,
    "egp": 378522.966232,
    "enj": 44513.158365,
    "eos": 18424.094756,
    "ern": 288848.083447,
    "etb": 1016769.190779,
    "etc": 827.710715,
    "eth": 14.761253,
    "eur": 19526.418737,
    "fei": 19496.240934,
    "fil": 3775.928402,
    "fjd": 44535.562959,
    "fkp": 16994.36944,
    "flow": 12717.201,
    "frax": 19338.658278,
    "ftm": 92651.247699,
    "ftt": 820.847456,
    "gala": 543618.653761,
    "gbp": 16977.518141,
    "gel": 53051.7957,
    "ggp": 16994.36944,
    "ghs": 226264.759336,
    "gip": 16994.36944,
    "gmd": 1102444.496741,
    "gnf": 167628162.469489,
    "gno": 175.135429,
    "grt": 232546.56045,
    "gt": 4388.819018,
    "gtq": 151092.831172,
    "gyd": 4026495.397584,
    "hbar": 312272.849985,
    "hkd": 151157.092616,
    "hnl": 476978.78189,
    "hnt": 4343.834824,
    "hot": 9843150.88908,
    "hrk": 147122.954032,
    "ht": 2523.950777,
    "htg": 2386516.359585,
    "huf": 8072437.077482,
    "icp": 3913.319469,
    "idr": 298101804.791736,
    "ils": 67829.526085,
    "imp": 16994.36944,
    "inj": 9338.829475,
    "inr": 1584559.878817,
    "iqd": 28114545.994753,
    "irr": 815514409.598813,
    "isk": 2762927.953685,
    "jep": 16994.36944,
    "jmd": 2944655.295053,
    "jod": 13652.540032,
    "jpy": 2872584.494133,
    "kava": 13725.00963,
    "kcs": 1993.259032,
    "kda": 14960.263315,
    "kes": 2331891.886593,
    "kgs": 1581747.4692,
    "khr": 79818348.050135,
    "klay": 133779.261065,
    "kmf": 9633088.613934,
    "knc": 20911.560904,
    "kpw": 17330881.863058,
    "krw": 27352757.661444,
    "ksm": 516.05619,
    "kwd": 5971.061691,
    "kyd": 16040.171936,
    "kzt": 9072611.194558,
    "lak": 325531784.596733,
    "lbp": 29108618.516028,
    "leo": 4485.604055,
    "link": 2727.032274,
    "lkr": 7034434.273176,
    "lrc": 75071.854796,
    "lrd": 2960690.468226,
    "lsl": 347000.257827,
    "ltc": 372.624006,
    "ltl": 56859.544986,
    "luna": 7732.631679,
    "lvl": 11648.075043,
    "lyd": 97058.641819,
    "mad": 211292.311504,
    "mana": 30615.625132,
    "matic": 22382.55224,
    "mdl": 372884.732348,
    "mga": 81455159.70775,
    "mina": 35369.837584,
    "miota": 77008.432164,
    "mkd": 1203088.208566,
    "mkr": 17.571782,
    "mmk": 40416713.497528,
    "mnt": 64697639.244259,
    "mop": 155599.157615,
    "mro": 6874580.875185,
    "mur": 871462.076532,
    "mvr": 297802.098496,
    "mwk": 19728341.452548,
    "mxn": 385479.877752,
    "myr": 90851.876727,
    "mzn": 1229150.353971,
    "nad": 346813.038524,
    "near": 6575.999941,
    "neo": 2442.580835,
    "nexo": 21858.341283,
    "ngn": 8402592.460131,
    "nio": 693236.935049,
    "nok": 203032.851169,
    "npr": 2534557.621563,
    "nzd": 33799.020196,
    "okb": 1154.999842,
    "omr": 7414.454564,
    "one": 35091964.844128,
    "pab": 19245.570256,
    "paxg": 11.705846,
    "pen": 76592.943761,
    "pgk": 67879.806613,
    "php": 1132673.755642,
    "pkr": 4231624.780806,
    "pln": 93431.277589,
    "pyg": 137903988.501439,
    "qar": 70117.86615,
    "qnt": 106.174092,
    "qtum": 7198.344829,
    "ron": 96338.487969,
    "rsd": 2289983.642328,
    "rub": 1184249.510297,
    "rune": 12890.584817,
    "rwf": 20142339.118126,
    "sand": 25019.764321,
    "sar": 72330.17034,
    "sbd": 157198.85947,
    "scr": 255637.98004,
    "sdg": 10947422.83296,
    "sek": 213445.157749,
    "sgd": 27337.259601,
    "shib": 1902479736.67147,
    "shp": 26524.003788,
    "sll": 322547010.751324,
    "sol": 641.361927,
    "sos": 10947365.620553,
    "srd": 547087.880678,
    "std": 398571465.091411,
    "stx": 5173072.53742,
    "svc": 168407.726776,
    "syp": 48382630.953732,
    "szl": 346998.71524,
    "thb": 732557.889778,
    "theta": 19170.595406,
    "tjs": 195054.571264,
    "tmt": 67397.875073,
    "tnd": 62756.406286,
    "top": 47323.896502,
    "trx": 308612.383373,
    "try": 357905.840797,
    "ttd": 130475.47142,
    "ttt": 1016225.626846,
    "tusd": 19263.429764,
    "twd": 616748.691945,
    "tzs": 44906254.679018,
    "uah": 710495.477408,
    "ugx": 73621743.178856,
    "uni": 499405605.345464,
    "usd": 19256.544104,
    "usdc": 19257.867344,
    "usdp": 19281.342023,
    "usdt": 19255.199111,
    "uyu": 793421.287874,
    "uzs": 214517843.007125,
    "vet": 841967.23234,
    "vnd": 470629797.318898,
    "vuv": 2409953.666152,
    "waves": 5714.412326,
    "wbtc": 0.999794,
    "wemix": 9673.630437,
    "wst": 54783.632831,
    "xaf": 12857103.285461,
    "xag": 1025.820408,
    "xau": 11.657272,
    "xcd": 52041.752638,
    "xdc": 611787.765171,
    "xdr": 15076.718909,
    "xec": 515322658.686083,
    "xem": 497655.431606,
    "xlm": 171655.364304,
    "xmr": 131.783877,
    "xof": 12950187.695747,
    "xpf": 2342076.671342,
    "xrp": 41601.908232,
    "xtz": 14062.921336,
    "yer": 4818945.636654,
    "zar": 348139.917256,
    "zec": 368.939068,
    "zil": 625424.538284,
    "zmk": 173331924.905767,
    "zmw": 306769.020509,
    "zwl": 6200597.496697
  };
  static final List<String> defaultOrderedList = [
    'krw',
    'usd',
    'eur',
    'jpy',
    'cny',
    'hkd',
    'twd',
    'gbp',
    'cad',
    'btc'
  ];
  static const double defaultMoney = 10000.0;
  static const String defaultDate = '2022.10.19';
  static const defaultLanguage = Language.korean;
  static const defaultAutoUpdateAtStarting = true;

  static final getDefaultExchangeRateJson = {
    KeyOfPreference.currencies.name: defaultCurrencies,
    KeyOfPreference.rates.name: defaultRates,
    KeyOfPreference.orderedList.name: defaultOrderedList,
    KeyOfPreference.date.name: defaultDate,
  };

  static final getDefaultSettingsJson = {
    KeyOfPreference.money.name: defaultMoney,
    KeyOfPreference.language.name: defaultLanguage.name,
    KeyOfPreference.autoUpdateAtStarting.name: defaultAutoUpdateAtStarting,
  };
}

class Settings {
  Settings(
      {required this.money,
      required this.language,
      required this.autoUpdateAtStarting});
  late double money;
  late Language language;
  late bool autoUpdateAtStarting;

  factory Settings.fromJson(Map<String, dynamic> json) {
    double money =
        json[KeyOfPreference.money.name] ?? DefaultSettings.defaultMoney;
    Language language = DefaultSettings.defaultLanguage;
    try {
      language = Language.values.byName(json[KeyOfPreference.language.name]);
    } on Exception catch (e) {
      // TODO
    }

    bool autoUpdateAtStarting = json[KeyOfPreference.autoUpdateAtStarting] ??
        DefaultSettings.defaultAutoUpdateAtStarting;
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
