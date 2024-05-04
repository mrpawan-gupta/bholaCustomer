import "package:customer/utils/localization/app_language_keys.dart";

class EnLanguage {
  factory EnLanguage() {
    return _singleton;
  }

  EnLanguage._internal();
  static final EnLanguage _singleton = EnLanguage._internal();

  Map<String, String> appEnINLanguage = <String, String>{
    AppLanguageKeys().strHelloWorld: "Hello World",
  };
}
