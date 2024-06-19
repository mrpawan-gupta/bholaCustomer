import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_lottie_widget.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";

class AppIntroBottomSheet {
  factory AppIntroBottomSheet() {
    return _singleton;
  }

  AppIntroBottomSheet._internal();
  static final AppIntroBottomSheet _singleton = AppIntroBottomSheet._internal();

  Future<void> openNotificationSheet({
    required Function() onContinue,
  }) async {
    await Get.bottomSheet(
      Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  AppLanguageKeys().strActionPerform.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppLottieWidget(
                    path: AppConstants().custNotificationLottie,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    repeat: true,
                    onLoaded: (LottieComposition composition) async {},
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().custNotificationTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().custNotificationBody,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: AppElevatedButton(
                      text: "Continue",
                      onPressed: () {
                        AppNavService().pop();

                        onContinue();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().commonNote,
                    style: Theme.of(Get.context!).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 48),
              ],
            ),
          );
        },
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
      enableDrag: true,
    );
    return Future<void>.value();
  }

  Future<void> openLocationSheet({
    required Function() onContinue,
  }) async {
    await Get.bottomSheet(
      Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  AppLanguageKeys().strActionPerform.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppLottieWidget(
                    path: AppConstants().custLocationLottie,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    repeat: true,
                    onLoaded: (LottieComposition composition) async {},
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().custLocationTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().custLocationBody,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: AppElevatedButton(
                      text: "Continue",
                      onPressed: () {
                        AppNavService().pop();

                        onContinue();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().commonNote,
                    style: Theme.of(Get.context!).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 48),
              ],
            ),
          );
        },
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
      enableDrag: true,
    );
    return Future<void>.value();
  }

  Future<void> openCamMicStorageSheet({
    required Function() onContinue,
  }) async {
    await Get.bottomSheet(
      Builder(
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  AppLanguageKeys().strActionPerform.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppLottieWidget(
                    path: AppConstants().custCamMicStorageLottie,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    repeat: true,
                    onLoaded: (LottieComposition composition) async {},
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().custCamMicStorageTitle,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().custCamMicStorageBody,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    height: 50,
                    child: AppElevatedButton(
                      text: "Continue",
                      onPressed: () {
                        AppNavService().pop();

                        onContinue();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppConstants().commonNote,
                    style: Theme.of(Get.context!).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 48),
              ],
            ),
          );
        },
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
      enableDrag: true,
    );
    return Future<void>.value();
  }
}
