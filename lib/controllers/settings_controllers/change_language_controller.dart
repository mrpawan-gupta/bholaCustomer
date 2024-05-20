import "dart:ui";

import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/localization/app_translations.dart";
import "package:get/get.dart";

class ChangeLanguageController extends GetxController {
  Rx<Locale> rxSelectedLocal = AppTranslations().supportedLocales()[0].obs;
  RxInt rxAllAppLocalsLength = AppTranslations().supportedLocales().length.obs;
  RxList<Locale> rxAllAppLocalsList = AppTranslations().supportedLocales().obs;

  @override
  void onInit() {
    super.onInit();

    getUserLangFromStorage();
  }

  void getUserLangFromStorage() {
    final Locale value = AppStorageService().getUserLangFromStorage();
    updateLocale(value);
    return;
  }

  void updateLocale(Locale value) {
    rxSelectedLocal(value);
    return;
  }

  Locale getItemFromIndex(int index) {
    return AppTranslations().supportedLocales()[index];
  }

  String getDisplayStringOwnLanguage(Locale locale) {
    return AppTranslations().localeToDisplayStringOwnLanguage(locale: locale);
  }

  Future<void> setUserLangToStorage() async {
    final String value = AppTranslations().localeToUnderscoreString(
      locale: rxSelectedLocal.value,
    );
    await AppStorageService().setUserLang(value);
    return Future<void>.value();
  }
}
