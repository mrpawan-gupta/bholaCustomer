import "dart:convert";

import "package:customer/utils/app_logger.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:get/get.dart";

class AppDevInfoService extends GetxService {
  factory AppDevInfoService() {
    return _singleton;
  }

  AppDevInfoService._internal();
  static final AppDevInfoService _singleton = AppDevInfoService._internal();

  Future<Map<String, dynamic>> getDeviceInformation() async {
    final Map<String, dynamic> allInfoAsMap = <String, dynamic>{};
    try {
      final BaseDeviceInfo deviceInfo = await DeviceInfoPlugin().deviceInfo;
      AppLogger().info(message: "Dev Info: ${json.encode(deviceInfo.data)}");
      allInfoAsMap.addAll(deviceInfo.data);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<Map<String, dynamic>>.value(allInfoAsMap);
  }
}
