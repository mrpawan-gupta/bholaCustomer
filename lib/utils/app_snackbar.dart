import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_logger.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

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

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color.withOpacity(0.64),
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      colorText: Colors.white,
    );
    return;
  }
}
