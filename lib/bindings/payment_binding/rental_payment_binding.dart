import "package:customer/controllers/payment_controller/rental_payment_controller.dart";
import "package:get/get.dart";

class RentalPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(RentalPaymentController.new);
  }
}
