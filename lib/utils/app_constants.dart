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

  final bool isEnabledFirestoreUpdateLocInfo = true;
  final bool isEnabledFirestoreUpdatePkgInfo = true;
  final bool isEnabledFirestoreUpdateDevInfo = true;
  final Duration locationFetchDuration = const Duration(seconds: 30);

  final String samplePDF =  "https://pdfobject.com/pdf/sample.pdf";
  final String sampleImg = "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTExL3BmLXMxMDgtcG0tNDExMy1tb2NrdXAuanBn.jpg";

  final String googleMapAPIKey = "AIzaSyAu0uQwt1solBKGQcExM9eJvU8rEPfbNNo";
  
  final String whatsAppNumber = "+919765716231";
}
