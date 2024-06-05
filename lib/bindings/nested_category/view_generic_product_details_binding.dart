import "package:customer/controllers/nested_category/view_generic_product_details_controller.dart";
import "package:get/get.dart";

class ViewGenericProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create (ViewGenericProductDetailsController.new);
  }
}
