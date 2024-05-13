import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:url_launcher/url_launcher.dart";

class AppWhatsApp {
  factory AppWhatsApp() {
    return _singleton;
  }

  AppWhatsApp._internal();
  static final AppWhatsApp _singleton = AppWhatsApp._internal();

  Future<void> openWhatsApp() async {
    const String whatsapp = "+919904490482";
    final Uri android = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    final Uri iOS = Uri.parse("https://wa.me/$whatsapp?text=hello");
    bool isSucceed = false;

    if (GetPlatform.isIOS) {
      if (await canLaunchUrl(iOS)) {
        isSucceed = true;
        await launchUrl(iOS, mode: LaunchMode.externalApplication);
      } else {}
    } else {
      if (await canLaunchUrl(android)) {
        isSucceed = true;
        await launchUrl(android, mode: LaunchMode.externalApplication);
      } else {}
    }

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "WhatsApp not installed",
      );
    } else {}
    return Future<void>.value();
  }
}
