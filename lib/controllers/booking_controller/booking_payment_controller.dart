import "dart:convert";

import "package:customer/models/create_booking.dart";
import "package:get/get.dart";

class BookingPaymentController extends GetxController {
  final RxString rxBookingId = "".obs;
  final Rx<CreateBookingData> rxBookingData = CreateBookingData().obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id") && arguments.containsKey("data")) {
        updateBookingId(arguments["id"]);

        Map<String, dynamic> bookingJson = <String, dynamic>{};
        bookingJson = json.decode(arguments["data"]) ?? <String, dynamic>{};
        updateBookingData(CreateBookingData.fromJson(bookingJson));
      } else {}
    } else {}
  }

  void updateBookingId(String value) {
    rxBookingId(value);
    return;
  }

  void updateBookingData(CreateBookingData value) {
    rxBookingData(value);
    return;
  }
}
