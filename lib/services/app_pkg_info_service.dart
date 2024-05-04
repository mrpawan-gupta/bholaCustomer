import "dart:convert";

import "package:customer/utils/app_logger.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";

class AppPkgInfoService extends GetxService {
  factory AppPkgInfoService() {
    return _singleton;
  }

  AppPkgInfoService._internal();
  static final AppPkgInfoService _singleton = AppPkgInfoService._internal();

  Future<Map<String, dynamic>> getPackageInformation() async {
    final Map<String, dynamic> allInfoAsMap = <String, dynamic>{};
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
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
}
