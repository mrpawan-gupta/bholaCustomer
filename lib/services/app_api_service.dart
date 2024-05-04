import "dart:developer";

import "package:customer/services/app_internet_connection_checker_service.dart";
import "package:customer/utils/app_loader.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_pretty_print_json.dart";
import "package:get/get.dart";

/* 
  Sample:

  await AppAPIService().functionGet(
    endPoint: "users/1",
    query: <String, dynamic>{}, 
    body: <String, dynamic>{},
    successCallback: (Map<String, dynamic> json) {},
    failureCallback: (Map<String, dynamic> json) {},
    needLoader: true,
  );
 */

class AppAPIService extends GetConnect {
  factory AppAPIService() {
    return _singleton;
  }

  AppAPIService._internal();
  static final AppAPIService _singleton = AppAPIService._internal();

  final String baseURL = "https://vpnapi.io/api/";
  final String contentType = "application/json";

  Map<String, String> getHeaders() {
    return <String, String>{"Authorization": ""};
  }

  Future<void> functionGet({
    required String endPoint,
    required Map<String, dynamic> query,
    required Map<String, dynamic> body,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    bool needLoader = false,
  }) async {
    final String fullURL = "$baseURL$endPoint";
    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Response<dynamic> response = await get(
            fullURL,
            contentType: contentType,
            headers: getHeaders(),
            query: query,
          );
          postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );
          failureCallback(<String, dynamic>{"message": error});
        } finally {}

        if (needLoader) {
          AppLoader().hideLoader();
        } else {}
      },
    );
    return Future<void>.value();
  }

  Future<void> functionPost({
    required String endPoint,
    required Map<String, dynamic> query,
    required Map<String, dynamic> body,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    bool needLoader = false,
  }) async {
    final String fullURL = "$baseURL$endPoint";
    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Response<dynamic> response = await post(
            fullURL,
            body,
            contentType: contentType,
            headers: getHeaders(),
            query: query,
          );
          postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );
          failureCallback(<String, dynamic>{"message": error});
        } finally {}

        if (needLoader) {
          AppLoader().hideLoader();
        } else {}
      },
    );
    return Future<void>.value();
  }

  Future<void> preAPICallProcedure({
    required String fullURL,
    required Function() continueCallback,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
  }) async {
    final bool isValidURL = fullURL.isURL;
    if (isValidURL) {
      final bool hasConnection = await AppNetCheckService().hasConnection();
      if (hasConnection) {
        AppLogger().info(message: "Proceed for an API Request");
        continueCallback();
      } else {
        AppLogger().error(message: "No Internet");
        failureCallback(<String, dynamic>{"message": "No Internet"});
      }
    } else {
      AppLogger().error(message: "URL is invalid");
      failureCallback(<String, dynamic>{"message": "URL is invalid"});
    }
  }

  void postAPICallProcedure({
    required Response<dynamic> response,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
  }) {
    final int statusCode = response.statusCode ?? 0;
    final String statusText = response.statusText ?? "";
    if (response.isOk) {
      if (response.body is Map<String, dynamic>) {
        AppLogger().info(message: "API Success: ${response.body}");

        log(AppPrettyPrintJSON().prettyPrint(response.body));

        successCallback(response.body);
      } else {
        AppLogger().error(message: "Response Type Mismatch: ${response.body}");
        failureCallback(<String, dynamic>{"message": response.body});
      }
    } else if (response.hasError) {
      AppLogger().error(message: "$statusCode: $statusText");
      failureCallback(<String, dynamic>{"message": "$statusCode: $statusText"});
    } else if (response.unauthorized) {
      AppLogger().error(message: "unauthorized");
      failureCallback(<String, dynamic>{"message": "unauthorized"});
    } else {
      AppLogger().error(message: "Something went wrong");
      failureCallback(<String, dynamic>{"message": "Something went wrong"});
    }
    return;
  }
}
