import "package:customer/controllers/login_screen_controllers/splash_screen_controller.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssetsImages().splash,
        height: Get.height,
        width: Get.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
