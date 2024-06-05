import "package:customer/controllers/nested_category/products_list_controller.dart";
import "package:get/get.dart";

class ProductsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ProductsListController.new);
  }
}
