import "package:flutter/foundation.dart";

class AppConstants {
  factory AppConstants() {
    return _singleton;
  }

  AppConstants._internal();
  static final AppConstants _singleton = AppConstants._internal();

  final String vpnAPIKey = "40f6cdcbaf9b4c139d4a276b9788dee6";
  final double elevation = 0.0;
  final Duration duration = const Duration(seconds: 4);

  final bool isEnabledAppLogger = kDebugMode;

  final bool isEnabledFirestoreUpdateLocInfo = kReleaseMode;
  final bool isEnabledFirestoreUpdatePkgInfo = kReleaseMode;
  final bool isEnabledFirestoreUpdateDevInfo = kReleaseMode;

  final Duration locationFetchDuration = const Duration(minutes: 10);

  final String samplePDF =  "https://pdfobject.com/pdf/sample.pdf";
}
