import "package:customer/controllers/booking_slot_controllers/selected_slot_controllers.dart";
import "package:get/get.dart";

class SelectedSlotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SelectedSlotController.new);
  }
}
