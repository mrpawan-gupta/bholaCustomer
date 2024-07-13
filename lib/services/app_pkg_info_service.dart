import "dart:convert";
// import "dart:developer";

// import "package:customer/services/app_firestore_user_db.dart";
// import "package:customer/services/app_storage_service.dart";
// import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";

class AppPkgInfoService extends GetxService {
  factory AppPkgInfoService() {
    return _singleton;
  }

  AppPkgInfoService._internal();
  static final AppPkgInfoService _singleton = AppPkgInfoService._internal();

  PackageInfo packageInfo = PackageInfo(
    appName: "",
    packageName: "",
    version: "",
    buildNumber: "",
  );

  Future<Map<String, dynamic>> initPkgInformation() async {
    final Map<String, dynamic> allInfoAsMap = <String, dynamic>{};
    try {
      packageInfo = await PackageInfo.fromPlatform();
      AppLogger().info(message: "Pkg Info: ${json.encode(packageInfo.data)}");
      allInfoAsMap.addAll(packageInfo.data);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<Map<String, dynamic>>.value(allInfoAsMap);
  }

  // Future<void> updateInfoToFirestore() async {
  //   final bool canUpdate = AppConstants().isEnabledFirestoreUpdatePkgInfo;
  //   if (canUpdate) {
  //     final String id = AppStorageService().getUserInfoModel().sId ?? "";
  //     if (id.isEmpty) {
  //     } else {
  //       final Map<String, dynamic> data = <String, dynamic>{
  //         "package": <String, Object>{
  //           "packageName": packageInfo.packageName,
  //           "appName": packageInfo.appName,
  //           "buildNumber": packageInfo.buildNumber,
  //           "buildSignature": packageInfo.buildSignature,
  //           "version": packageInfo.version,
  //           "installerStore": packageInfo.installerStore ?? "",
  //         },
  //       };

  //       await AppFirestoreUserDB().updateOrSetUser(
  //         id: id,
  //         data: data,
  //         successCallback: log,
  //         failureCallback: log,
  //       );
  //     }
  //   } else {}
  //   return Future<void>.value();
  // }
}
