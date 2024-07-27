// import "dart:async";

// import "package:customer/services/phonepe_sdk_service.dart";
import "package:get/get.dart";

class BookingPaymentController extends GetxController {
  final RxString rxBookingId = "".obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateBookingId(arguments["id"]);
      } else {}
    } else {}
  }

  void updateBookingId(String value) {
    rxBookingId(value);
    return;
  }

  // Future<(bool, String, String)> createOrderAPICall() async {
  //   final Completer<(bool, String, String)> completer =
  //       Completer<(bool, String, String)>();

  //   String body = "";
  //   body = getBody(amount: 1000);

  //   String checksum = "";
  //   checksum = getChecksumCalculation(amount: 1000);

  //   completer.complete((true, body, checksum));
  //   return completer.future;
  // }
}
