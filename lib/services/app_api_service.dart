import "dart:async";
import "dart:developer";
import "dart:io";

import "package:customer/services/app_internet_connection_checker_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_loader.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_pretty_print_json.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/localization/app_translations.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

enum Types { oauth, rental, order }

class AppAPIService extends GetConnect {
  factory AppAPIService() {
    return _singleton;
  }

  AppAPIService._internal();
  static final AppAPIService _singleton = AppAPIService._internal();

  final String baseURL = AppConstants().baseURL;
  final String middleware = "api";

  final String contentTypeApplicationJson = "application/json";
  final String contentTypeMultiPartFormData = "multipart/form-data";

  @override
  void onInit() {
    super.onInit();

    timeout = const Duration(minutes: 10);
    maxAuthRetries = 3;

    AppLogger().info(message: "AppAPIService: onInit(): ${timeout.inSeconds}");
  }

  Map<String, String> getHeaders() {
    final String auth = AppStorageService().getUserAuthModel().token ?? "";
    final Locale locale = AppStorageService().getUserLangFromStorage();
    final String actLng = AppTranslations().localeToDashString(locale: locale);

    return <String, String>{
      "Authorization": "Bearer $auth",
      "Accept-Language": actLng,
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=600, max=1000",
      "Accept-Encoding": "gzip, deflate, br",
    };
  }

  Map<String, dynamic> getValidQuery(Map<String, dynamic> query) {
    final Map<String, dynamic> parsedQuery =
        !mapEquals(query, <String, dynamic>{})
            ? query.map(
                // ignore: avoid_annotating_with_dynamic
                (String key, dynamic value) {
                  return MapEntry<String, dynamic>(key, value.toString());
                },
              )
            : <String, dynamic>{};
    return parsedQuery;
  }

  Future<void> functionGet({
    required Types types,
    required String endPoint,
    required Function(Map<String, dynamic> json) successCallback,
    required Function(Map<String, dynamic> json) failureCallback,
    Map<String, dynamic> query = const <String, dynamic>{},

    // ignore: avoid_annotating_with_dynamic
    dynamic body,
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL =
        "$baseURL/${types.name}/$middleware/$version/$endPoint/";

    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        try {
          if (needLoader) {
            AppLoader().showLoader();
          } else {}

          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: getValidQuery(query),
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await get(
            fullURL,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: getValidQuery(query),
          ).timeout(
            const Duration(minutes: 10),
            onTimeout: () async {
              if (needLoader) {
                AppLoader().hideLoader();
              } else {}

              failureCallback(<String, dynamic>{"message": "Request Timeout"});

              return const Response<dynamic>(
                statusCode: 408,
                statusText: "Request Timeout",
              );
            },
          );

          await postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        } on TimeoutException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on SocketException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error});
        } finally {
          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        }
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

    // ignore: avoid_annotating_with_dynamic
    dynamic body,
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL =
        "$baseURL/${types.name}/$middleware/$version/$endPoint/";

    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        try {
          if (needLoader) {
            AppLoader().showLoader();
          } else {}

          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: getValidQuery(query),
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
            query: getValidQuery(query),
          ).timeout(
            const Duration(minutes: 10),
            onTimeout: () async {
              if (needLoader) {
                AppLoader().hideLoader();
              } else {}

              failureCallback(<String, dynamic>{"message": "Request Timeout"});

              return const Response<dynamic>(
                statusCode: 408,
                statusText: "Request Timeout",
              );
            },
          );

          await postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        } on TimeoutException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on SocketException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error});
        } finally {
          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        }
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

    // ignore: avoid_annotating_with_dynamic
    dynamic body,
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL =
        "$baseURL/${types.name}/$middleware/$version/$endPoint/";

    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        try {
          if (needLoader) {
            AppLoader().showLoader();
          } else {}

          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: getValidQuery(query),
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
            query: getValidQuery(query),
          ).timeout(
            const Duration(minutes: 10),
            onTimeout: () async {
              if (needLoader) {
                AppLoader().hideLoader();
              } else {}

              failureCallback(<String, dynamic>{"message": "Request Timeout"});

              return const Response<dynamic>(
                statusCode: 408,
                statusText: "Request Timeout",
              );
            },
          );

          await postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        } on TimeoutException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on SocketException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error});
        } finally {
          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        }
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

    // ignore: avoid_annotating_with_dynamic
    dynamic body,
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL =
        "$baseURL/${types.name}/$middleware/$version/$endPoint/";

    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        try {
          if (needLoader) {
            AppLoader().showLoader();
          } else {}

          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: getValidQuery(query),
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
            query: getValidQuery(query),
          ).timeout(
            const Duration(minutes: 10),
            onTimeout: () async {
              if (needLoader) {
                AppLoader().hideLoader();
              } else {}

              failureCallback(<String, dynamic>{"message": "Request Timeout"});

              return const Response<dynamic>(
                statusCode: 408,
                statusText: "Request Timeout",
              );
            },
          );

          await postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        } on TimeoutException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on SocketException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error});
        } finally {
          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        }
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

    // ignore: avoid_annotating_with_dynamic
    dynamic body,
    String version = "v1",
    bool needLoader = true,
    bool isForFileUpload = false,
    FormData? formData,
  }) async {
    final String fullURL =
        "$baseURL/${types.name}/$middleware/$version/$endPoint/";

    formData = formData ?? FormData(<String, dynamic>{});

    await preAPICallProcedure(
      fullURL: fullURL,
      successCallback: successCallback,
      failureCallback: failureCallback,
      continueCallback: () async {
        try {
          if (needLoader) {
            AppLoader().showLoader();
          } else {}

          final Map<String, String> headers = getHeaders();

          requestPrinter(
            endPoint: endPoint,
            fullURL: fullURL,
            headers: headers,
            query: getValidQuery(query),
            body: body,
            formData: formData!,
          );

          final Response<dynamic> response = await delete(
            fullURL,
            contentType: !isForFileUpload
                ? contentTypeApplicationJson
                : contentTypeMultiPartFormData,
            headers: headers,
            query: getValidQuery(query),
          ).timeout(
            const Duration(minutes: 10),
            onTimeout: () async {
              if (needLoader) {
                AppLoader().hideLoader();
              } else {}

              failureCallback(<String, dynamic>{"message": "Request Timeout"});

              return const Response<dynamic>(
                statusCode: 408,
                statusText: "Request Timeout",
              );
            },
          );

          await postAPICallProcedure(
            response: response,
            successCallback: successCallback,
            failureCallback: failureCallback,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        } on TimeoutException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on SocketException catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught: ${error.message}",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error.message});
        } on Exception catch (error, stackTrace) {
          AppLogger().error(
            message: "Exception caught",
            error: error,
            stackTrace: stackTrace,
          );

          if (needLoader) {
            AppLoader().hideLoader();
          } else {}

          failureCallback(<String, dynamic>{"message": error});
        } finally {
          if (needLoader) {
            AppLoader().hideLoader();
          } else {}
        }
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

    // ignore: avoid_annotating_with_dynamic
    required dynamic body,
    required FormData formData,
  }) {
    final String pretyHeaders = AppPrettyPrintJSON().prettyPrint(headers);
    final String pretyQuery = AppPrettyPrintJSON().prettyPrint(query);
    final String pretBody = body is Map<String, dynamic>
        ? AppPrettyPrintJSON().prettyPrint(body)
        : body is List<dynamic>
            ? (body).toString()
            : body ?? "";
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
