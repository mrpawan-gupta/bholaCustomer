import "dart:async";
import "dart:js";
import "package:customer/controllers/splash_screen_controller/splash_screen_controllers.dart";
import "package:customer/screens/splash_screen/onBoardScreen.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";



class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});


  Future<void> initState() async {
    controller.updateApp();
    Timer(
      AppConstants().duration,
          () async {
        await Get.to(OnBoardScreen(), transition: Transition.fade,
          duration: AppConstants().duration,);
      },
    );
    await _navigateToProductDetail(context as BuildContext);
  }

  Future<void> _navigateToProductDetail(BuildContext context) async {
    await AppNavService().pushNamed(
      destination: AppRoutes().onBoardScreen,
      arguments: <String, dynamic>{},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appWhiteColor,
      body: Center(
        child: Image.asset(
          AppAssetsImages.bholaLogo,
        ),
      ),
    );
  }
}
