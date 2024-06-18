import "dart:async";

import "package:customer/services/app_fcm_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

class SplashScreenController extends GetxController {
  Future<bool> askForLocationPermission() async {
    final bool value = await AppPermService().permissionLocation();
    return Future<bool>.value(value);
  }

  Future<bool> askForLocationService() async {
    final bool value = await AppPermService().serviceLocation();
    return Future<bool>.value(value);
  }

  Future<String> permissionValidate() async {
    String reason = "";
    final bool cond1 = await askForLocationPermission();
    final bool cond2 = await askForLocationService();
    if (!cond1) {
      reason = "App requires Location permission.";
    } else if (!cond2) {
      reason = "App requires Location service to be enabled.";
    } else {}
    return Future<String>.value(reason);
  }

  Future<void> startupProcedure({required Function() showPopup}) async {
    // final String reason = await permissionValidate();
    const String reason = "";
    if (reason.isEmpty) {
      await furtherProcedure();
    } else {
      AppSnackbar().snackbarFailure(title: "Oops", message: reason);
      showPopup();
    }
    return Future<void>.value();
  }

  Future<void> furtherProcedure() async {
    final String route = AppFCMService().route;
    final String arguments = AppFCMService().arguments;
    final bool hasLoggedIn = AppSession().isUserLoggedIn();

    if (route.isEmpty && !hasLoggedIn) {
      await AppNavService().pushNamedAndRemoveUntil(
        destination: AppRoutes().languageSelectionScreen,
        arguments: <String, dynamic>{},
      );
    } else if (route.isEmpty && hasLoggedIn) {
      await AppSession().performSignIn();
    } else if (route.isNotEmpty && hasLoggedIn) {
      await AppNavService().pushNamed(
        destination: route,
        arguments: arguments.isEmpty
            ? <String, dynamic>{}
            : <String, dynamic>{"id": arguments},
      );
      await AppSession().performSignIn();
    } else if (route.isNotEmpty && !hasLoggedIn) {
      await AppNavService().pushNamedAndRemoveUntil(
        destination: AppRoutes().languageSelectionScreen,
        arguments: arguments.isEmpty
            ? <String, dynamic>{}
            : <String, dynamic>{"id": arguments},
      );
    } else {}

    AppFCMService().route = "";
    AppFCMService().arguments = "";
    return Future<void>.value();
  }
}
