import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:url_launcher/url_launcher.dart";

class AppWhatsApp {
  factory AppWhatsApp() {
    return _singleton;
  }

  AppWhatsApp._internal();
  static final AppWhatsApp _singleton = AppWhatsApp._internal();

  Future<void> openWhatsApp() async {
    final String whatsapp = AppConstants().whatsAppNumber;
    
    final Uri link =
        Uri.parse("https://api.whatsapp.com/send?phone=$whatsapp&text=hello");

    bool isSucceed = false;

    if (await canLaunchUrl(link)) {
      isSucceed = true;
      await launchUrl(link, mode: LaunchMode.externalApplication);
    } else {}

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "WhatsApp not installed",
      );
    } else {}
    return Future<void>.value();
  }
}
