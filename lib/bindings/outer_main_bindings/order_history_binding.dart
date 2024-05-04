import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:get/get.dart";

class OrderHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(OrderHistoryController.new);
  }
}
