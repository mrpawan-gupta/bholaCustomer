import "package:customer/services/app_analytics_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";

class AppNavService extends GetxService {
  factory AppNavService() {
    return _singleton;
  }

  AppNavService._internal();
  static final AppNavService _singleton = AppNavService._internal();

  String previousRoute = "/";

  Future<void> pushNamed({
    required String destination,
    required Map<String, dynamic> arguments,
  }) async {
    await Get.key.currentState?.pushNamed(destination, arguments: arguments);
    return Future<void>.value();
  }

  Future<void> pushNamedAndRemoveUntil({
    required String destination,
    required Map<String, dynamic> arguments,
  }) async {
    await Get.key.currentState?.pushNamedAndRemoveUntil(
      destination,
      arguments: arguments,
      (Route<dynamic> route) {
        return false;
      },
    );
    return Future<void>.value();
  }

  void pop([Object? result]) {
    final bool canPop = Get.key.currentState?.canPop() ?? false;
    if (canPop) {
      Get.key.currentState?.pop(result);
    } else {}
    return;
  }

  Future<void> observer(Routing? routing) async {
    if (routing != null) {
      previousRoute = routing.previous;

      final String current = routing.current;
      final dynamic args = routing.args;

      AppLogger().info(message: "Current route:: screen: $current args: $args");

      await AppAnalyticsService().logScreenView(
        current: routing.current,
        args: routing.args,
      );
    } else {
      AppLogger().error(message: "Routing is null");
    }
    return Future<void>.value();
  }
}
