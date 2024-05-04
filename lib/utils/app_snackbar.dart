import "package:awesome_snackbar_content/awesome_snackbar_content.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_logger.dart";
import "package:get/get.dart";

class AppSnackbar {
  factory AppSnackbar() {
    return _singleton;
  }

  AppSnackbar._internal();
  static final AppSnackbar _singleton = AppSnackbar._internal();

  void snackbarSuccess({required String title, required String message}) {
    AppLogger().info(message: message);

    final GetSnackBar snackbar = GetSnackBar(
      backgroundColor: AppColors().appTransparentColor,
      messageText: content(
        title: title,
        message: message,
        contentType: ContentType.success,
      ),
      duration: AppConstants().duration,
      onTap: (GetSnackBar snack) {},
    );

    Get.showSnackbar(snackbar);
    return;
  }

  void snackbarFailure({required String title, required String message}) {
    AppLogger().info(message: message);

    final GetSnackBar snackbar = GetSnackBar(
      backgroundColor: AppColors().appTransparentColor,
      messageText: content(
        title: title,
        message: message,
        contentType: ContentType.failure,
      ),
      duration: AppConstants().duration,
      onTap: (GetSnackBar snack) {},
    );

    Get.showSnackbar(snackbar);
    return;
  }

  void snackbarHelp({required String title, required String message}) {
    AppLogger().info(message: message);

    final GetSnackBar snackbar = GetSnackBar(
      backgroundColor: AppColors().appTransparentColor,
      messageText: content(
        title: title,
        message: message,
        contentType: ContentType.help,
      ),
      duration: AppConstants().duration,
      onTap: (GetSnackBar snack) {},
    );

    Get.showSnackbar(snackbar);
    return;
  }

  void snackbarWarning({required String title, required String message}) {
    AppLogger().info(message: message);

    final GetSnackBar snackbar = GetSnackBar(
      backgroundColor: AppColors().appTransparentColor,
      messageText: content(
        title: title,
        message: message,
        contentType: ContentType.warning,
      ),
      duration: AppConstants().duration,
      onTap: (GetSnackBar snack) {},
    );

    Get.showSnackbar(snackbar);
    return;
  }

  AwesomeSnackbarContent content({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final AwesomeSnackbarContent snackbarContent = AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType,
    );
    return snackbarContent;
  }
}
