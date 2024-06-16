// import "dart:developer";

// import "package:customer/models/textbee_model.dart";
// import "package:customer/services/app_api_service.dart";
// import "package:customer/utils/app_constants.dart";
// import "package:customer/utils/app_logger.dart";
// import "package:customer/utils/app_pretty_print_json.dart";
// import "package:get/get.dart";

// class AppTextbee extends GetxService {
//   factory AppTextbee() {
//     return _singleton;
//   }

//   AppTextbee._internal();
//   static final AppTextbee _singleton = AppTextbee._internal();

//   Future<void> sendSMS({required Map<String, dynamic> body}) async {
//     try {
//       final Map<String, String> headers = <String, String>{
//         "x-api-key": AppConstants().textbeeKey,
//       };
//       final Response<dynamic> response = await AppAPIService().post(
//         "https://api.textbee.dev/api/v1/gateway/devices/665f09ae3d552f16137fcb02/sendSMS",
//         <String, dynamic>{
//           "recipients": <String>[body["phoneNumber"]],
//           "message": "Your Bhola App code is: 111111\n${body["appSignature"]}",
//         },
//         headers: headers,
//       );

//       if (response.isOk && response.body is Map<String, dynamic>) {
//         final String temp = AppPrettyPrintJSON().prettyPrint(response.body);
//         log("sendSMS(): response.body: $temp");

//         TextbeeModel model = TextbeeModel();
//         model = TextbeeModel.fromJson(response.body);
//         log("sendSMS(): model: ${model.toJson()}");
//       } else {}
//     } on Exception catch (error, stackTrace) {
//       AppLogger().error(
//         message: "Exception caught",
//         error: error,
//         stackTrace: stackTrace,
//       );
//     } finally {}
//     return Future<void>.value();
//   }
// }
