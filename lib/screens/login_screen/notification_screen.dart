import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/controllers/login_screen_controllers/notification_screen_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class NotificationScreen extends GetView<NotificationScreenController> {
  const NotificationScreen({super.key});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 48,
                        backgroundColor:
                            AppColors().appGreyColor.withOpacity(0.10),
                        child: Icon(
                          Icons.notifications,
                          color: AppColors().appPrimaryColor,
                          size: 48,
                        ),
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        radius: 48,
                        backgroundColor:
                            AppColors().appGreyColor.withOpacity(0.10),
                        child: Icon(
                          Icons.location_on,
                          color: AppColors().appPrimaryColor,
                          size: 48,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    AppLanguageKeys().strTurnOnNotifications.tr,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    AppLanguageKeys().strDontMissOut.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors().appGreyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Get.height / 6),
                  AppElevatedButton(
                    text: AppLanguageKeys().strOkay.tr,
                    onPressed: () async {
                      final String reason = await controller.validate();
                      reason.isEmpty
                          ? await AppNavService().pushNamed(
                              destination: AppRoutes().phoneNoScreen,
                              arguments: <String, dynamic>{},
                            )
                          : AppSnackbar().snackbarFailure(
                              title: "Oops",
                              message: reason,
                            );
                    },
                  ),
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
}
