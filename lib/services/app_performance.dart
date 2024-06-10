import "dart:async";

import "package:customer/utils/app_logger.dart";
import "package:firebase_performance/firebase_performance.dart";
import "package:get/get.dart";

class AppPerformance extends GetxService {
  factory AppPerformance() {
    return _singleton;
  }

  AppPerformance._internal();
  static final AppPerformance _singleton = AppPerformance._internal();

  final FirebasePerformance performance = FirebasePerformance.instance;

  Future<void> newHttpMetric({
    required String url,
    required HttpMethod httpMethod,
    required Future<dynamic> Function() apiFunction,
  }) async {
    final HttpMetric httpMetric = performance.newHttpMetric(url, httpMethod);

    await httpMetric.start();
    AppLogger().info(message: "newHttpMetric() starting for $url");

    try {
      await apiFunction();
      AppLogger().info(message: "newHttpMetric() completed for $url");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}

    await httpMetric.stop();
    AppLogger().info(message: "newHttpMetric() ending for $url");

    return Future<void>.value();
  }

  Future<void> newTrace({
    required String traceName,
    required Future<dynamic> Function() traceFunction,
  }) async {
    final Trace trace = FirebasePerformance.instance.newTrace(traceName);

    await trace.start();
    AppLogger().info(message: "newTrace() starting for $traceName");

    try {
      await traceFunction();
      AppLogger().info(message: "newTrace() completed for $traceName");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}

    await trace.stop();
    AppLogger().info(message: "newTrace() ending for $traceName");

    return Future<void>.value();
  }
}
