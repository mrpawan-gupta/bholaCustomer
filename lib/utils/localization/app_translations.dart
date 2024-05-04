import "package:customer/utils/localization/app_en_in_language.dart";
import "package:customer/utils/localization/app_hi_in_language.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";

class AppTranslations extends Translations {
  factory AppTranslations() {
    return _singleton;
  }

  AppTranslations._internal();
  static final AppTranslations _singleton = AppTranslations._internal();

  @override
  Map<String, Map<String, String>> get keys {
    final List<Locale> locale = supportedLocales();
    return <String, Map<String, String>>{
      localeToUnderscoreString(locale: locale[0]): EnLanguage().appEnINLanguage,
      localeToUnderscoreString(locale: locale[1]): HiLanguage().appHiINLanguage,
    };
  }

  List<Locale> supportedLocales() {
    const List<Locale> supportedLocales = <Locale>[
      Locale("en", "IN"),
      Locale("hi", "IN"),
    ];
    return supportedLocales;
  }

  String localeToUnderscoreString({required Locale locale}) {
    final String languageCode = locale.languageCode;
    final String countryCode = locale.countryCode ?? "";
    return "${languageCode}_$countryCode";
  }

  Locale underscoreStringToLocale({required String locale}) {
    final List<String> tempList = locale.split("_");
    final String languageCode = tempList[0];
    final String countryCode = tempList[1];
    return Locale(languageCode, countryCode);
  }

  String localeToDisplayString({required Locale locale}) {
    String value = "";
    final String string = localeToUnderscoreString(locale: locale);
    switch (string) {
      case "en_IN":
        value = "English";
        break;
      case "hi_IN":
        value = "Hindi";
        break;
      default:
        break;
    }
    return value;
  }
}
