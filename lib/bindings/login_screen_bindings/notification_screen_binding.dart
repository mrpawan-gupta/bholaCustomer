import "package:customer/controllers/login_screen_controllers/notification_screen_controller.dart";
import "package:get/get.dart";

class NotificationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(NotificationScreenController.new);
  }
}
