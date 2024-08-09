import "dart:async";
import "dart:convert";
import "dart:developer";

import "package:customer/common_functions/encode_decode_functions.dart";
import "package:customer/models/phone_pe_payload_model.dart";
import "package:customer/models/phone_pe_res_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_pretty_print_json.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

enum PaymentState { notStarted, started, processing, success, failure }

class PaymentController extends GetxController {
  final RxString rxBookingId = "".obs;
  final Rx<PhonePePayloadModel> rxPhonePePayload = PhonePePayloadModel().obs;
  final Rx<PhonePeResModel> rxPhonePeResModel = PhonePeResModel().obs;
  final Rx<PaymentState> rxPaymentState = PaymentState.notStarted.obs;

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

  void updatePhonePePayload(PhonePePayloadModel value) {
    rxPhonePePayload(value);
    return;
  }

  void updatePhonePeResModel(PhonePeResModel value) {
    rxPhonePeResModel(value);
    return;
  }

  void updatePaymentState(PaymentState value) {
    rxPaymentState(value);
    return;
  }

  void resetAllPaymentData() {
    updatePhonePePayload(PhonePePayloadModel());
    updatePhonePeResModel(PhonePeResModel());
    updatePaymentState(PaymentState.notStarted);

    return;
  }

  bool canGoBack() {
    final bool finalCondition = canGoBackSuccess() || canGoBackFailure();

    return finalCondition;
  }

  bool canGoBackSuccess() {
    return rxPaymentState.value == PaymentState.success;
  }

  bool canGoBackFailure() {
    return rxPaymentState.value == PaymentState.failure;
  }

  Future<(bool, String, String)> bookingTransactionAPICall() async {
    final Completer<(bool, String, String)> completer =
        Completer<(bool, String, String)>();

    await AppAPIService().functionPost(
      types: Types.rental,
      endPoint: "bookingtransaction",
      body: <String, dynamic>{"booking": rxBookingId.value},
      successCallback: (Map<String, dynamic> json) async {
        AppLogger().info(message: json["message"]);

        PhonePePayloadModel model = PhonePePayloadModel();
        model = PhonePePayloadModel.fromJson(json);

        updatePhonePePayload(model);

        final PhonePePayloadModel payload = rxPhonePePayload.value;
        final String body = payload.data?.body ?? "";
        final String checksum = payload.data?.checksum ?? "";
        final String paymentGateway = payload.data?.paymentGateway ?? "";

        final bool cond1 = paymentGateway == "PhonePay";
        final bool cond2 = paymentGateway == "PhonePe";
        final bool finalCondition = cond1 || cond2;

        decodeBase64toMap(body: body);

        completer.complete((finalCondition, body, checksum));
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete((false, "", ""));
      },
    );

    return completer.future;
  }

  Future<bool> bookingTransactionStatusAPICall() async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionGet(
      types: Types.payment,
      endPoint: "transaction/${rxPhonePePayload.value.data?.sId ?? ""}",
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        PhonePeResModel model = PhonePeResModel();
        model = PhonePeResModel.fromJson(json);

        updatePhonePeResModel(model);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );

    return completer.future;
  }

  Map<String, dynamic> decodeBase64toMap({required String body}) {
    final String decodedString = decodeBase64toString(encodedString: body);
    final Map<String, dynamic> map = json.decode(decodedString);
    final String prettyPrint = AppPrettyPrintJSON().prettyPrint(map);
    log(prettyPrint);

    return map;
  }
}
