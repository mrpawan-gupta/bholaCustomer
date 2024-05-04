import "package:customer/utils/localization/app_language_keys.dart";

class HiLanguage {
  factory HiLanguage() {
    return _singleton;
  }

  HiLanguage._internal();
  static final HiLanguage _singleton = HiLanguage._internal();

  Map<String, String> appHiINLanguage = <String, String>{
    AppLanguageKeys().strHelloWorld: "हैलो वर्ल्ड",
  };
}
