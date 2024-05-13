import "package:customer/controllers/login_screen_controllers/otp_screen_controller.dart";
import "package:get/get.dart";

class OTPScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(OTPScreenController.new);
  }
}
