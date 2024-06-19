import "package:customer/controllers/settings_controllers/app_info_controller.dart";
import "package:get/get.dart";

class AppInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AppInfoController.new);
  }
}
