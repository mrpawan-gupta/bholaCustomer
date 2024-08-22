import "dart:io";

import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:url_launcher/url_launcher.dart";

class AppOpenStore {
  factory AppOpenStore() {
    return _singleton;
  }

  AppOpenStore._internal();
  static final AppOpenStore _singleton = AppOpenStore._internal();

  final String playStoreLink = "https://play.google.com/store/apps/details?id=";

  final String appStoreLink = "https://apps.apple.com/in/app/facebook/id";

  Future<void> openStoreForAdmin() async {
    final String platformAnd = "$playStoreLink${AppConstants().pkgOfAdmin}";
    final String platformIOS = "$appStoreLink${AppConstants().idOfAdmin}";

    Uri link = Uri.parse("");
    if (Platform.isAndroid) {
      link = Uri.parse(platformAnd);
    } else if (Platform.isIOS) {
      link = Uri.parse(platformIOS);
    } else {}

    bool isSucceed = false;

    if (await canLaunchUrl(link)) {
      isSucceed = true;
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {}

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Store not installed",
      );
    } else {}
    return Future<void>.value();
  }

  Future<void> openStoreForCustomer() async {
    final String platformAnd = "$playStoreLink${AppConstants().pkgOfCustomer}";
    final String platformIOS = "$appStoreLink${AppConstants().idOfCustomer}";

    Uri link = Uri.parse("");
    if (Platform.isAndroid) {
      link = Uri.parse(platformAnd);
    } else if (Platform.isIOS) {
      link = Uri.parse(platformIOS);
    } else {}

    bool isSucceed = false;

    if (await canLaunchUrl(link)) {
      isSucceed = true;
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {}

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Store not installed",
      );
    } else {}
    return Future<void>.value();
  }

  Future<void> openStoreForPartner() async {
    final String platformAnd = "$playStoreLink${AppConstants().pkgOfPartner}";
    final String platformIOS = "$appStoreLink${AppConstants().idOfPartner}";

    Uri link = Uri.parse("");
    if (Platform.isAndroid) {
      link = Uri.parse(platformAnd);
    } else if (Platform.isIOS) {
      link = Uri.parse(platformIOS);
    } else {}

    bool isSucceed = false;

    if (await canLaunchUrl(link)) {
      isSucceed = true;
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {}

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Store not installed",
      );
    } else {}
    return Future<void>.value();
  }
}
