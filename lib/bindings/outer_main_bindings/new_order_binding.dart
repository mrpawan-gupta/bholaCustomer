import "package:customer/controllers/outer_main_controllers/new_order_controller.dart";
import "package:get/get.dart";

class NewOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NewOrderController.new);
  }
}
