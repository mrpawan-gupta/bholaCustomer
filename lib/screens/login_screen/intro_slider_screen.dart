// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_bottom_indicator.dart";
import "package:customer/common_widgets/app_lottie_widget.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/controllers/login_screen_controllers/intro_slider_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:lottie/lottie.dart";

class IntroSliderScreen extends GetView<IntroSliderController> {
  const IntroSliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Introduction"),
            surfaceTintColor: AppColors().appTransparentColor,
            actions: const <Widget>[],
          ),
          bottomNavigationBar: BottomAppBar(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: kTextTabBarHeight * 2,
                  child: AppTextButton(
                    onPressed: () async {
                      final int initialPage = controller.rxInitialPage.value;
                      if (initialPage == 0) {
                      } else {
                        await controller.pageController.animateToPage(
                          initialPage - 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear,
                        );
                      }
                    },
                    text: controller.rxInitialPage.value != 0 ? "Previous" : "",
                  ),
                ),
                pageviewIndicator(),
                SizedBox(
                  width: kTextTabBarHeight * 2,
                  child: AppTextButton(
                    onPressed: () async {
                      final String reason = await controller.validate();
                      final int initialPage = controller.rxInitialPage.value;
                      final int totalPages = controller.rxTotalPages.value;
                      if (reason.isEmpty) {
                        if (initialPage == (totalPages - 1)) {
                          await AppNavService().pushNamed(
                            destination: AppRoutes().phoneNoScreen,
                            arguments: <String, dynamic>{},
                          );
                        } else {
                          await controller.pageController.animateToPage(
                            initialPage + 1,
                            duration: const Duration(seconds: 1),
                            curve: Curves.linear,
                          );
                        }
                      } else {
                        AppSnackbar().snackbarFailure(
                          title: "Oops",
                          message: reason,
                        );
                      }
                    },
                    text: controller.rxInitialPage.value ==
                            (controller.rxTotalPages.value - 1)
                        ? "I'm in" // "Done"
                        : "I'm in", // "Next",
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              linearProgressIndicator(),
              const SizedBox(height: kToolbarHeight / 2),
              Expanded(child: pageView()),
              const SizedBox(height: kToolbarHeight / 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  AppConstants().commonNote,
                  style: Theme.of(Get.context!).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: kToolbarHeight / 2),
            ],
          ),
        );
      },
    );
  }

  Widget pageviewIndicator() {
    return controller.rxTotalPages.value == 0
        ? const SizedBox()
        : AppBottomIndicator(
            length: controller.rxTotalPages.value,
            index: controller.rxInitialPage.value,
          );
  }

  Widget linearProgressIndicator() {
    return LinearProgressIndicator(
      value: getLinearProgressIndicatorValue(),
      color: Theme.of(Get.context!).colorScheme.primary,
      backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
    );
  }

  double getLinearProgressIndicatorValue() {
    final int length = controller.rxTotalPages.value;
    final double perPage = 1.0 / length;
    final List<double> list = List<double>.generate(
      length,
      (int index) {
        return perPage;
      },
    );
    double tempVariable = 0;
    for (int i = 0; i <= (controller.rxInitialPage.value - 1); i++) {
      tempVariable += list[i];
    }
    return tempVariable;
  }

  Widget pageView() {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: controller.updateInitialPage,
      itemCount: controller.rxTotalPages.value,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              const Spacer(),
              AppLottieWidget(
                path: controller.getIntroductionAnimation()[i],
                fit: BoxFit.cover,
                height: 200,
                width: 200,
                repeat: true,
                onLoaded: (LottieComposition composition) async {},
              ),
              const SizedBox(height: kToolbarHeight / 2),
              Text(
                controller.getIntroductionTitle()[i],
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: kToolbarHeight / 2),
              Text(
                controller.getIntroductionDescription()[i],
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
