import "package:customer/controllers/product_listing_controllers/product_listing_controllers.dart";
import "package:get/get.dart";

class ProductListingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProductListingScreenController.new);
  }
}
