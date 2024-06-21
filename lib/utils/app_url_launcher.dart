import "package:customer/utils/app_snackbar.dart";
import "package:url_launcher/url_launcher.dart";

class AppURLLauncher {
  factory AppURLLauncher() {
    return _singleton;
  }

  AppURLLauncher._internal();
  static final AppURLLauncher _singleton = AppURLLauncher._internal();

  Future<void> open({required String scheme, required String path}) async {
    final Uri link = Uri(scheme: scheme, path: path);

    bool isSucceed = false;

    if (await canLaunchUrl(link)) {
      isSucceed = true;
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {}

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "App not installed",
      );
    } else {}
    return Future<void>.value();
  }
}
