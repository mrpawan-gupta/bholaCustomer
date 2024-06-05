import "dart:async";

import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_dev_info_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_textbee.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:smart_auth/smart_auth.dart";

class PhoneNumberScreenController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final RxString rxPhoneNumber = "".obs;
  final RxString rxAppSignature = "".obs;

  @override
  void onReady() {
    super.onReady();

    unawaited(getAppSignature());
    unawaited(requestHint());
  }

  Future<void> getAppSignature() async {
    final String appSignature = await SmartAuth().getAppSignature() ?? "";
    AppLogger().info(message: "appSignature: $appSignature");
    updateAppSignature(appSignature);
    return Future<void>.value();
  }

  Future<void> requestHint() async {
    if (GetPlatform.isAndroid) {
      final bool isPhysicalDevice = AppDevInfoService().isPhysicalDevice();
      if (isPhysicalDevice) {
        final Credential result = await SmartAuth().requestHint(
              isPhoneNumberIdentifierSupported: true,
            ) ??
            Credential(id: "");

        if (result.id.isNotEmpty) {
          await stringOperation(fullPhoneNumber: result.id);
          unfocus();
        } else {}
      } else {}
    } else {}
    return Future<void>.value();
  }

  Future<void> stringOperation({required String fullPhoneNumber}) async {
    final String temp = fullPhoneNumber;

    final String substring = temp.startsWith("0")
        ? temp.substring(1)
        : temp.startsWith("91")
            ? temp.substring(2)
            : temp.startsWith("+91")
                ? temp.substring(3)
                : "";

    if (substring.isNotEmpty) {
      phoneNumberController.text = substring;
      updatePhoneNo(substring);
    } else {}

    return Future<void>.value();
  }

  void unfocus() {
    final bool cond1 = phoneNumberController.value.text.length == 10;
    final bool cond2 = rxPhoneNumber.value.length == 10;

    if (cond1 && cond2) {
      FocusManager.instance.primaryFocus?.unfocus();
      unawaited(sendOTPAPICall());
    } else {}
    return;
  }

  void updatePhoneNo(String value) {
    rxPhoneNumber(value);
    return;
  }

  void updateAppSignature(String value) {
    rxAppSignature(value);
    return;
  }

  String formValidate() {
    String reason = "";
    final bool cond1 = rxPhoneNumber.value.isNotEmpty;
    final bool cond2 = rxPhoneNumber.value.length == 10;
    if (!cond1) {
      reason = "Please enter your phone number.";
    } else if (!cond2) {
      reason = "Please enter your valid phone number.";
    } else {}
    return reason;
  }

  Future<void> sendOTPAPICall() async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "auth/send-otp",
      body: <String, dynamic>{
        "phoneNumber": "+91${rxPhoneNumber.value.trim()}",
        // "appSignature": rxAppSignature.value.trim(),
      },
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(
          title: "Yay!",
          message: json["message"],
        );

        await AppTextbee().sendSMS(
          body: <String, dynamic>{
            "phoneNumber": "+91${rxPhoneNumber.value.trim()}",
            "appSignature": rxAppSignature.value.trim(),
          },
        );

        await AppNavService().pushNamed(
          destination: AppRoutes().otpScreen,
          arguments: <String, dynamic>{
            "phoneNumber": rxPhoneNumber.value,
            "appSignature": rxAppSignature.value,
          },
        );
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
}
