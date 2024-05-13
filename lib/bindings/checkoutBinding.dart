import "package:customer/controllers/checkout_controllers.dart";
import "package:get/get.dart";

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CheckoutController.new);
  }
}
