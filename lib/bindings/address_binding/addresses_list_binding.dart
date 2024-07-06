import "package:customer/controllers/address_controller/addresses_list_controller.dart";
import "package:get/get.dart";

class AddressesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AddressesListController.new);
  }
}
