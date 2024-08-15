import "dart:io";

import "package:customer/app_config.dart";
import "package:customer/common_functions/dependencies_injection.dart";
import "package:customer/firebase_options_dev.dart";
import "package:customer/my_app.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/my_http_overrides.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@pragma("vm:entry-point")
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  return Future<void>.value();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SecurityContext.defaultContext.allowLegacyUnsafeRenegotiation = true;
  HttpOverrides.global = MyHttpOverrides();

  final FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(options: options);

  if (kReleaseMode) {
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      AppLogger().error(
        message: "FlutterError.onError: ${errorDetails.exceptionAsString()}",
        error: errorDetails.exception,
        stackTrace: errorDetails.stack,
      );
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      AppLogger().error(
        message: "PlatformDispatcher.instance.onError",
        error: error,
        stackTrace: stack,
      );
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } else {}

  AppConfig().init();
  injectDependencies();
  await initDependencies();

  runApp(const MyApp());
}
