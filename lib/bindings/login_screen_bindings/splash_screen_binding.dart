import "package:customer/controllers/login_screen_controllers/splash_screen_controller.dart";
import "package:get/get.dart";

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
