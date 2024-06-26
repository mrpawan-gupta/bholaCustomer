import "package:logger/logger.dart";

class AppLogger {
  factory AppLogger() {
    return _singleton;
  }

  AppLogger._internal();
  static final AppLogger _singleton = AppLogger._internal();

  final Logger logger = Logger();

  void trace({required String message, Object? error, StackTrace? stackTrace}) {
    logger.t(message, error: error, stackTrace: stackTrace);
    return;
  }

  void debug({required String message, Object? error, StackTrace? stackTrace}) {
    logger.d(message, error: error, stackTrace: stackTrace);
    return;
  }

  void info({required String message, Object? error, StackTrace? stackTrace}) {
    logger.i(message, error: error, stackTrace: stackTrace);
    return;
  }

  void warn({required String message, Object? error, StackTrace? stackTrace}) {
    logger.w(message, error: error, stackTrace: stackTrace);
    return;
  }

  void error({required String message, Object? error, StackTrace? stackTrace}) {
    logger.e(message, error: error, stackTrace: stackTrace);
    return;
  }

  void fatal({required String message, Object? error, StackTrace? stackTrace}) {
    logger.f(message, error: error, stackTrace: stackTrace);
    return;
  }
}
