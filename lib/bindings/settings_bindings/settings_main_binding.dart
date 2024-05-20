import "package:customer/controllers/settings_controllers/settings_main_controller.dart";
import "package:get/get.dart";

class SettingsMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SettingsMainController.new);
  }
}
