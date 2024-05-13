import "dart:async";

import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_dev_info_service.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:smart_auth/smart_auth.dart";

class PhoneNumberScreenController extends GetxController {
  final TextEditingController phoneNumberController = TextEditingController();
  final RxString rxPhoneNumber = "".obs;

  @override
  void onReady() {
    super.onReady();

    unawaited(requestHint());
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

  void unfocus({required Function() callAPI}) {
    final bool cond1 = phoneNumberController.value.text.length == 10;
    final bool cond2 = rxPhoneNumber.value.length == 10;

    if (cond1 && cond2) {
      FocusManager.instance.primaryFocus?.unfocus();
      callAPI();
    } else {}
    return;
  }

  void updatePhoneNo(String value) {
    rxPhoneNumber(value);
    return;
  }

  String validate() {
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

  Future<void> sendOTPAPICall({
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
  }) async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "auth/send-otp",
      body: <String, dynamic>{
        "phoneNumber": rxPhoneNumber.value.trim(),
      },
      successCallback: successCallback,
      failureCallback: failureCallback,
    );
    return Future<void>.value();
  }
}
