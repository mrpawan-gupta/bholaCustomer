import "package:flutter/services.dart";

class AppConfig {
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  static final AppConfig _singleton = AppConfig._internal();

  String baseURL = "";
  String phonePeEnvironment = "";
  String phonePeMerchantId = "";

  void init() {
    const String flavor = appFlavor ?? "";
    switch (flavor) {
      case "dev":
        baseURL = "https://dev.bhola.org.in";
        phonePeEnvironment = "SANDBOX";
        phonePeMerchantId = "AHINSAUAT";
        break;
      case "prd":
        baseURL = "https://api.bhola.org.in";
        phonePeEnvironment = "PRODUCTION";
        phonePeMerchantId = "M225AAVLG7V05";
        break;
      default:
        break;
    }
    return;
  }
}
