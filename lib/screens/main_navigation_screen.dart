import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";
import "package:customer/common_functions/order_booking_stream.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/feature_overlay.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/screens/outer_main_screens/booking/booking_screen.dart";
import "package:customer/screens/outer_main_screens/category/category_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home/home_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:feature_discovery/feature_discovery.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import "package:transparent_image/transparent_image.dart";

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
            leadingWidth: kToolbarHeight + 16,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: featureDiscovery(
                featureId: featureTopProfile,
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
            ),
            centerTitle: true,
            title: helloWidget(data),
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  featureDiscovery(
                    featureId: featureTopWishList,
                    child: IconButton(
                      onPressed: () async {
                        await AppNavService().pushNamed(
                          destination: AppRoutes().wishListScreen,
                          arguments: <String, dynamic>{},
                        );

                        OrderBookingStream().functionSinkAdd();
                      },
                      icon: Badge(
                        isLabelVisible: rxWishListCount.value != 0,
                        label: Text("${rxWishListCount.value}"),
                        textColor: AppColors().appWhiteColor,
                        backgroundColor: AppColors().appPrimaryColor,
                        child: Image.asset(
                          AppAssetsImages().appBarWish,
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                          color: rxWishListCount.value != 0
                              ? AppColors().appPrimaryColor
                              : AppColors().appGreyColor,
                        ),
                      ),
                    ),
                  ),
                  featureDiscovery(
                    featureId: featureTopCartList,
                    child: IconButton(
                      onPressed: () async {
                        await AppNavService().pushNamed(
                          destination: AppRoutes().cartScreen,
                          arguments: <String, dynamic>{},
                        );

                        OrderBookingStream().functionSinkAdd();
                      },
                      icon: Badge(
                        isLabelVisible: rxCartListCount.value != 0,
                        label: Text("${rxCartListCount.value}"),
                        textColor: AppColors().appWhiteColor,
                        backgroundColor: AppColors().appPrimaryColor,
                        child: Image.asset(
                          AppAssetsImages().appBarCart,
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                          color: rxCartListCount.value != 0
                              ? AppColors().appPrimaryColor
                              : AppColors().appGreyColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
            backgroundColor: AppColors().appWhiteColor,
            surfaceTintColor: AppColors().appWhiteColor,
            bottom: PreferredSize(
              preferredSize: Size.zero,
              child: Divider(
                color: AppColors().appPrimaryColor,
                thickness: 2.0,
                height: 0.0,
              ),
            ),
          ),
          body: PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (didPop) {
                return;
              } else {}

              final bool value = controller.getCurrentIndex() == 0;

              value ? await SystemNavigator.pop() : controller.jumpToTab(0);
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
                  asset: AppAssetsImages().bottomNavLive,
                  title: "Live",
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
              navBarOverlap: const NavBarOverlap.custom(
                fullOverlapWhenNotOpaque: false,
                overlap: kToolbarHeight / 2,
              ),
              handleAndroidBackButtonPress: false,
              gestureNavigationEnabled: true,
              onTabChanged: tabControllerFunction,
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
        icon: featureDiscovery(
          featureId: itemIndex == 0
              ? featurBottomHome
              : itemIndex == 1
                  ? featurBottomCategory
                  : itemIndex == 2
                      ? featurBottomBooking
                      : itemIndex == 3
                          ? featurBottomLive
                          : itemIndex == 4
                              ? featurBottomOrderHistory
                              : "",
          child: FadeInImage(
            image: AssetImage(asset),
            placeholder: MemoryImage(kTransparentImage),
            fit: BoxFit.cover,
            height: itemIndex != 2 ? kToolbarHeight / 2 : kToolbarHeight,
            width: itemIndex != 2 ? kToolbarHeight / 2 : kToolbarHeight,
            color: itemIndex != 2
                ? AppColors().appPrimaryColor
                : FeatureDiscovery.currentFeatureIdOf(
                          Get.key.currentState!.context,
                        ) ==
                        featurBottomBooking
                    ? AppColors().appPrimaryColor
                    : AppColors().appWhiteColor,
          ),
        ),
        inactiveIcon: featureDiscovery(
          featureId: itemIndex == 0
              ? featurBottomHome
              : itemIndex == 1
                  ? featurBottomCategory
                  : itemIndex == 2
                      ? featurBottomBooking
                      : itemIndex == 3
                          ? featurBottomLive
                          : itemIndex == 4
                              ? featurBottomOrderHistory
                              : "",
          child: FadeInImage(
            image: AssetImage(asset),
            placeholder: MemoryImage(kTransparentImage),
            fit: BoxFit.cover,
            height: itemIndex != 2 ? kToolbarHeight / 2 : kToolbarHeight,
            width: itemIndex != 2 ? kToolbarHeight / 2 : kToolbarHeight,
            color: itemIndex != 2
                ? AppColors().appGreyColor
                : FeatureDiscovery.currentFeatureIdOf(
                          Get.key.currentState!.context,
                        ) ==
                        featurBottomBooking
                    ? AppColors().appPrimaryColor
                    : AppColors().appWhiteColor,
          ),
        ),
        title: title,
        activeForegroundColor: AppColors().appPrimaryColor,
        inactiveForegroundColor: AppColors().appGrey,
      ),
    );
  }

  Widget helloWidget(GetUserByIdData data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          controller.greet(),
          style: const TextStyle(fontSize: 12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          "${data.firstName ?? ""} ${data.lastName ?? ""}",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget commonAppBarBottom({
    required IconData iconData,
    required String name,
    required Function() onTap,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors().appRedColor),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      surfaceTintColor: AppColors().appWhiteColor,
      color: AppColors().appWhiteColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  color: AppColors().appRedColor,
                ),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors().appRedColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget featureDiscovery({required String featureId, required Widget child}) {
  return FeatureDiscoveryOverlay(
    featureId: featureId,
    tapTarget: child,
    child: child,
  );
}
