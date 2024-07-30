import "dart:async";

import "package:customer/services/phonepe_sdk_service.dart";
import "package:get/get.dart";

enum PaymentState {
  notStarted,
  started,
  processing,
  paymemtSuccess,
  paymentFailure,
}

class BookingPaymentController extends GetxController {
  final RxString rxBookingId = "".obs;
  final Rx<PaymentState> rxPaymentState = PaymentState.notStarted.obs;
  final RxString rxMessage = "".obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateBookingId(arguments["id"]);
      } else {}
    } else {}

    updatePaymentState(PaymentState.started);
  }

  void updateBookingId(String value) {
    rxBookingId(value);
    return;
  }

  void updatePaymentState(PaymentState value) {
    rxPaymentState(value);
    return;
  }

  void updateMessage(String value) {
    rxMessage(value);
    return;
  }

  bool canGoBack() {
    final PaymentState state = rxPaymentState.value;
    final bool condition1 = state == PaymentState.paymemtSuccess;
    final bool condition2 = state == PaymentState.paymentFailure;
    final bool finalCondition = condition1 || condition2;

    return finalCondition;
  }

  Future<(bool, String, String)> createOrderAPICall() async {
    final Completer<(bool, String, String)> completer =
        Completer<(bool, String, String)>();

    final String body = getBody(amount: 1000);

    final String checksum = getChecksumCalculation(amount: 1000);

    completer.complete((true, body, checksum));

    return completer.future;
  }
}
