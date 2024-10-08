import "package:customer/services/app_analytics_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AppNavService extends GetxService {
  factory AppNavService() {
    return _singleton;
  }

  AppNavService._internal();
  static final AppNavService _singleton = AppNavService._internal();

  String currentRoute = AppRoutes().splashScreen;
  String previousRoute = AppRoutes().splashScreen;

  Future<dynamic> push({required Widget destination}) async {
    final NavigatorState? state = Get.key.currentState;
    final dynamic result = await state?.push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return destination;
        },
      ),
    );
    return Future<dynamic>.value(result);
  }

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
      (Route<dynamic> route) {
        return false;
      },
    );
    return Future<dynamic>.value(result);
  }

  bool canPop() {
    final NavigatorState? state = Get.key.currentState;
    return state?.canPop() ?? false;
  }

  dynamic pop([Object? result]) {
    final NavigatorState? state = Get.key.currentState;
    if (canPop()) {
      state?.pop(result);
    } else {}
    return;
  }

  Future<void> observer(Routing? routing) async {
    if (routing != null) {
      currentRoute = routing.current;
      previousRoute = routing.previous;

      final dynamic args = routing.args ?? <String, dynamic>{};
      AppLogger().info(
        message: "Current route:: screen: $currentRoute args: $args",
      );

      await AppAnalyticsService().logScreenView(
        current: currentRoute,
        args: args,
      );
    } else {
      AppLogger().error(message: "Routing is null");
    }
    return Future<void>.value();
  }
}
