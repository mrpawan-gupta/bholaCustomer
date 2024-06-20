import "dart:async";

import "package:customer/models/verify_otp.dart";
import "package:customer/services/app_api_service.dart";
// import "package:customer/services/app_textbee.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class OTPScreenController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final RxString rxPhoneNumber = "".obs;
  final RxString rxAppSignature = "".obs;
  final RxString rxOTP = "".obs;
  final Rx<DateTime> otpResendDateTime = DateTime.now().obs;
  final Rx<VerifyOTPModelData> verifyOTPData = VerifyOTPModelData().obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("phoneNumber")) {
        updatePhoneNo(arguments["phoneNumber"]);
      } else {}

      if (arguments.containsKey("appSignature")) {
        updateAppSignature(arguments["appSignature"]);
      } else {}
    } else {}
  }

  @override
  void onReady() {
    super.onReady();

    timerStart();
  }

  void timerStart() {
    final DateTime dateTime = DateTime.now().add(const Duration(seconds: 60));
    otpResendDateTime(dateTime);
    return;
  }

  void timerEnd() {
    final DateTime dateTime = DateTime(1970);
    otpResendDateTime(dateTime);
    return;
  }

  bool isTimePassed() {
    final Duration diff = DateTime.now().difference(otpResendDateTime.value);
    final bool value = diff >= Duration.zero;
    return value;
  }

  void updatePhoneNo(String value) {
    rxPhoneNumber(value);
    return;
  }

  void updateAppSignature(String value) {
    rxAppSignature(value);
    return;
  }

  void updateOTP(String value) {
    rxOTP(value);
    return;
  }

  void updateVerifyOTPData(VerifyOTPModelData value) {
    verifyOTPData(value);
    return;
  }

  void unfocus() {
    final bool cond1 = otpController.value.text.length == 6;
    final bool cond2 = rxOTP.value.length == 6;

    if (cond1 && cond2) {
      FocusManager.instance.primaryFocus?.unfocus();
      unawaited(verifyOTPAPICall());
    } else {}
    return;
  }

  String formValidate() {
    String reason = "";
    final bool cond1 = rxOTP.value.isNotEmpty;
    final bool cond2 = rxOTP.value.length == 6;
    if (!cond1) {
      reason = "Please enter your OTP.";
    } else if (!cond2) {
      reason = "Please enter your valid OTP.";
    } else {}
    return reason;
  }

  Future<void> sendOTPAPICall() async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "auth/send-otp",
      body: <String, dynamic>{
        "phoneNumber": "+91${rxPhoneNumber.value.trim()}",
        "appSignature": rxAppSignature.value.trim(),
      },
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(
          title: "Yay!",
          message: json["message"],
        );

        // await AppTextbee().sendSMS(
        //   body: <String, dynamic>{
        //     "phoneNumber": "+91${rxPhoneNumber.value.trim()}",
        //     "appSignature": rxAppSignature.value.trim(),
        //   },
        // );

        timerStart();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(
          title: "Oops",
          message: json["message"],
        );
      },
    );
    return Future<void>.value();
  }

  Future<void> verifyOTPAPICall() async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "auth/verify-otp/Customer",
      body: <String, dynamic>{
        "phoneNumber": "+91${rxPhoneNumber.value.trim()}",
        "otp": rxOTP.value.trim(),
      },
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(
          title: "Yay!",
          message: json["message"],
        );

        VerifyOTPModel verifyOTPModel = VerifyOTPModel();
        verifyOTPModel = VerifyOTPModel.fromJson(json);

        updateVerifyOTPData(verifyOTPModel.data ?? VerifyOTPModelData());

        final VerifyOTPModelData userAuth = verifyOTPData.value;
        await AppSession().setUserAuth(userAuth: userAuth);

        await decideAndNavigate();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(
          title: "Oops",
          message: json["message"],
        );
      },
    );
    return Future<void>.value();
  }

  Future<void> decideAndNavigate() async {
    await AppSession().performSignIn();
    return Future<void>.value();
  }
}
