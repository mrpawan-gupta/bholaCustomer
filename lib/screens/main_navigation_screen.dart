import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/screens/outer_main_screens/booking_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/screens/outer_main_screens/portfolio_screen.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_double_tap.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        title: helloWidget(),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  await AppNavService().pushNamed(
                    destination: AppRoutes().settingsMainScreen,
                    arguments: <String, dynamic>{},
                  );
                },
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: CommonImageWidget(
                    imageUrl:
                        controller.getUserData().profile?.profilePhoto ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
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
            value = await AppDoubleTap().onWillPop();
          } else {}
          return Future<bool>.value(value);
        },
        child: PersistentTabView(
          context,
          controller: controller.tabController,
          screens: const <Widget>[
            HomeScreen(),
            PortfolioScreen(),
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
              title: "Portfolio",
              activeIconData: Icons.show_chart,
              inActiveIconData: Icons.show_chart_outlined,
              isCenterdItem: false,
            ),
            createItem(
              title: "New Order",
              activeIconData: Icons.add,
              inActiveIconData: Icons.add_outlined,
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

  Widget helloWidget() {
    final GetUserByIdData data = controller.getUserData();
    return Text(
      "${data.firstName ?? ""} ${data.lastName ?? ""}",
      style: const TextStyle(fontSize: 16 + 4, fontWeight: FontWeight.w700),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
