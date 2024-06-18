import "package:customer/controllers/login_screen_controllers/intro_slider_controller.dart";
import "package:get/get.dart";

class IntroSliderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(IntroSliderController.new);
  }
}
