import "package:customer/controllers/product_detail_page_controllers/product_detail_page_controllers.dart";
import "package:get/get.dart";

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProductDetailController.new);
  }
}
