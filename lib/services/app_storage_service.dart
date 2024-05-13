import "dart:convert";

import "package:customer/models/get_user_by_id.dart";
import "package:customer/models/verify_otp.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/localization/app_translations.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";
import "package:get_storage/get_storage.dart";

class AppStorageService extends GetxService {
  factory AppStorageService() {
    return _singleton;
  }

  AppStorageService._internal();
  static final AppStorageService _singleton = AppStorageService._internal();

  final GetStorage box = GetStorage();

  final String userDataKey = "userDataKey";
  final String userLangKey = "userLangKey";
  final String userAuthKey = "userAuthKey";
  final String userInfoKey = "userInfoKey";

  Future<void> init() async {
    final bool hasInitialized = await GetStorage.init();
    AppLogger().info(message: "GetStorage hasInitialized: $hasInitialized");
    return Future<void>.value();
  }

  Future<void> setUserData(Map<String, dynamic> userInfo) async {
    final String value = json.encode(userInfo);
    await box.write(userDataKey, value);
    await box.save();
    return Future<void>.value();
  }

  Map<String, dynamic> getUserData() {
    final String value = box.read(userDataKey) ?? "";
    return value.isEmpty ? <String, dynamic>{} : json.decode(value);
  }

  Future<void> setUserLang(String lang) async {
    await box.write(userLangKey, lang);
    await box.save();
    return Future<void>.value();
  }

  String getUserLang() {
    String value = box.read(userLangKey) ?? "";
    if (value.isEmpty) {
      final List<Locale> locale = AppTranslations().supportedLocales();
      value = AppTranslations().localeToUnderscoreString(locale: locale[0]);
    } else {}
    return value;
  }

  Locale getUserLangFromStorage() {
    return AppTranslations().underscoreStringToLocale(locale: getUserLang());
  }

  Future<void> setUserAuth(VerifyOTPModelData userAuth) async {
    final String value = json.encode(userAuth);
    await box.write(userAuthKey, value);
    await box.save();
    return Future<void>.value();
  }

  Map<String, dynamic> getUserAuth() {
    final String value = box.read(userAuthKey) ?? "";
    return value.isEmpty ? <String, dynamic>{} : json.decode(value);
  }

  VerifyOTPModelData getUserAuthModel() {
    final Map<String, dynamic> value = getUserAuth();
    final VerifyOTPModelData data = value.isEmpty
        ? VerifyOTPModelData()
        : VerifyOTPModelData.fromJson(value);
    return data;
  }

  Future<void> setUserInfo(GetUserByIdData userInfo) async {
    final String value = json.encode(userInfo);
    await box.write(userInfoKey, value);
    await box.save();
    return Future<void>.value();
  }

  Map<String, dynamic> getUserInfo() {
    final String value = box.read(userInfoKey) ?? "";
    return value.isEmpty ? <String, dynamic>{} : json.decode(value);
  }

  GetUserByIdData getUserInfoModel() {
    final Map<String, dynamic> value = getUserInfo();
    final GetUserByIdData data = value.isEmpty 
        ? GetUserByIdData() 
        : GetUserByIdData.fromJson(value);
    return data;
  }

  Future<void> erase() async {
    await box.erase();
    return Future<void>.value();
  }
}
