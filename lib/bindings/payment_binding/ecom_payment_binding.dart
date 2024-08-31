import "package:customer/controllers/payment_controller/ecom_payment_controller.dart";
import "package:get/get.dart";

class EcomPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(EcomPaymentController.new);
  }
}
