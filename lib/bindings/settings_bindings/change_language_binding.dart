import "package:customer/controllers/settings_controllers/change_language_controller.dart";
import "package:get/get.dart";

class ChangeLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ChangeLanguageController.new);
  }
}
