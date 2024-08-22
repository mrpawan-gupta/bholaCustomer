import "dart:io";

import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:share_plus/share_plus.dart";

class AppOpenShare {
  factory AppOpenShare() {
    return _singleton;
  }

  AppOpenShare._internal();
  static final AppOpenShare _singleton = AppOpenShare._internal();

  final String playStoreLink = "https://play.google.com/store/apps/details?id=";

  final String appStoreLink = "https://apps.apple.com/in/app/facebook/id";

  Future<void> openShareForAdmin() async {
    final String platformAnd = "$playStoreLink${AppConstants().pkgOfAdmin}";
    final String platformIOS = "$appStoreLink${AppConstants().idOfAdmin}";

    String link = "";
    if (Platform.isAndroid) {
      link = platformAnd;
    } else if (Platform.isIOS) {
      link = platformIOS;
    } else {}

    final ShareResult result = await Share.share(link);
    if (result.status == ShareResultStatus.unavailable) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Something went wrong",
      );
    } else {}

    return Future<void>.value();
  }

  Future<void> openShareForCustomer() async {
    final String platformAnd = "$playStoreLink${AppConstants().pkgOfCustomer}";
    final String platformIOS = "$appStoreLink${AppConstants().pkgOfCustomer}";

    String link = "";
    if (Platform.isAndroid) {
      link = platformAnd;
    } else if (Platform.isIOS) {
      link = platformIOS;
    } else {}

    final ShareResult result = await Share.share(link);
    if (result.status == ShareResultStatus.unavailable) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Something went wrong",
      );
    } else {}

    return Future<void>.value();
  }

  Future<void> openShareForPartner() async {
    final String platformAnd = "$playStoreLink${AppConstants().pkgOfPartner}";
    final String platformIOS = "$appStoreLink${AppConstants().pkgOfPartner}";

    String link = "";
    if (Platform.isAndroid) {
      link = platformAnd;
    } else if (Platform.isIOS) {
      link = platformIOS;
    } else {}

    final ShareResult result = await Share.share(link);
    if (result.status == ShareResultStatus.unavailable) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Something went wrong",
      );
    } else {}

    return Future<void>.value();
  }
}
