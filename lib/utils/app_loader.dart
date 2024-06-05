import "package:customer/utils/app_colors.dart";
import "package:flutter/widgets.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:get/get.dart";
import "package:loader_overlay/loader_overlay.dart";

class AppLoader {
  factory AppLoader() {
    return _singleton;
  }

  AppLoader._internal();
  static final AppLoader _singleton = AppLoader._internal();

  Widget globalLoaderOverlay({required Widget child}) {
    return GlobalLoaderOverlay(
      // closeOnBackButton: true,
      useDefaultLoading: false,
      overlayWidgetBuilder: (Object? progress) {
        return SpinKitCircle(color: AppColors().appPrimaryColor);
      },
      child: child,
    );
  }

  bool isLoaderVisible() {
    return Get.key.currentState?.context.loaderOverlay.visible ?? false;
  }

  void showLoader() {
    final bool value = isLoaderVisible();
    if (value) {
    } else {
      Get.key.currentState?.context.loaderOverlay.show();
    }
    return;
  }

  void hideLoader() {
    final bool value = isLoaderVisible();
    if (value) {
      Get.key.currentState?.context.loaderOverlay.hide();
    } else {}
    return;
  }
}
