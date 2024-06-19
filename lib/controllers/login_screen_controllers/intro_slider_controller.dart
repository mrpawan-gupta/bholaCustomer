import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_constants.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class IntroSliderController extends GetxController {
  final RxInt rxTotalPages = 3.obs;
  
  final RxInt rxInitialPage = 0.obs;

  final PageController pageController = PageController();

  RxList<String> getIntroductionAnimation() {
    final List<String> list = <String>[
      AppConstants().custNotificationLottie,
      AppConstants().custLocationLottie,
      AppConstants().custCamMicStorageLottie,
    ];
    return list.obs;
  }

  RxList<String> getIntroductionTitle() {
    final List<String> list = <String>[
      AppConstants().custNotificationTitle,
      AppConstants().custLocationTitle,
      AppConstants().custCamMicStorageTitle,
    ];
    return list.obs;
  }

  RxList<String> getIntroductionDescription() {
    final List<String> list = <String>[
      AppConstants().custNotificationBody,
      AppConstants().custLocationBody,
      AppConstants().custCamMicStorageBody,
    ];
    return list.obs;
  }

  void updateInitialPage(int value) {
    rxInitialPage(value);
    return;
  }

  @override
  void onClose() {
    pageController.dispose();

    super.onClose();
  }

  Future<String> permissionValidateIndex0() async {
    String reason = "";
    final bool cond1 = await AppPermService().permissionNotification();

    if (!cond1) {
      reason = "App requires Notifications permission.";
    } else {}
    return Future<String>.value(reason);
  }

  Future<String> permissionValidateIndex1() async {
    String reason = "";

    final bool cond1 = await AppPermService().permissionLocation();
    final bool cond2 = await AppPermService().serviceLocation();
    if (!cond1) {
      reason = "App requires Location permission.";
    } else if (!cond2) {
      reason = "App requires Location service to be enabled.";
    } else {}
    return Future<String>.value(reason);
  }

  Future<String> permissionValidateIndex2() async {
    String reason = "";

    final bool cond1 = await AppPermService().permissionCam();
    final bool cond2 = await AppPermService().permissionMic();
    final bool cond3 = await AppPermService().permissionPhotoOrStorage();

    if (!cond1) {
      reason = "App requires Camera permission.";
    } else if (!cond2) {
      reason = "App requires Microphone permission.";
    } else if (!cond3) {
      reason = "App requires Location service to be enabled.";
    } else {}
    return Future<String>.value(reason);
  }

  Future<String> validate() async {
    String reason = "";

    if (rxInitialPage.value == 0) {
      reason = await permissionValidateIndex0();
    } else if (rxInitialPage.value == 1) {
      reason = await permissionValidateIndex1();
    } else if (rxInitialPage.value == 0) {
      reason = await permissionValidateIndex2();
    } else {}
    return Future<String>.value(reason);
  }
}
