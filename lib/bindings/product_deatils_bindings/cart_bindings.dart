import "package:customer/controllers/product_detail_page_controllers/cart_controllers.dart";
import "package:get/get.dart";

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CartController.new);
  }
}
