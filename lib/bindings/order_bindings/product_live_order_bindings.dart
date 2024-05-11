import "package:customer/controllers/order_controllers/product_live_order_controllers.dart";
import "package:get/get.dart";

class ProductLiveOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProductLiveOrderController.new);
  }
}
