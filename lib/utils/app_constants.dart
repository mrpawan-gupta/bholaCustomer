import "package:flutter/foundation.dart";

class AppConstants {
  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();
  static final AppConstants _singleton = AppConstants._internal();

  final String vpnAPIKey = "40f6cdcbaf9b4c139d4a276b9788dee6";
  final String textbeeKey = "3b20d296-35df-4630-a805-c87a8496cd2b";
  final double elevation = 0.0;

  final Duration duration = const Duration(seconds: 4);

  final bool isEnabledAppLogger = kDebugMode;
  final bool isEnabledFirestoreUpdateLocInfo = kReleaseMode;
  final bool isEnabledFirestoreUpdatePkgInfo = kReleaseMode;
  final bool isEnabledFirestoreUpdateDevInfo = kReleaseMode;

  final Duration locationFetchDuration = const Duration(minutes: 5);

  final String samplePDFThumb =
      "https://drive.usercontent.google.com/u/0/uc?id=1lANuruz2k7cpKGxLz4aIf2w7PtA153qO&export=pdf";
  final String samplePDFView =
      "https://drive.google.com/file/d/1lANuruz2k7cpKGxLz4aIf2w7PtA153qO/view";

  final String sampleImg =
      "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTExL3BmLXMxMDgtcG0tNDExMy1tb2NrdXAuanBn.jpg";

  final String googleMapAPIKey = "AIzaSyAu0uQwt1solBKGQcExM9eJvU8rEPfbNNo";

  final String whatsAppNumber = "+919765716231";

  final String appURLsHomePage = "http://dev.bhola.org.in/";
  final String appURLsAboutUs = "http://dev.bhola.org.in/about-us/";

  final String appURLsPrivacyPolicy = "http://dev.bhola.org.in/privacy/";
  final String appURLsRefundPolicy = "http://dev.bhola.org.in/refund/";

  final String appURLsTAndCCustomer = "http://dev.bhola.org.in/customer/";
  final String appURLsTAndCVendor = "https://dev.bhola.org.in/vendor/";
}
