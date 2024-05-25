import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:overlay_support/overlay_support.dart";

class AppSnackbar {
  factory AppSnackbar() {
    return _singleton;
  }

  AppSnackbar._internal();
  static final AppSnackbar _singleton = AppSnackbar._internal();

  final Duration duration = const Duration(seconds: 4);

  void snackbarSuccess({required String title, required String message}) {
    AppLogger().info(message: message);

    showOverlayNotification(title: title, message: message, type: "Success");
    return;
  }

  void snackbarFailure({required String title, required String message}) {
    AppLogger().info(message: message);

    showOverlayNotification(title: title, message: message, type: "Failure");
    return;
  }

  void snackbarHelp({required String title, required String message}) {
    AppLogger().info(message: message);

    showOverlayNotification(title: title, message: message, type: "Help");
    return;
  }

  void snackbarWarning({required String title, required String message}) {
    AppLogger().info(message: message);

    showOverlayNotification(title: title, message: message, type: "Warning");
    return;
  }

  void showOverlayNotification({
    required String title,
    required String message,
    required String type,
  }) {
    Color color = AppColors().appTransparentColor;
    switch (type) {
      case "Success":
        color = AppColors().appPrimaryColor;
        break;
      case "Failure":
        color = AppColors().appRedColor;
        break;
      case "Help":
        color = AppColors().appBlueColor;
        break;
      case "Warning":
        color = AppColors().appOrangeColor;
        break;
      default:
        break;
    }
    showSimpleNotification(
      const SizedBox(),
      context: Get.context,
      elevation: AppConstants().elevation,
      foreground: Theme.of(Get.context!).scaffoldBackgroundColor,
      background: color,
      subtitle: ListTile(
        dense: true,
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          message,
          style: const TextStyle(fontSize: 16),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      duration: duration,
      slideDismissDirection: DismissDirection.horizontal,
    );
    return;
  }
}
