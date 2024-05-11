import "dart:async";
import "dart:developer";

import "package:customer/services/app_internet_connection_checker_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_loader.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_pretty_print_json.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/localization/app_translations.dart";
import "package:flutter/material.dart";
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

enum Types { oauth, rental, order }

class AppAPIService extends GetConnect {
  factory AppAPIService() {
    return _singleton;
  }

  AppAPIService._internal();
  static final AppAPIService _singleton = AppAPIService._internal();

  final String baseURL =
      "http://ec2-3-6-38-211.ap-south-1.compute.amazonaws.com";
  final String middleware = "api";

  final String contentTypeApplicationJson = "application/json";
  final String contentTypeMultiPartFormData = "multipart/form-data";

  @override
  void onInit() {
    super.onInit();

    baseUrl = baseURL;
    timeout = const Duration(seconds: 30);
    maxAuthRetries = 3;
  }

  Map<String, String> getHeaders() {
    final String auth = AppStorageService().getUserAuthModel().token ?? "";
    final Locale locale = AppStorageService().getUserLangFromStorage();
    final String actLng = AppTranslations().localeToDashString(locale: locale);
    return <String, String>{
      "Authorization": "Bearer $auth",
      "Accept-Language": actLng,
    };
  }

  Future<void> functionGet({
    required Types types,
    required String endPoint,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    Map<String, dynamic> query = const <String, dynamic>{},
    Map<String, dynamic> body = const <String, dynamic>{},
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL = "$baseURL/${types.name}/$middleware/$version/$endPoint/";
    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: query,
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await get(
            fullURL,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: query,
          );
          await postAPICallProcedure(
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
    required Types types,
    required String endPoint,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    Map<String, dynamic> query = const <String, dynamic>{},
    Map<String, dynamic> body = const <String, dynamic>{},
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL = "$baseURL/${types.name}/$middleware/$version/$endPoint/";
    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: query,
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await post(
            fullURL,
            !isForFileUpload ? body : formData,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: query,
          );
          await postAPICallProcedure(
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

  Future<void> functionPut({
    required Types types,
    required String endPoint,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    Map<String, dynamic> query = const <String, dynamic>{},
    Map<String, dynamic> body = const <String, dynamic>{},
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL = "$baseURL/${types.name}/$middleware/$version/$endPoint/";
    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: query,
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await put(
            fullURL,
            !isForFileUpload ? body : formData,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: query,
          );
          await postAPICallProcedure(
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

  Future<void> functionPatch({
    required Types types,
    required String endPoint,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    Map<String, dynamic> query = const <String, dynamic>{},
    Map<String, dynamic> body = const <String, dynamic>{},
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL = "$baseURL/${types.name}/$middleware/$version/$endPoint/";
    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: query,
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await patch(
            fullURL,
            !isForFileUpload ? body : formData,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: query,
          );
          await postAPICallProcedure(
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

  Future<void> functionDelete({
    required Types types,
    required String endPoint,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    Map<String, dynamic> query = const <String, dynamic>{},
    Map<String, dynamic> body = const <String, dynamic>{},
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL = "$baseURL/${types.name}/$middleware/$version/$endPoint/";
    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        if (needLoader) {
          AppLoader().showLoader();
        } else {}

        try {
          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: query,
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await delete(
            fullURL,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: query,
          );
          await postAPICallProcedure(
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

  void requestPrinter({
    required String endPoint,
    required String fullURL,
    required Map<String, dynamic> headers,
    required Map<String, dynamic> query,
    required Map<String, dynamic> body,
    required FormData formData,
  }) {
    final String pretyHeaders = AppPrettyPrintJSON().prettyPrint(headers);
    final String pretyQuery = AppPrettyPrintJSON().prettyPrint(query);
    final String pretBody = AppPrettyPrintJSON().prettyPrint(body);
    log("endPoint: $endPoint");
    log("fullURL: $fullURL");
    log("headers: $pretyHeaders");
    log("query: $pretyQuery");
    log("body: $pretBody");
    log("formData: ${formData.fields}");
    return;
  }

  Future<void> postAPICallProcedure({
    required Response<dynamic> response,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
  }) async {
    final int statusCode = response.statusCode ?? 0;
    final String statusText = response.statusText ?? "";
    const String message = "Something went wrong";
    const String loginAgainMessage = "$message, Please Login Again";

    if (response.isOk) {
      if (response.body is Map<String, dynamic>) {
        AppLogger().info(message: "API Success: ${response.body}");
        log(AppPrettyPrintJSON().prettyPrint(response.body));
        successCallback(response.body);
      } else {
        AppLogger().error(message: "Response Type Mismatch: ${response.body}");
        failureCallback(<String, dynamic>{"message": response.body});
      }
    } else if (response.unauthorized || statusCode == 403) {
      AppLogger().error(message: "$statusCode: $statusText");
      failureCallback(<String, dynamic>{"message": loginAgainMessage});

      await AppSession().performSignOut();
    } else {
      if (statusCode >= 500 || response.body is String) {
        AppLogger().error(message: "$statusCode: $statusText");
        failureCallback(<String, dynamic>{"message": message});
      } else {
        if (response.body is Map<String, dynamic>) {
          final Map<String, dynamic> responseBody = response.body;
          final bool status = responseBody["status"] ?? false;
          final String error = responseBody["message"] ?? "";

          AppLogger().error(message: "$status: $error");
          failureCallback(<String, dynamic>{"message": error});
        } else {
          AppLogger().error(message: "$statusCode: $statusText");
          failureCallback(<String, dynamic>{"message": message});
        }
      }
    }
    return Future<void>.value();
  }
}
