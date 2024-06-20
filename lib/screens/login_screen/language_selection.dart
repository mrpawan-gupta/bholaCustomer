import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/controllers/login_screen_controllers/language_selection_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_in_app_browser.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class LanguageSelectionPage extends GetView<LanguageSelectionController> {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: Get.height / 4,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                AppAssetsImages().splash,
                height: Get.height,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 32),
                  MaybeMarqueeText(
                    text: AppLanguageKeys().strWelcomeToBhola.tr,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(height: Get.height / 24),
                  MaybeMarqueeText(
                    text: AppLanguageKeys().strChooseYourLanguage.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () {
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: controller.rxAllAppLocalsLength.value,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int i) {
                          final Locale locale = controller.getItemFromIndex(i);
                          final bool isLast =
                              i == controller.rxAllAppLocalsLength.value - 1;
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: isLast ? 0.0 : 16.0,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32),
                              onTap: () async {
                                controller.updateLocale(locale);
                                await controller.setUserLangToStorage();
                                await Get.updateLocale(locale);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors()
                                      .appGreyColor
                                      .withOpacity(0.10),
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                    color: controller.rxSelectedLocal.value ==
                                            locale
                                        ? AppColors().appPrimaryColor
                                        : AppColors()
                                            .appGreyColor
                                            .withOpacity(0.10),
                                    width: 2,
                                  ),
                                ),
                                child: MaybeMarqueeText(
                                  text: controller
                                      .getDisplayStringOwnLanguage(locale),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: Get.height / 24),
                  AppElevatedButton(
                    text: AppLanguageKeys().strContinue.tr,
                    onPressed: () async {
                      await AppNavService().pushNamed(
                        // destination: AppRoutes().notificationScreen,
                        destination: AppRoutes().introSliderScreen,
                        arguments: <String, dynamic>{},
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  // Text(
                  //   AppLanguageKeys().strBySigning.tr,
                  //   style: TextStyle(color: AppColors().appGreyColor),
                  //   textAlign: TextAlign.center,
                  // ),
                  richText(),
                  const SizedBox(height: 32),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget richText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: "By signing up, I agree to the ",
            style: TextStyle(color: AppColors().appBlackColor),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
          TextSpan(
            text: "Terms and Conditions",
            style: TextStyle(color: AppColors().appBlueColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await AppInAppBrowser().openInAppBrowser(
                  url: AppConstants().appURLsTAndCCustomer,
                );
              },
          ),
          TextSpan(
            text: " and ",
            style: TextStyle(color: AppColors().appBlackColor),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(color: AppColors().appBlueColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await AppInAppBrowser().openInAppBrowser(
                  url: AppConstants().appURLsPrivacyPolicy,
                );
              },
          ),
          TextSpan(
            text: ".",
            style: TextStyle(color: AppColors().appBlackColor),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
        ],
      ),
    );
  }
}
