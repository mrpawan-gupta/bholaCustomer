import "package:customer/controllers/main_navigation_controller.dart";
import "package:get/get.dart";

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MainNavigationController.new);
  }
}
