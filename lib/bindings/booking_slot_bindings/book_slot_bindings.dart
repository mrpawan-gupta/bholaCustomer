import "package:customer/controllers/booking_slot_controllers/book_slot_controllers.dart";
import "package:get/get.dart";

class BookSlotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(BookSlotController.new);
  }
}
