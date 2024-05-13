import "package:customer/controllers/login_screen_controllers/phone_number_screen_controller.dart";
import "package:get/get.dart";

class PhoneNumberScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PhoneNumberScreenController.new);
  }
}
