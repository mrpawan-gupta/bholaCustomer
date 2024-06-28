import "package:customer/controllers/wish_list_controller/wish_list_controller.dart";
import "package:get/get.dart";

class WishListBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(WishListController.new);
  }
}
