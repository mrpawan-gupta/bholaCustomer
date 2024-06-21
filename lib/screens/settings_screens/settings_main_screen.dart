// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/settings_controllers/settings_main_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_in_app_browser.dart";
import "package:customer/utils/app_open_store.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
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
        child: SingleChildScrollView(
          child: Obx(
            () {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  userImage(),
                  const SizedBox(height: 16),
                  userInfo(),
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
                    itemName: "Connect with Us",
                    onTap: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().supportScreen,
                        arguments: <String, dynamic>{},
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  settingsItems(
                    itemName: "Legal Policies",
                    onTap: openLegalPoliciesWidget,
                  ),
                  const SizedBox(height: 16),
                  settingsItems(
                    itemName: "App Info",
                    onTap: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().appInfoScreen,
                        arguments: <String, dynamic>{},
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  settingsItems1(
                    itemName: "Try our Customer App",
                    onTap: AppOpenStore().openStoreForCustomer,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(width: 16),
                      Expanded(
                        child: settingsItems2(
                          itemName: "Delete Account",
                          onTap: () async {
                            await openDeleteAccountWidget(
                              onPressedDelete: controller.deleteAPICall,
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(width: 8),
                      Expanded(
                        child: settingsItems2(
                          itemName: "Logout",
                          onTap: controller.signoutAPICall,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 16),
                  noteWidget(),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget userImage() {
    final GetUserByIdData data = controller.rxUserInfo.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 64 * 2,
          width: 64 * 2,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: <Widget>[
              CommonImageWidget(
                imageUrl: data.profile?.profilePhoto ?? "",
                fit: BoxFit.cover,
                imageType: ImageType.user,
              ),
              Material(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    // await AppNavService().pushNamed(
                    //   destination: AppRoutes().editProfileScreen,
                    //   arguments: <String, dynamic>{},
                    // );

                    await canGoAhead();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget userInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColors().appGreyColor.withOpacity(0.10),
        child: InkWell(
          onTap: () async {
            // await AppNavService().pushNamed(
            //   destination: AppRoutes().editProfileScreen,
            //   arguments: <String, dynamic>{},
            // );

            await canGoAhead();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                commonTitleAndValueWidget(
                  title: "Name",
                  value: controller.getFullName(),
                ),
                const SizedBox(height: 16),
                commonTitleAndValueWidget(
                  title: "Email",
                  value: controller.getEmailOrEmailPlaceholder(),
                ),
                const SizedBox(height: 16),
                commonTitleAndValueWidget(
                  title: "Phone",
                  value: controller.getPhoneNumberOrPhoneNumberPlaceholder(),
                ),
                const SizedBox(height: 16),
                AppTextButton(
                  text: "Update Profile",
                  onPressed: () async {
                    // await AppNavService().pushNamed(
                    //   destination: AppRoutes().editProfileScreen,
                    //   arguments: <String, dynamic>{},
                    // );

                    await canGoAhead();
                  },
                ),

                // const SizedBox(height: 16),
                // commonTitleAndValueWidget(
                //   title: "Address",
                //   value: controller.getAddressOrAddressPlaceholder(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonTitleAndValueWidget({
    required String title,
    required String value,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ],
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
    return Card(
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
    );
  }

  Widget noteWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        AppConstants().commonNote,
        style: Theme.of(Get.context!).textTheme.bodySmall,
      ),
    );
  }

  Future<void> openLegalPoliciesWidget() async {
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            AppLanguageKeys().strActionPerform.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ListTile(
            dense: true,
            leading: const Icon(Icons.public),
            title: const Text("Official Website"),
            subtitle: Text(AppConstants().appURLsHomePage),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              AppNavService().pop();
              await AppInAppBrowser().openInAppBrowser(
                url: AppConstants().appURLsHomePage,
              );
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.public),
            title: const Text("About Us"),
            subtitle: Text(AppConstants().appURLsAboutUs),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              AppNavService().pop();
              await AppInAppBrowser().openInAppBrowser(
                url: AppConstants().appURLsAboutUs,
              );
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.public),
            title: const Text("Privacy Policy"),
            subtitle: Text(AppConstants().appURLsPrivacyPolicy),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              AppNavService().pop();
              await AppInAppBrowser().openInAppBrowser(
                url: AppConstants().appURLsPrivacyPolicy,
              );
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.public),
            title: const Text("Refund Policy"),
            subtitle: Text(AppConstants().appURLsRefundPolicy),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              AppNavService().pop();
              await AppInAppBrowser().openInAppBrowser(
                url: AppConstants().appURLsRefundPolicy,
              );
            },
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.public),
            title: const Text("Terms & Conditions - Customer"),
            subtitle: Text(AppConstants().appURLsTAndCCustomer),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              AppNavService().pop();
              await AppInAppBrowser().openInAppBrowser(
                url: AppConstants().appURLsTAndCCustomer,
              );
            },
          ),
          const SizedBox(height: 48),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }

  Future<void> openDeleteAccountWidget({
    required Function() onPressedDelete,
  }) async {
    await Get.bottomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            AppLanguageKeys().strActionPerform.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Are you sure you want to delete? It is an irreversible process!",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Do not delete account",
                    onPressed: () {
                      AppNavService().pop();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: AppTextButton(
                    text: "Delete account",
                    onPressed: () async {
                      AppNavService().pop();
                      onPressedDelete();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 48),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }

  Future<void> canGoAhead() async {
    await controller.canGoAhead(
      onContinue: () async {
        await AppNavService().pushNamed(
          destination: AppRoutes().editProfileScreen,
          arguments: <String, dynamic>{},
        );

        controller.initAndReInitFunction();
      },
    );

    return Future<void>.value();
  }
}
