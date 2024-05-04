import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:get/get.dart";

class HelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HelpController.new);
  }
}
