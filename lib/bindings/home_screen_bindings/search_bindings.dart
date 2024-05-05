import "package:customer/controllers/home_screen_controllers/search_controllers.dart";
import "package:get/get.dart";

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SearchController.new);
  }
}
