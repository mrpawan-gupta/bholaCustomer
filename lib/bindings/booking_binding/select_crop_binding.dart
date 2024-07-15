import "package:customer/controllers/booking_controller/select_crop_controller.dart";
import "package:get/get.dart";

class SelectCropBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SelectCropController.new);
  }
}
