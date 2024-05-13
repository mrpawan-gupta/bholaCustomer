import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:url_launcher/url_launcher.dart";

class AppVendorAgreement {
  factory AppVendorAgreement() {
    return _singleton;
  }

  AppVendorAgreement._internal();
  static final AppVendorAgreement _singleton = AppVendorAgreement._internal();

  Future<void> openVendorAgreement() async {
    final Uri pdf = Uri.parse(AppConstants().samplePDF);
    bool isSucceed = false;

    if (await canLaunchUrl(pdf)) {
      isSucceed = true;
      await launchUrl(pdf, mode: LaunchMode.externalApplication);
    } else {}

    if (!isSucceed) {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Unable to open PDF",
      );
    } else {}
    return Future<void>.value();
  }
}
