import "package:customer/controllers/splash_screen_controller/splash_screen_controllers.dart";
import "package:get/get.dart";

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
  }
}
