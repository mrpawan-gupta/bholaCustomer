import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/screens/outer_main_screens/booking_screen.dart";
import "package:customer/screens/outer_main_screens/category/category_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

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
              context,
              controller: controller.tabController,
              screens: const <Widget>[
                HomeScreen(),
                CategoryScreen(),
                BookingScreen(),
                HelpScreen(),
                OrderHistoryScreen(),
              ],
              items: <PersistentBottomNavBarItem>[
                createItem(
                  title: "Home",
                  activeIconData: Icons.home,
                  inActiveIconData: Icons.home_outlined,
                  isCenterdItem: false,
                ),
                createItem(
                  title: "Category",
                  activeIconData: Icons.category,
                  inActiveIconData: Icons.category_outlined,
                  isCenterdItem: false,
                ),
                createItem(
                  title: "Book",
                  activeIconData: Icons.shopping_bag,
                  inActiveIconData: Icons.shopping_bag_outlined,
                  isCenterdItem: true,
                ),
                createItem(
                  title: "Help",
                  activeIconData: Icons.help,
                  inActiveIconData: Icons.help_outlined,
                  isCenterdItem: false,
                ),
                createItem(
                  title: "History",
                  activeIconData: Icons.library_books,
                  inActiveIconData: Icons.library_books_outlined,
                  isCenterdItem: false,
                ),
              ],
              onItemSelected: (int value) {},
              navBarStyle: NavBarStyle.style15,
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        );
      },
    );
  }

  PersistentBottomNavBarItem createItem({
    required String title,
    required IconData activeIconData,
    required IconData inActiveIconData,
    required bool isCenterdItem,
  }) {
    return PersistentBottomNavBarItem(
      title: title,
      icon: Icon(activeIconData),
      inactiveIcon: Icon(inActiveIconData),
      activeColorPrimary: AppColors().appPrimaryColor,
      inactiveColorPrimary: AppColors().appGreyColor,
      activeColorSecondary: isCenterdItem ? AppColors().appWhiteColor : null,
      inactiveColorSecondary: AppColors().appTransparentColor,
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
