class AppLanguageKeys {
  factory AppLanguageKeys() {
    return _singleton;
  }

  AppLanguageKeys._internal();
  static final AppLanguageKeys _singleton = AppLanguageKeys._internal();

  final String strHelloWorld = "strHelloWorld";
}
