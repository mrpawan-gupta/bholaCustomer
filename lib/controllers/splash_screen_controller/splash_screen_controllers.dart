import "package:get/get_state_manager/src/simple/get_controllers.dart";
import "package:package_info_plus/package_info_plus.dart";

class SplashScreenController extends GetxController {

  late String currentAppVersion;
  String expectedAppVersion = "1.0.0";

  @override
  void onInit() {
    super.onInit();
    updateApp();
  }

  void updateApp() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentAppVersion = packageInfo.version;
    print("PACKAGE VERSION11");
    print(packageInfo.version);
    if (currentAppVersion != expectedAppVersion) {
      print("not");
    } else {
      print("1");
    }
  }

}
