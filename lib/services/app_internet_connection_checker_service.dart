import "dart:async";

import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:internet_connection_checker/internet_connection_checker.dart";

class AppNetCheckService extends GetxService {
  factory AppNetCheckService() {
    return _singleton;
  }

  AppNetCheckService._internal();
  static final AppNetCheckService _singleton = AppNetCheckService._internal();

  final InternetConnectionChecker instance = InternetConnectionChecker();
  late StreamSubscription<InternetConnectionStatus> subscription;

  bool isInitial = true;

  @override
  void onInit() {
    super.onInit();

    subscription = instance.onStatusChange.listen(
      (InternetConnectionStatus event) {
        final bool hasConnection = event == InternetConnectionStatus.connected;
        if (isInitial) {
          isInitial = false;
        } else {
          hasConnection
              ? AppSnackbar().snackbarSuccess(
                  title: "Connectivity Update",
                  message: "Data connection is available.",
                  inMaterialBanner: true,
                )
              : AppSnackbar().snackbarWarning(
                  title: "Connectivity Update",
                  message: "You are disconnected from the internet.",
                  inMaterialBanner: true,
                );
        }
      },
    );
  }

  @override
  void onClose() {
    unawaited(subscription.cancel());

    super.onClose();
  }

  Future<bool> hasConnection() async {
    final bool value = await instance.hasConnection;
    AppLogger().info(message: "hasConnection: $value");
    return Future<bool>.value(value);
  }
}
