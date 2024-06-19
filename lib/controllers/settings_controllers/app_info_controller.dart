import "package:customer/services/app_pkg_info_service.dart";
import "package:get/get.dart";
import "package:package_info_plus/package_info_plus.dart";

class AppInfoController extends GetxController {
  Rx<PackageInfo> rxPackageInfo = PackageInfo(
    appName: "",
    packageName: "",
    version: "",
    buildNumber: "",
  ).obs;

  @override
  void onInit() {
    super.onInit();

    updatePackageInfo(AppPkgInfoService().packageInfo);
  }

  void updatePackageInfo(PackageInfo value) {
    rxPackageInfo(value);
    return;
  }
}
