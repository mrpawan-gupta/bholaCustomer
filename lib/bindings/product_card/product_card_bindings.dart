import "package:customer/controllers/product_card_controllers/product_card_controllers.dart";
import "package:get/get.dart";

class ProductCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProductCardController.new);
  }
}
