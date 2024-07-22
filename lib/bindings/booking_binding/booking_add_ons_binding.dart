import "package:customer/controllers/booking_controller/booking_add_ons_controller.dart";
import "package:get/get.dart";

class BookingAddOnsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(BookingAddOnsController.new);
  }
}
