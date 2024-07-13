import "package:customer/controllers/coupon_controller/coupon_controller.dart";
import "package:get/get.dart";

class CouponBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(CouponController.new);
  }
}
