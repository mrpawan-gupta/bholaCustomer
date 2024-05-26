import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:get/get.dart";

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CategoryController.new);
  }
}
