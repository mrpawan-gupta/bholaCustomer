import "package:customer/controllers/review_rating_controller/review_rating_controller.dart";
import "package:get/get.dart";

class ReviewRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(ReviewRatingController.new);
  }
}
