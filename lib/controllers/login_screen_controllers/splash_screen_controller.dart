import "dart:async";

import "package:customer/services/app_fcm_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_session.dart";
import "package:get/get.dart";

class SplashScreenController extends GetxController {
  Future<void> furtherProcedure() async {
    final String route = AppFCMService().route;
    final String arguments = AppFCMService().arguments;
    final bool hasLoggedIn = AppSession().isUserLoggedIn();

    if (route.isEmpty && !hasLoggedIn) {
      await AppNavService().pushNamedAndRemoveUntil(
        // destination: AppRoutes().languageSelectionScreen,
        destination: await AppSession().initialRoute(),
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
        // destination: AppRoutes().languageSelectionScreen,
        destination: await AppSession().initialRoute(),
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
