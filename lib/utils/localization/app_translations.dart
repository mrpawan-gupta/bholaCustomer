import "package:customer/utils/localization/app_en_in_language.dart";
import "package:customer/utils/localization/app_hi_in_language.dart";
import "package:customer/utils/localization/app_mr_in_language.dart";
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
      localeToUnderscoreString(locale: locale[2]): MrLanguage().appMrINLanguage,
    };
  }

  List<Locale> supportedLocales() {
    const List<Locale> supportedLocales = <Locale>[
      Locale("en", "IN"),
      Locale("hi", "IN"),
      Locale("mr", "IN"),
    ];
    return supportedLocales;
  }

  String localeToUnderscoreString({required Locale locale}) {
    final String languageCode = locale.languageCode;
    final String countryCode = locale.countryCode ?? "";
    return "${languageCode}_$countryCode";
  }

  String localeToDashString({required Locale locale}) {
    final String languageCode = locale.languageCode;
    final String countryCode = locale.countryCode ?? "";
    return "$languageCode-$countryCode";
  }

  Locale underscoreStringToLocale({required String locale}) {
    final List<String> tempList = locale.split("_");
    final String languageCode = tempList[0];
    final String countryCode = tempList[1];
    return Locale(languageCode, countryCode);
  }

  Locale dashStringToLocale({required String locale}) {
    final List<String> tempList = locale.split("-");
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
      case "mr_IN":
        value = "Marathi";
        break;
      default:
        break;
    }
    return value;
  }

  String localeToDisplayStringOwnLanguage({required Locale locale}) {
    String value = "";
    final String string = localeToUnderscoreString(locale: locale);
    switch (string) {
      case "en_IN":
        value = "English";
        break;
      case "hi_IN":
        value = "हिंदी";
        break;
      case "mr_IN":
        value = "मराठी";
        break;
      default:
        break;
    }
    return value;
  }
}
