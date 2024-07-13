import "package:customer/services/app_analytics_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";

class AppNavService extends GetxService {
  factory AppNavService() {
    return _singleton;
  }

  AppNavService._internal();
  static final AppNavService _singleton = AppNavService._internal();

  String previousRoute = AppRoutes().splashScreen;

  Future<dynamic> pushNamed({
    required String destination,
    required Map<String, dynamic> arguments,
  }) async {
    final NavigatorState? state = Get.key.currentState;
    final dynamic result = await state?.pushNamed<dynamic>(
      destination,
      arguments: arguments,
    );
    return Future<dynamic>.value(result);
  }

  Future<dynamic> pushNamedAndRemoveUntil({
    required String destination,
    required Map<String, dynamic> arguments,
  }) async {
    final NavigatorState? state = Get.key.currentState;
    final dynamic result = await state?.pushNamedAndRemoveUntil<dynamic>(
      destination,
      arguments: arguments,
      (Route<dynamic> route) => false,
    );
    return Future<dynamic>.value(result);
  }

  dynamic pop([Object? result]) {
    final NavigatorState? state = Get.key.currentState;
    final bool canPop = state?.canPop() ?? false;
    if (canPop) {
      Get.key.currentState?.pop(result);
    } else {}
    return;
  }

  bool canPop() {
    return Get.key.currentState?.canPop() ?? false;
  }

  Future<void> observer(Routing? routing) async {
    if (routing != null) {
      previousRoute = routing.previous;
      final String current = routing.current;
      final dynamic args = routing.args ?? <String, dynamic>{};

      AppLogger().info(message: "Current route:: screen: $current args: $args");

      await AppAnalyticsService().logScreenView(current: current, args: args);
    } else {
      AppLogger().error(message: "Routing is null");
    }
    return Future<void>.value();
  }
}
