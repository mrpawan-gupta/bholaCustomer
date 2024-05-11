import "dart:async";

import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_session.dart";
import "package:get/get.dart";

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    unawaited(furtherProceure());
  }

  Future<void> furtherProceure() async {
    await Future<void>.delayed(const Duration(seconds: 3));

    AppSession().isUserLoggedIn()
        ? AppSession().performSignIn()
        : await AppNavService().pushNamedAndRemoveUntil(
            destination: AppSession().initialRoute(),
            arguments: <String, dynamic>{},
          );
    return Future<void>.value();
  }
}
