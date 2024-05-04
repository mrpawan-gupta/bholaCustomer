import "package:flutter/foundation.dart";
import "package:logger/logger.dart";

class AppLogger {
  factory AppLogger() {
    return _singleton;
  }

  AppLogger._internal();
  static final AppLogger _singleton = AppLogger._internal();

  final Logger logger = Logger();

  void trace({required String message, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.t(message, error: error, stackTrace: stackTrace);
    } else {}
    return;
  }

  void debug({required String message, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.d(message, error: error, stackTrace: stackTrace);
    } else {}
    return;
  }

  void info({required String message, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.i(message, error: error, stackTrace: stackTrace);
    } else {}
    return;
  }

  void warn({required String message, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.w(message, error: error, stackTrace: stackTrace);
    } else {}
    return;
  }

  void error({required String message, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.e(message, error: error, stackTrace: stackTrace);
    } else {}
    return;
  }

  void fatal({required String message, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      logger.f(message, error: error, stackTrace: stackTrace);
    } else {}
    return;
  }
}
