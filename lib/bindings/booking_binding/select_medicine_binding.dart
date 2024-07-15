import "package:customer/controllers/booking_controller/select_medicine_controller.dart";
import "package:get/get.dart";

class SelectMedicineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SelectMedicineController.new);
  }
}
