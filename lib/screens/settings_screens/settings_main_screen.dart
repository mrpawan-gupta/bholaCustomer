import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/settings_controllers/settings_main_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_in_app_browser.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:external_app_launcher/external_app_launcher.dart";
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
                    itemName: "Help",
                    onTap: () async {
                      await AppWhatsApp().openWhatsApp();
                    },
                  ),
                  const SizedBox(height: 16),
                  settingsItems(
                    itemName: "Legal Policies",
                    onTap: openLegalPoliciesWidget,
                  ),
                  const SizedBox(height: 16),
                  settingsItems1(
                    itemName: "Try our Customer App",
                    onTap: () async {
                      await LaunchApp.openApp(
                        androidPackageName: "com.ahinsaaggregator.customer",
                        iosUrlScheme: "ahinsaaggregatorCustomer://",
                        appStoreLink:
                            "itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041",
                        openStore: true,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  settingsItems2(
                    itemName: "Logout",
                    onTap: controller.signoutAPICall,
                  ),
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
                    await AppNavService().pushNamed(
                      destination: AppRoutes().editProfileScreen,
                      arguments: <String, dynamic>{},
                    );

                    controller.initAndReInitFunction();
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
            await AppNavService().pushNamed(
              destination: AppRoutes().editProfileScreen,
              arguments: <String, dynamic>{},
            );

            controller.initAndReInitFunction();
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
          // ListTile(
          //   dense: true,
          //   leading: const Icon(Icons.public),
          //   title: const Text("Terms & Conditions - Vendor"),
          //   subtitle: Text(AppConstants().appURLsTAndCVendor),
          //   trailing: const Icon(Icons.open_in_new),
          //   onTap: () async {
          //     AppNavService().pop();
          //     await AppInAppBrowser().openInAppBrowser(
          //       url: AppConstants().appURLsTAndCVendor,
          //     );
          //   },
          // ),
          const SizedBox(height: 48),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }
}
