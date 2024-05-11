import "dart:convert";
import "dart:developer";

import "package:customer/services/app_firestore_user_db.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:get/get.dart";

class AppDevInfoService extends GetxService {
  factory AppDevInfoService() {
    return _singleton;
  }

  AppDevInfoService._internal();
  static final AppDevInfoService _singleton = AppDevInfoService._internal();

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? android;
  IosDeviceInfo? ios;

  Future<Map<String, dynamic>> initDevInformation() async {
    final Map<String, dynamic> allInfoAsMap = <String, dynamic>{};
    try {
      if (GetPlatform.isAndroid) {
        android = await deviceInfo.androidInfo;
        AppLogger().info(message: "Dev Info: ${json.encode(android?.data)}");
        allInfoAsMap.addAll(android?.data ?? <String, dynamic>{});
      } else if (GetPlatform.isIOS) {
        ios = await deviceInfo.iosInfo;
        AppLogger().info(message: "Dev Info: ${json.encode(ios?.data)}");
        allInfoAsMap.addAll(ios?.data ?? <String, dynamic>{});
      } else {}
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<Map<String, dynamic>>.value(allInfoAsMap);
  }

  Future<void> updateInfoToFirestore() async {
    final bool canUpdate = AppConstants().isEnabledFirestoreUpdateDevInfo;
    if (canUpdate) {
      final String id = AppStorageService().getUserInfoModel().sId ?? "";
      if (id.isEmpty) {
      } else {
        final Map<String, dynamic> data = <String, dynamic>{};

        if (GetPlatform.isAndroid) {
          data.addAll(
            <String, dynamic>{
              "device": <String, Object>{
                "OS": "Android",
                "version": android?.version ?? "",
                "model": android?.model ?? "",
                "brand": android?.brand ?? "",
                "device": android?.device ?? "",
                "serialNumber": android?.serialNumber ?? "",
                "id": android?.id ?? "",
                "manufacturer": android?.manufacturer ?? "",
                "product": android?.product ?? "",
                "board": android?.board ?? "",
              },
            },
          );
        } else if (GetPlatform.isIOS) {
          data.addAll(
            <String, dynamic>{
              "device": <String, Object>{
                "OS": "iOS",
                "version": ios?.systemVersion ?? "",
                "model": ios?.model ?? "",
                "localizedModel": ios?.localizedModel ?? "",
                "UUID": ios?.identifierForVendor ?? "",
              },
            },
          );
        } else {}

        await AppFirestoreUserDB().updateOrSetUser(
          id: id,
          data: data,
          successCallback: log,
          failureCallback: log,
        );
      }
    } else {}
    return Future<void>.value();
  }
}
