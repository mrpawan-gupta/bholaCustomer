// ignore_for_file: lines_longer_than_80_chars

// import "dart:async";
// import "dart:convert";
// import "dart:developer";
// import "dart:io";

// import "package:crypto/crypto.dart";
// import "package:customer/services/app_pkg_info_service.dart";
// import "package:customer/utils/app_logger.dart";
// import "package:customer/utils/app_pretty_print_json.dart";
// import "package:flutter/foundation.dart";
// import "package:phonepe_payment_sdk/phonepe_payment_sdk.dart";

// // ignore: constant_identifier_names
// enum Environment { SANDBOX, PRODUCTION }

// class PhonePeSDKService {
//   factory PhonePeSDKService() {
//     return _singleton;
//   }

//   PhonePeSDKService._internal();
//   static final PhonePeSDKService _singleton = PhonePeSDKService._internal();

//   final String _environment = Environment.SANDBOX.name;
//   final bool _enableLogging = true;

//   // Test
//   final String? _appId = null;
//   final String _merchantId = "PGTESTPAYUAT97";

//   // Real
//   // final String _appId = "";
//   // final String _merchantId = "M225AAVLG7V05";

//   Future<bool> init() async {
//     final Completer<bool> completer = Completer<bool>();
//     bool value = false;

//     try {
//       value = await PhonePePaymentSdk.init(
//         _environment,
//         _appId,
//         _merchantId,
//         _enableLogging,
//       );

//       AppLogger().info(message: "PhonePe init(): $value");
//     } on TimeoutException catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught: ${error.message}",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } on SocketException catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught: ${error.message}",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}

//     completer.complete(value);
//     return completer.future;
//   }

//   Future<(bool, String)> startTransaction({
//     required String body,
//     required String checksum,
//   }) async {
//     final Completer<(bool, String)> completer = Completer<(bool, String)>();
//     (bool, String) value = (false, "");

//     try {
//       Map<dynamic, dynamic> map = <dynamic, dynamic>{};
//       map = await PhonePePaymentSdk.startTransaction(
//             body,
//             getAppSchema,
//             checksum,
//             packageName,
//           ) ??
//           <dynamic, dynamic>{};

//       AppLogger().info(message: "PhonePe startTransaction(): $map");

//       final Map<String, dynamic> prettyPrint = Map<String, dynamic>.from(map);
//       final String prettyOutput = AppPrettyPrintJSON().prettyPrint(prettyPrint);
//       log(prettyOutput);

//       if (map.isNotEmpty) {
//         final String status = map.containsKey("status") ? (map["status"]) : "";
//         final String error = map.containsKey("error") ? (map["error"]) : "";

//         value = (
//           status == "SUCCESS",
//           status == "SUCCESS"
//               ? "Flow Completed - Status: Success!"
//               : "Flow Completed - Status: $status and Error: $error"
//         );
//       } else {
//         value = (false, "Flow Incomplete");
//       }
//     } on TimeoutException catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught: ${error.message}",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } on SocketException catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught: ${error.message}",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}

//     completer.complete(value);
//     return completer.future;
//   }

//   String get getAppSchema {
//     return Platform.isAndroid
//         ? kReleaseMode
//             ? "ahinsaaggregatorCustomer://bhola.org.in"
//             : "ahinsaaggregatorCustomer://dev.bhola.org.in"
//         : Platform.isIOS
//             ? kReleaseMode
//                 ? "com.PhonePe-iOS-Intent-SDK-Integration"
//                 : "com.PhonePe-iOS-Intent-SDK-Integration"
//             : "";
//   }

//   String get packageName {
//     return AppPkgInfoService().packageInfo.packageName;
//   }
// }

// // Test
// String getBody({required num amount}) {
//   final String string = '''
// {
//   "merchantId": "PGTESTPAYUAT97",
//   "merchantTransactionId": "MT7850590068188104",
//   "merchantUserId": "MUID123",
//   "amount": ${amount.toInt() * 100},
//   "redirectUrl": "https://webhook.site/redirect-url",
//   "redirectMode": "REDIRECT",
//   "callbackUrl": "https://webhook.site/callback-url",
//   "mobileNumber": "9999999999",
//   "paymentInstrument": {
//     "type": "PAY_PAGE"
//   }
// }''';
//   final String value = encodeStringToBase64(decodedString: string);
//   return value;
// }

// String getChecksumCalculation({required num amount}) {
//   final String base64Body = getBody(amount: amount);
//   const String apiEndPoint = "/pg/v1/pay";
//   const String salt = "5bb51303-f908-43be-b6ed-515c12fb63b6";
//   final String sha = stringToSHA256(string: base64Body + apiEndPoint + salt);
//   final String value = "$sha###1";
//   return value;
// }

// String encodeStringToBase64({required String decodedString}) {
//   final List<int> encodedUnits = decodedString.codeUnits;
//   final String encodedString = base64.encode(encodedUnits);
//   return encodedString;
// }

// String decodeBase64toString({required String encodedString}) {
//   final List<int> decodedint = base64.decode(encodedString);
//   final String decodedstring = utf8.decode(decodedint);
//   return decodedstring;
// }

// String stringToSHA256({required String string}) {
//   final List<int> appleInBytes = utf8.encode(string);
//   final Digest value = sha256.convert(appleInBytes);
//   return value.toString();
// }
