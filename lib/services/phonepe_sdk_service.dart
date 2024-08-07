import "dart:async";
import "dart:io";

import "package:customer/services/app_pkg_info_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_pretty_print_json.dart";
import "package:flutter/foundation.dart";
import "package:phonepe_payment_sdk/phonepe_payment_sdk.dart";

class PhonePeSDKService {
  factory PhonePeSDKService() {
    return _singleton;
  }

  PhonePeSDKService._internal();
  static final PhonePeSDKService _singleton = PhonePeSDKService._internal();

  Future<bool> init() async {
    bool value = false;

    try {
      value = await PhonePePaymentSdk.init(
        AppConstants().phonePeEnvironment,
        AppConstants().phonePeAppId,
        AppConstants().phonePeMerchantId,
        AppConstants().phonePeEnableLogging,
      );
      AppLogger().info(message: "PhonePe init(): $value");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}

    return Future<bool>.value(value);
  }

  Future<(bool, String)> startTransaction({
    required String body,
    required String checksum,
  }) async {
    (bool, String) value = (false, "");

    try {
      Map<dynamic, dynamic> map = <dynamic, dynamic>{};
      map = await PhonePePaymentSdk.startTransaction(
            body,
            getAppSchema,
            checksum,
            packageName,
          ) ??
          <dynamic, dynamic>{};

      final Map<String, dynamic> prettyPrint = Map<String, dynamic>.from(map);
      final String prettyOutput = AppPrettyPrintJSON().prettyPrint(prettyPrint);
      AppLogger().info(message: "PhonePe startTransaction(): $prettyOutput");

      if (map.isNotEmpty) {
        final String status = map.containsKey("status") ? (map["status"]) : "";
        final String error = map.containsKey("error") ? (map["error"]) : "";
        value = (
          status == "SUCCESS",
          status == "SUCCESS"
              ? "Flow Completed - Status: Success!"
              : "Flow Completed - Status: $status and Error: $error"
        );
      } else {
        value = (false, "Flow Incomplete");
      }
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}

    return Future<(bool, String)>.value(value);
  }

  String get getAppSchema {
    return Platform.isAndroid
        ? kReleaseMode
            ? "ahinsaaggregatorCustomer://bhola.org.in"
            : "ahinsaaggregatorCustomer://dev.bhola.org.in"
        : Platform.isIOS
            ? kReleaseMode
                ? "com.PhonePe-iOS-Intent-SDK-Integration"
                : "com.PhonePe-iOS-Intent-SDK-Integration"
            : "";
  }

  String get packageName {
    return AppPkgInfoService().packageInfo.packageName;
  }
}
