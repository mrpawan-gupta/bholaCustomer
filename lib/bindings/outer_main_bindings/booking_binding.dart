import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:get/get.dart";

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(BookingController.new);
  }
}
