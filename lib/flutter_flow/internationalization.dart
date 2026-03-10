import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'vi', 'hi'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? viText = '',
    String? hiText = '',
  }) =>
      [enText, viText, hiText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // SplashScreen
  {
    '3pndpmm6': {
      'en': 'Make a commitment to managing your diabetes ',
      'hi': 'अपने मधुमेह को नियंत्रित करने के लिए प्रतिबद्ध रहें।',
      'vi': 'Hãy cam kết kiểm soát bệnh tiểu đường của bạn.',
    },
    'zjofth0v': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // onBoarding
  {
    'c66ff00y': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // SplashScreenCopy
  {
    '8kgornvz': {
      'en': 'Make a commitment to managing your diabetes ',
      'hi': 'अपने मधुमेह को नियंत्रित करने के लिए प्रतिबद्ध रहें।',
      'vi': 'Hãy cam kết kiểm soát bệnh tiểu đường của bạn.',
    },
    'iewjyv96': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // PrimaryGoalPage
  {
    '0clwk2zl': {
      'en': '0',
      'hi': '0',
      'vi': '0',
    },
    '5ftogwhi': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // LogIn
  {
    'feux0xjh': {
      'en': 'Join glucoPal',
      'hi': 'ग्लूकोपाल से जुड़ें',
      'vi': 'Hãy tham gia GlucoPal',
    },
    '3ruqx7uw': {
      'en': 'Full Name',
      'hi': 'पूरा नाम',
      'vi': 'Họ và tên đầy đủ',
    },
    '19z0lruv': {
      'en': 'Enter your full name',
      'hi': 'अपना पूरा नाम भरें',
      'vi': 'Nhập đầy đủ họ của bạn',
    },
    '7bdr8u78': {
      'en': 'Sign up with Google',
      'hi': 'Google के साथ साइन अप करें',
      'vi': 'Đăng ký bằng Google',
    },
    'k7xjshgr': {
      'en': 'Sign up with Apple',
      'hi': 'Apple के साथ साइन अप करें',
      'vi': 'Đăng ký bằng Apple',
    },
    's0n7cx0u': {
      'en': 'By continuing, you agree to our  ',
      'hi': 'जारी रखने पर, आप हमारी शर्तों से सहमत होते हैं।',
      'vi': 'Bằng cách tiếp tục, bạn đồng ý với các điều khoản của chúng tôi.',
    },
    'q2xgubv7': {
      'en': 'Terms of Service ',
      'hi': 'सेवा की शर्तें',
      'vi': 'Điều khoản dịch vụ',
    },
    'xmwjsji3': {
      'en': ' and ',
      'hi': 'और',
      'vi': 'Và',
    },
    'mb1whdtt': {
      'en': '\nPrivacy Policy.',
      'hi': 'गोपनीयता नीति।',
      'vi': 'Chính sách bảo mật.',
    },
    'm4n964s2': {
      'en': 'Enter your full name is required',
      'hi': 'अपना पूरा नाम दर्ज करना आवश्यक है।',
      'vi': 'Vui lòng nhập đầy đủ họ tên của bạn (bắt buộc).',
    },
    '2c15hif4': {
      'en': 'Please choose an option from the dropdown',
      'hi': 'कृपया ड्रॉपडाउन से एक विकल्प चुनें',
      'vi': 'Vui lòng chọn một tùy chọn từ menu thả xuống.',
    },
    'opbonq0r': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // HomePage
  {
    'vwkf43km': {
      'en': 'WELCOME BACK,',
      'hi': '',
      'vi': '',
    },
    '1vhoqbvj': {
      'en': 'Hi, Alex',
      'hi': '',
      'vi': '',
    },
    'o5a70w18': {
      'en': 'CURRENT GLUCOSE',
      'hi': '',
      'vi': '',
    },
    'q3z7sulw': {
      'en': '108',
      'hi': '',
      'vi': '',
    },
    'fv62ebg9': {
      'en': 'MG/DL',
      'hi': '',
      'vi': '',
    },
    'hiozrqxf': {
      'en': 'STABLE',
      'hi': '',
      'vi': '',
    },
    'hw9qxa5r': {
      'en': 'Daily Health\nScore',
      'hi': '',
      'vi': '',
    },
    'c99cejl4': {
      'en': 'Your metabolic health\nis ',
      'hi': '',
      'vi': '',
    },
    '4qanyb6h': {
      'en': '94% ',
      'hi': '',
      'vi': '',
    },
    'q8ukc0do': {
      'en': 'better than\nlast week.',
      'hi': '',
      'vi': '',
    },
    'kib2hvim': {
      'en': 'EXCELLENT',
      'hi': '',
      'vi': '',
    },
    'tf576qwt': {
      'en': 'BLOOD \nPRESSURE',
      'hi': '',
      'vi': '',
    },
    'w0osj4ul': {
      'en': '118/78 ',
      'hi': '',
      'vi': '',
    },
    'dnfz1wf2': {
      'en': 'mmHg',
      'hi': '',
      'vi': '',
    },
    'mbabm4vu': {
      'en': 'HEART RATE',
      'hi': '',
      'vi': '',
    },
    'klkpnkl5': {
      'en': '64',
      'hi': '',
      'vi': '',
    },
    'n552cl8y': {
      'en': ' bpm',
      'hi': '',
      'vi': '',
    },
    'fqw73r1j': {
      'en': 'WEIGHT',
      'hi': '',
      'vi': '',
    },
    'ryova8xm': {
      'en': '76.4 ',
      'hi': '',
      'vi': '',
    },
    'w3n0fn44': {
      'en': 'kg',
      'hi': '',
      'vi': '',
    },
    'u5vji6um': {
      'en': 'STEPS',
      'hi': '',
      'vi': '',
    },
    'ep04jq6y': {
      'en': '8.4K ',
      'hi': '',
      'vi': '',
    },
    '1f58lok4': {
      'en': 'Sync',
      'hi': '',
      'vi': '',
    },
    'uxmeph3t': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // FoodPage
  {
    'b7wgpkgi': {
      'en': 'Page Title',
      'hi': 'पृष्ठ शीर्षक',
      'vi': 'Tiêu đề trang',
    },
    'jphzl7uh': {
      'en': 'Home',
      'hi': 'घर',
      'vi': 'Trang chủ',
    },
  },
  // nav
  {
    '9qm68qe1': {
      'en': 'HOME',
      'hi': 'घर',
      'vi': 'TRANG CHỦ',
    },
    '7ntpvgft': {
      'en': 'FOOD',
      'hi': 'खाना',
      'vi': 'ĐỒ ĂN',
    },
    'qju0u15a': {
      'en': 'HEALTH',
      'hi': 'स्वास्थ्य',
      'vi': 'SỨC KHỎE',
    },
    '7ek940ta': {
      'en': 'REPORTS',
      'hi': 'रिपोर्टों',
      'vi': 'BÁO CÁO',
    },
    'aat8aa9m': {
      'en': 'PROFILE',
      'hi': 'प्रोफ़ाइल',
      'vi': 'HỒ SƠ',
    },
  },
  // Logout
  {
    'lz5qihxi': {
      'en': 'Sign out',
      'hi': 'साइन आउट',
      'vi': 'Đăng xuất',
    },
    'ekoxnjfw': {
      'en':
          'Staying signed in will help you track your health regularly. Are you want to sign out?',
      'hi':
          'लॉग इन रहने से आपको नियमित रूप से अपने स्वास्थ्य पर नज़र रखने में मदद मिलेगी। क्या आप लॉग आउट करना चाहते हैं?',
      'vi':
          'Việc duy trì trạng thái đăng nhập sẽ giúp bạn theo dõi sức khỏe thường xuyên. Bạn có muốn đăng xuất không?',
    },
    'xse1zzof': {
      'en': 'Cancel',
      'hi': 'रद्द करना',
      'vi': 'Hủy bỏ',
    },
    'qzjapw40': {
      'en': 'Yes',
      'hi': 'हाँ',
      'vi': 'Đúng',
    },
  },
  // PrimaryGoal2
  {
    '67t46fe0': {
      'en':
          'Age and gender both affect your cardiovascular health. this information help us tailor your results to you.',
      'hi':
          'उम्र और लिंग दोनों ही आपके हृदय स्वास्थ्य को प्रभावित करते हैं। यह जानकारी हमें आपके लिए उपयुक्त परिणाम तैयार करने में मदद करती है।',
      'vi':
          'Tuổi tác và giới tính đều ảnh hưởng đến sức khỏe tim mạch của bạn. Thông tin này giúp chúng tôi điều chỉnh kết quả phù hợp với từng cá nhân.',
    },
  },
  // PrimaryGoal3
  {
    'me9cvzpt': {
      'en':
          'Age and gender both affect your cardiovascular health. this information help us tailor your results to you.',
      'hi':
          'उम्र और लिंग दोनों ही आपके हृदय स्वास्थ्य को प्रभावित करते हैं। यह जानकारी हमें आपके लिए उपयुक्त परिणाम तैयार करने में मदद करती है।',
      'vi':
          'Tuổi tác và giới tính đều ảnh hưởng đến sức khỏe tim mạch của bạn. Thông tin này giúp chúng tôi điều chỉnh kết quả phù hợp với từng cá nhân.',
    },
  },
  // PrimaryGoal4
  {
    'z2iuf1pn': {
      'en': 'SAFE CHOICE',
      'hi': 'सुरक्षित विकल्प',
      'vi': 'LỰA CHỌN AN TOÀN',
    },
    '1370wpkf': {
      'en': 'HIGH FIBER',
      'hi': 'उच्च फाइबर',
      'vi': 'GIÀU CHẤT XƠ',
    },
    '7vkkinwl': {
      'en': 'LOW GLYCEMIC',
      'hi': 'कम ग्लाइसेमिक',
      'vi': 'CHỈ SỐ ĐƯỜNG HUYẾT THẤP',
    },
    '7y9gm5i2': {
      'en':
          'Age and gender both affect your cardiovascular health. this information help us tailor your results to you.',
      'hi':
          'उम्र और लिंग दोनों ही आपके हृदय स्वास्थ्य को प्रभावित करते हैं। यह जानकारी हमें आपके लिए उपयुक्त परिणाम तैयार करने में मदद करती है।',
      'vi':
          'Tuổi tác và giới tính đều ảnh hưởng đến sức khỏe tim mạch của bạn. Thông tin này giúp chúng tôi điều chỉnh kết quả phù hợp với từng cá nhân.',
    },
  },
  // Miscellaneous
  {
    '38tjlt8g': {
      'en': 'Allow camera to snap food and see nutrition info.',
      'hi': 'कैमरे को भोजन की तस्वीर लेने दें और पोषण संबंधी जानकारी देखें।',
      'vi': 'Cho phép camera chụp ảnh thức ăn và xem thông tin dinh dưỡng.',
    },
    'twufhawl': {
      'en': 'This app does not record audio. Microphone access is not used.',
      'hi':
          'यह ऐप ऑडियो रिकॉर्ड नहीं करता है। इसमें माइक्रोफ़ोन का उपयोग नहीं किया जाता है।',
      'vi':
          'Ứng dụng này không ghi âm. Quyền truy cập micro không được sử dụng.',
    },
    '0rt1slcm': {
      'en': 'Allow gallery to snap or pick food and see nutrition info.',
      'hi':
          'गैलरी को भोजन की तस्वीर खींचने या चुनने और पोषण संबंधी जानकारी देखने की अनुमति दें।',
      'vi':
          'Cho phép chụp ảnh hoặc chọn thực phẩm và xem thông tin dinh dưỡng.',
    },
    '3w50pj4p': {
      'en':
          'Track your active calories burned during physical activities to monitor your energy expenditure.',
      'hi':
          'अपनी ऊर्जा खपत पर नज़र रखने के लिए शारीरिक गतिविधियों के दौरान खर्च की गई सक्रिय कैलोरी को ट्रैक करें।',
      'vi':
          'Theo dõi lượng calo tiêu hao trong các hoạt động thể chất để giám sát mức tiêu hao năng lượng của bạn.',
    },
    'e8adu1yv': {
      'en':
          'Monitor your blood glucose levels to help manage your diabetes and maintain healthy blood sugar.',
      'hi':
          'अपने मधुमेह को नियंत्रित करने और स्वस्थ रक्त शर्करा स्तर बनाए रखने के लिए अपने रक्त शर्करा के स्तर की निगरानी करें।',
      'vi':
          'Theo dõi lượng đường trong máu để giúp kiểm soát bệnh tiểu đường và duy trì lượng đường trong máu ở mức khỏe mạnh.',
    },
    'crjexk5s': {
      'en':
          'Monitor your systolic blood pressure to track your cardiovascular health.',
      'hi':
          'अपने हृदय संबंधी स्वास्थ्य पर नज़र रखने के लिए अपने सिस्टोलिक रक्तचाप की निगरानी करें।',
      'vi': 'Theo dõi huyết áp tâm thu để đánh giá sức khỏe tim mạch của bạn.',
    },
    'b1n14aww': {
      'en':
          'Track your body temperature to monitor your overall health and detect potential fever.',
      'hi':
          'अपने शरीर के तापमान पर नज़र रखें ताकि आप अपने समग्र स्वास्थ्य की निगरानी कर सकें और संभावित बुखार का पता लगा सकें।',
      'vi':
          'Theo dõi nhiệt độ cơ thể để giám sát sức khỏe tổng thể và phát hiện sớm nguy cơ sốt.',
    },
    'saw56dhy': {
      'en':
          'Monitor your heart rate to track your cardiovascular fitness and detect irregular patterns.',
      'hi':
          'अपनी हृदय गति पर नज़र रखें ताकि आप अपनी हृदय संबंधी फिटनेस का पता लगा सकें और अनियमित पैटर्न का पता लगा सकें।',
      'vi':
          'Theo dõi nhịp tim để đánh giá sức khỏe tim mạch và phát hiện các bất thường.',
    },
    'kqold3ci': {
      'en':
          'Track your resting calories burned to understand your basal metabolic rate.',
      'hi':
          'अपनी बेसल मेटाबोलिक दर को समझने के लिए, आराम करते समय खर्च होने वाली कैलोरी की मात्रा पर नज़र रखें।',
      'vi':
          'Theo dõi lượng calo tiêu hao khi nghỉ ngơi để hiểu rõ tỷ lệ trao đổi chất cơ bản của bạn.',
    },
    '1269zxl3': {
      'en':
          'Count your daily steps to track your physical activity and maintain an active lifestyle.',
      'hi':
          'अपनी शारीरिक गतिविधि पर नज़र रखने और सक्रिय जीवनशैली बनाए रखने के लिए प्रतिदिन अपने कदमों की गिनती करें।',
      'vi':
          'Hãy đếm số bước đi hàng ngày để theo dõi hoạt động thể chất và duy trì lối sống năng động.',
    },
    '4q8597ox': {
      'en':
          'Track the distance you walk and run to monitor your physical activity levels.',
      'hi':
          'अपनी शारीरिक गतिविधि के स्तर पर नज़र रखने के लिए, आप जितनी दूरी पैदल चलते हैं और दौड़ते हैं, उसे रिकॉर्ड करें।',
      'vi':
          'Theo dõi quãng đường bạn đi bộ và chạy để giám sát mức độ hoạt động thể chất của mình.',
    },
    'dc2tm5ne': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'np5s895w': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    '3l12ehq6': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'xdq9g4a6': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'pqgfdd1x': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'nwlf4ult': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'suiqtgkf': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'k1q0kbyu': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'rb2m8i6s': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'vn8bajzo': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'wigkemvf': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'fv40eog4': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'pp3uvxhn': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    '5dkdeymq': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'hbrgqfvp': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'xulfqhov': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'eidjprm8': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    '3ltokdp5': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    '17yqqvuv': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'z20wtimn': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'ds43p4qh': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'refcgzol': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    '9uw68nd2': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    'rm06n84v': {
      'en': '',
      'hi': '',
      'vi': '',
    },
    '1iusovt9': {
      'en': '',
      'hi': '',
      'vi': '',
    },
  },
].reduce((a, b) => a..addAll(b));
