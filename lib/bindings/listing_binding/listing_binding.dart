import "package:customer/controllers/listing_controllers/listing_controllers.dart";
import "package:get/get.dart";

class ListingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ListingScreenController.new);
  }
}
