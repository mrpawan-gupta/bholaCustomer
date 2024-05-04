import "package:customer/controllers/account_controller.dart";
import "package:get/get.dart";

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(AccountController.new);
  }
}
