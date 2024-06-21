import "package:customer/controllers/settings_controllers/support_controller.dart";
import "package:get/get.dart";

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SupportController.new);
  }
}
