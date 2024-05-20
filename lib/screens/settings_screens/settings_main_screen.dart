import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/settings_controllers/settings_main_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SettingsMainScreen extends GetView<SettingsMainController> {
  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Settings"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            userImage(),
            const SizedBox(height: 16),
            userInfo(
              name: controller.getFullName(),
              email: controller.getEmailOrEmailPlaceholder(),
              phone: controller.rxUserInfo.value.phoneNumber ?? "",
              onTap: () {},
            ),
            const SizedBox(height: 16),
            settingsItems(
              itemName: "Change Language",
              onTap: () async {
                await AppNavService().pushNamed(
                  destination: AppRoutes().changeLanguageScreen,
                  arguments: <String, dynamic>{},
                );
              },
            ),
            const SizedBox(height: 16),
            settingsItems(
              itemName: "Help",
              onTap: () async {
                await AppWhatsApp().openWhatsApp();
              },
            ),
            const SizedBox(height: 16),
            settingsItems1(itemName: "Try our Customer App", onTap: () {}),
            const SizedBox(height: 16),
            settingsItems1(itemName: "Apply For Kishan Credit", onTap: () {}),
            const Spacer(),
            settingsItems2(
              itemName: "Logout",
              onTap: controller.signoutAPICall,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget userImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 150,
          width: 150,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CommonImageWidget(
            imageUrl: controller.rxUserInfo.value.profile?.profilePhoto ?? "",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget userInfo({
    required String name,
    required String email,
    required String phone,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColors().appGreyColor.withOpacity(0.10),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaybeMarqueeText(
                              text: name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: MaybeMarqueeText(
                              text: email,
                              style: TextStyle(
                                color: AppColors().appGreyColor,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: MaybeMarqueeText(
                              text: phone,
                              style: TextStyle(
                                color: AppColors().appGreyColor,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Flexible(
                //   child: MaybeMarqueeText(
                //     text: "Edit",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: AppColors().appPrimaryColor,
                //     ),
                //     alignment: Alignment.centerLeft,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingsItems({
    required String itemName,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors().appGreyColor.withOpacity(0.10),
          ),
        ),
        color: AppColors().appGreyColor.withOpacity(0.10),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: MaybeMarqueeText(
                    text: itemName,
                    style: const TextStyle(),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget settingsItems1({
    required String itemName,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors().appPrimaryColor,
          ),
        ),
        color: AppColors().appTransparentColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaybeMarqueeText(
              text: itemName,
              style: TextStyle(
                color: AppColors().appPrimaryColor,
              ),
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget settingsItems2({
    required String itemName,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors().appRedColor,
          ),
        ),
        color: AppColors().appTransparentColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MaybeMarqueeText(
              text: itemName,
              style: TextStyle(
                color: AppColors().appRedColor,
              ),
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
