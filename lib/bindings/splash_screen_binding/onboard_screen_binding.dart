import "package:customer/controllers/splash_screen_controller/onboard_screen_controller.dart";
import "package:get/get.dart";

class OnBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnBoardScreenController());
  }
}
