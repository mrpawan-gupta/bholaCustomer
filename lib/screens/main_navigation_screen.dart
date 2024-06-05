import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/screens/outer_main_screens/booking_screen.dart";
import "package:customer/screens/outer_main_screens/category/category_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home/home_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final GetUserByIdData data = controller.rxUserInfo.value;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: false,
            title: helloWidget(data),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 48,
                  width: 48,
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
                              destination: AppRoutes().settingsMainScreen,
                              arguments: <String, dynamic>{},
                            );
                            controller.initAndReInitFunction();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            surfaceTintColor: AppColors().appTransparentColor,
          ),
          // ignore: deprecated_member_use
          body: WillPopScope(
            onWillPop: () async {
              bool value = false;
              if (controller.tabController.index == 0) {
                value = true;
              } else {
                controller.tabController.jumpToTab(0);
              }
              return Future<bool>.value(value);
            },
            child: PersistentTabView(
              controller: controller.tabController,
              tabs: <PersistentTabConfig>[
                persistentTabConfig(
                  itemIndex: 0,
                  screen: const HomeScreen(),
                  asset: AppAssetsImages().bottomNavHome,
                  title: "Home",
                ),
                persistentTabConfig(
                  itemIndex: 1,
                  screen: const CategoryScreen(),
                  asset: AppAssetsImages().bottomNavCategory,
                  title: "Category",
                ),
                persistentTabConfig(
                  itemIndex: 2,
                  screen: const BookingScreen(),
                  asset: controller.timerCurrent.value,
                  title: "Booking",
                ),
                persistentTabConfig(
                  itemIndex: 3,
                  screen: const HelpScreen(),
                  asset: AppAssetsImages().bottomNavHelp,
                  title: "Help",
                ),
                persistentTabConfig(
                  itemIndex: 4,
                  screen: const OrderHistoryScreen(),
                  asset: AppAssetsImages().bottomNavShopping,
                  title: "Order History",
                ),
              ],
              navBarBuilder: (NavBarConfig navBarConfig) {
                return Style13BottomNavBar(navBarConfig: navBarConfig);
              },
              navBarOverlap: const NavBarOverlap.none(),
              handleAndroidBackButtonPress: false,
            ),
          ),
        );
      },
    );
  }

  PersistentTabConfig persistentTabConfig({
    required int itemIndex,
    required Widget screen,
    required String asset,
    required String title,
  }) {
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        icon: Image.asset(
          asset,
          fit: BoxFit.cover,
          height: itemIndex != 2 ? 28 : 56,
          width: itemIndex != 2 ? 28 : 56,
          color: itemIndex != 2
              ? AppColors().appPrimaryColor
              : AppColors().appWhiteColor,
        ),
        inactiveIcon: Image.asset(
          asset,
          fit: BoxFit.cover,
          height: itemIndex != 2 ? 28 : 56,
          width: itemIndex != 2 ? 28 : 56,
          color: itemIndex != 2
              ? AppColors().appGreyColor
              : AppColors().appWhiteColor,
        ),
        title: title,
        activeForegroundColor: AppColors().appPrimaryColor,
        inactiveForegroundColor: AppColors().appGrey,
      ),
    );
  }

  Widget helloWidget(GetUserByIdData data) {
    return Text(
      "${data.firstName ?? ""} ${data.lastName ?? ""}",
      style: const TextStyle(fontSize: 16 + 4, fontWeight: FontWeight.w700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
