import "package:customer/controllers/payment_controller/payment_controller.dart";
import "package:get/get.dart";

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PaymentController.new);
  }
}
