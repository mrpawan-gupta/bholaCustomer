import "package:customer/controllers/booking_controller/added_quotes_controller.dart";
import "package:get/get.dart";

class AddedQuotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(AddedQuotesController.new);
  }
}
