import "package:customer/controllers/sample_controllers/firebase_sample_controller.dart";
import "package:get/get.dart";

class FirebaseSampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FirebaseSampleController.new);
  }
}
