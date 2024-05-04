import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/localization/app_translations.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";

class ChangeLanguageController extends GetxController {
  Rx<Locale> rxSelectedLocal = AppTranslations().supportedLocales()[0].obs;
  RxInt rxAllAppLocalsLength = AppTranslations().supportedLocales().length.obs;

  @override
  void onInit() {
    super.onInit();

    getUserLangFromStorage();
  }

  void updateLocale(Locale value) {
    rxSelectedLocal(value);
    return;
  }

  Locale getItemFromIndex(int index) {
    return AppTranslations().supportedLocales()[index];
  }

  String getDisplayString(Locale locale) {
    return AppTranslations().localeToDisplayString(locale: locale);
  }

  void getUserLangFromStorage() {
    final Locale value = AppStorageService().getUserLangFromStorage();
    updateLocale(value);
    return;
  }

  Future<void> setUserLangToStorage() async {
    final String value = AppTranslations().localeToUnderscoreString(
      locale: rxSelectedLocal.value,
    );
    await AppStorageService().setUserLang(value);
    return Future<void>.value();
  }
}
