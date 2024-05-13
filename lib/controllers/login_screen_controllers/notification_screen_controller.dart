import "package:customer/services/app_perm_service.dart";
import "package:get/get.dart";

class NotificationScreenController extends GetxController {
  Future<bool> askForNotificationsPermission() async {
    final bool value = await AppPermService().permissionNotification();
    return Future<bool>.value(value);
  }

  Future<bool> askForLocationPermission() async {
    final bool value = await AppPermService().permissionLocation();
    return Future<bool>.value(value);
  }

  Future<bool> askForLocationService() async {
    final bool value = await AppPermService().serviceLocation();
    return Future<bool>.value(value);
  }

  Future<String> validate() async {
    String reason = "";
    final bool cond1 = await askForNotificationsPermission();
    final bool cond2 = await askForLocationPermission();
    final bool cond3 = await askForLocationService();
    if (!cond1) {
      reason = "App requires Notifications permission.";
    } else if (!cond2) {
      reason = "App requires Location permission.";
    } else if (!cond3) {
      reason = "App requires Location service to be enabled.";
    } else {}
    return Future<String>.value(reason);
  }
}
