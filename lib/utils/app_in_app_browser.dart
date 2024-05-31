import "package:customer/utils/app_logger.dart";
import "package:flutter_custom_tabs/flutter_custom_tabs.dart";

class AppInAppBrowser {
  factory AppInAppBrowser() {
    return _singleton;
  }

  AppInAppBrowser._internal();
  static final AppInAppBrowser _singleton = AppInAppBrowser._internal();

  Future<void> openInAppBrowser({required String url}) async {
    try {
      AppLogger().info(message: "Opening $url in in-app browser!");
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: const CustomTabsOptions(),
        safariVCOptions: const SafariViewControllerOptions(),
      );
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<void>.value();
  }
}
