// ignore_for_file: lines_longer_than_80_chars

import "package:customer/services/app_perm_service.dart";
import "package:customer/utils/app_assets_lotties.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class IntroSliderController extends GetxController {
  final RxInt rxTotalPages = 3.obs;

  final RxInt rxInitialPage = 0.obs;

  final PageController pageController = PageController();

  RxList<String> getIntroductionAnimation() {
    final List<String> list = <String>[
      AppAssetsLotties().lottieNotification,
      AppAssetsLotties().lottieLocation,
      AppAssetsLotties().lottieCamera,
    ];
    return list.obs;
  }

  RxList<String> getIntroductionTitle() {
    final List<String> list = <String>[
      "Stay Updated with Bhola !!!",
      "Enable Location Services for Bhola",
      "Enhance Your Bhola Experience",
    ];
    return list.obs;
  }

  RxList<String> getIntroductionDescription() {
    final List<String> list = <String>[
      "Stay in the loop with real-time updates on your order status, new offers, personalized solutions, app updates, and more. To ensure you don't miss any important notifications, please enable notification access for Bhola.",
      "To help you select your farm location with ease and connect you with the nearest vendors, please enable location services for Bhola at all times. Bhola will use your location data in the background to provide you with the most relevant services based on your longitude and latitude.",
      "Allow Bhola access to your gallery, camera, and microphone to personalize your profile, post reviews, and more. This enables you to add a profile picture and share your experiences with ease.",
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
    final bool cond1 = await AppPermService().permissionPhotoOrStorage();

    if (!cond1) {
      reason = "App requires Photos & Storage permission.";
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
