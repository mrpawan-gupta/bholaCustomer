import "package:customer/controllers/booking_controller/booking_payment_controller.dart";
import "package:get/get.dart";

class BookingPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(BookingPaymentController.new);
  }
}
