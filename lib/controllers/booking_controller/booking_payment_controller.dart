import "package:get/get.dart";

class BookingPaymentController extends GetxController {
  final RxString rxBookingId = "".obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id") && arguments.containsKey("data")) {
        updateBookingId(arguments["id"]);
      } else {}
    } else {}
  }

  void updateBookingId(String value) {
    rxBookingId(value);
    return;
  }
}
