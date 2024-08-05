import "dart:async";

import "package:customer/main.dart";
import "package:customer/services/app_analytics_service.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_app_links_deep_link_service.dart";
import "package:customer/services/app_dev_info_service.dart";
import "package:customer/services/app_fcm_service.dart";
import "package:customer/services/app_internet_connection_checker_service.dart";
// import "package:customer/services/app_location_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_performance.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/services/app_pkg_info_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/services/phonepe_sdk_service.dart";
import "package:customer/utils/app_orientations.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:get/get.dart";

void injectDependencies() {
  Get
    ..put(AppPerformance())
    ..put(AppStorageService())
    ..put(AppNavService())
    ..put(AppAPIService())
    ..put(AppAnalyticsService())
    ..put(AppFCMService())
    ..put(AppNetCheckService())
    ..put(AppPermService())
    ..put(AppAppLinksDeepLinkService())
    ..put(AppPkgInfoService())
    ..put(AppDevInfoService());
    // ..put(AppLocationService());
  return;
}

Future<void> initDependencies() async {
  await AppOrientations().initAppOrientations();
  await AppStorageService().init();

  await AppFCMService().setupInteractedMessage();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  unawaited(AppPkgInfoService().initPkgInformation());
  unawaited(AppDevInfoService().initDevInformation());
  unawaited(PhonePeSDKService().init());
  return Future<void>.value();
}
