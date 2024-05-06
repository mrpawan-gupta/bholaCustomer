import "package:customer/utils/app_logger.dart";
import "package:firebase_analytics/firebase_analytics.dart";
import "package:get/get.dart";

class AppAnalyticsService extends GetxService {
  factory AppAnalyticsService() {
    return _singleton;
  }

  AppAnalyticsService._internal();
  static final AppAnalyticsService _singleton = AppAnalyticsService._internal();

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver firebaseAnalyticsObserver() {
    final FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
      analytics: analytics,
    );
    AppLogger().info(message: "firebaseAnalyticsObserver() started");
    return observer;
  }

  Future<void> logScreenView({
    required String current,

    // ignore: avoid_annotating_with_dynamic
    required dynamic args,
  }) async {
    try {
      await analytics.logScreenView(
        screenName: current,
        parameters: args,
      );
      AppLogger().info(message: "logScreenView:: screen: $current args: $args");
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return Future<void>.value();
  }
}
