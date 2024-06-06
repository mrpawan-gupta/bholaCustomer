// ignore_for_file: deprecated_member_use

import "dart:async";
import "dart:io";

import "package:after_layout/after_layout.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/controllers/login_screen_controllers/splash_screen_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/localization/app_language_keys.dart";
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
      body: WillPopScope(
        onWillPop: () async {
          return Future<bool>.value(false);
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

  Future<void> openStartupWidget() async {
    await Get.bottomSheet(
      WillPopScope(
        onWillPop: () async {
          return Future<bool>.value(false);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            Text(
              AppLanguageKeys().strActionPerform.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "App required location permission & service order to continue.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 50,
                child: AppElevatedButton(
                  text: "Continue",
                  onPressed: () async {
                    AppNavService().pop();

                    await startupProcedure();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AppTextButton(
                text: "Exit",
                onPressed: () {
                  AppNavService().pop();

                  exit(0);
                },
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 48),
          ],
        ),
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
    );

    return Future<void>.value();
  }

  Future<void> startupProcedure() async {
    await controller.startupProcedure(showPopup: openStartupWidget);
    return Future<void>.value();
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    await startupProcedure();
    return Future<void>.value();
  }
}
