import "package:customer/controllers/booking_slot_controllers/book_slot_controllers.dart";
import "package:customer/controllers/checkoutControllers.dart";
import "package:get/get.dart";

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CheckoutController.new);
  }
}
