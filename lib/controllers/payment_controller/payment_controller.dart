import "dart:async";

import "package:confetti/confetti.dart";
import "package:customer/models/phone_pe_payload_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

enum PaymentState {
  notStarted,
  started,
  processing,
  paymemtSuccess,
  paymentFailure,
}

class PaymentController extends GetxController {
  final RxString rxBookingId = "".obs;
  final RxString rxMessage = "".obs;

  final Rx<PaymentState> rxPaymentState = PaymentState.notStarted.obs;

  ConfettiController confettiController = ConfettiController();

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

    const Duration duration = Duration(seconds: 2);
    confettiController = ConfettiController(duration: duration);
  }

  @override
  void onClose() {
    confettiController.dispose();

    super.onClose();
  }

  void updateBookingId(String value) {
    rxBookingId(value);
    return;
  }

  void updateMessage(String value) {
    rxMessage(value);
    return;
  }

  void updatePaymentState(PaymentState value) {
    rxPaymentState(value);
    return;
  }

  bool canGoBack() {
    final PaymentState state = rxPaymentState.value;
    final bool cond1 = state == PaymentState.paymemtSuccess;
    final bool cond2 = state == PaymentState.paymentFailure;
    final bool finalCondition = cond1 || cond2;
    return finalCondition;
  }

  bool canGoBackSuccess() {
    final PaymentState state = rxPaymentState.value;
    final bool cond1 = state == PaymentState.paymemtSuccess;
    final bool finalCondition = cond1;
    return finalCondition;
  }

  bool canGoBackFailure() {
    final PaymentState state = rxPaymentState.value;
    final bool cond2 = state == PaymentState.paymentFailure;
    final bool finalCondition = cond2;
    return finalCondition;
  }

  Future<(bool, String, String)> bookingTransactionAPICall() async {
    final Completer<(bool, String, String)> completer =
        Completer<(bool, String, String)>();

    await AppAPIService().functionPost(
      types: Types.rental,
      endPoint: "bookingtransaction",
      body: <String, dynamic>{"booking": rxBookingId.value},
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        PhonePePayloadModel model = PhonePePayloadModel();
        model = PhonePePayloadModel.fromJson(json);

        final bool cond1 = (model.data?.paymentGateway ?? "") == "PhonePay";
        final bool cond2 = (model.data?.paymentGateway ?? "") == "PhonePe";
        final bool finalCondition = cond1 || cond2;

        completer.complete(
          (
            finalCondition,
            model.data?.body ?? "",
            model.data?.checksum ?? "",
          ),
        );
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(
          (false, "", ""),
        );
      },
    );

    return completer.future;
  }
}
