import "package:customer/common_widgets/app_icon_button.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home_screen.dart";
import "package:customer/screens/outer_main_screens/new_order_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/screens/outer_main_screens/portfolio_screen.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_double_tap.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class MainNavigationScreen extends GetView<MainNavigationController> {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          height: 48,
          width: 48,
          child: AppIconButton(
            iconData: Icons.account_circle_outlined,
            onPressed: () async {},
          ),
        ),
        centerTitle: true,
        title: Text("${AppLanguageKeys().strHelloWorld.tr}, Dharam"),
        actions: <Widget>[
          SizedBox(
            height: 48,
            width: 48,
            child: AppIconButton(
              iconData: Icons.settings_outlined,
              onPressed: () async {},
            ),
          ),
        ],
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: AppDoubleTap().onWillPop,
        child: PersistentTabView(
          context,
          controller: controller.tabController,
          screens: const <Widget>[
            HomeScreen(),
            PortfolioScreen(),
            NewOrderScreen(),
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
              title: "Add",
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
          onItemSelected: (int value) {
            controller.tabController.jumpToTab(value);
          },
          navBarStyle: NavBarStyle.style15,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
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
}
