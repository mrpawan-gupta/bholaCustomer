import "dart:async";

import "package:after_layout/after_layout.dart";
import "package:customer/controllers/login_screen_controllers/splash_screen_controller.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  final SplashScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          } else {}
        },
        child: Image.asset(
          AppAssetsImages().splash,
          height: Get.height,
          width: Get.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await controller.furtherProcedure();
    return Future<void>.value();
  }
}
