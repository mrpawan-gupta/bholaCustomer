import "package:customer/bindings/account_binding.dart";
import "package:customer/bindings/main_navigation_binding.dart";
import "package:customer/bindings/outer_main_bindings/help_binding.dart";
import "package:customer/bindings/outer_main_bindings/home_binding.dart";
import "package:customer/bindings/outer_main_bindings/new_order_binding.dart";
import "package:customer/bindings/outer_main_bindings/order_history_binding.dart";
import "package:customer/bindings/outer_main_bindings/portfolio_binding.dart";
import "package:customer/bindings/product_deatils_bindings/product_detail_page_bindings.dart";
import "package:customer/bindings/sample_bindings/firebase_sample_binding.dart";
import "package:customer/bindings/settings_bindings/change_language_binding.dart";
import "package:customer/screens/account_screen.dart";
import "package:customer/screens/main_navigation_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home_screen.dart";
import "package:customer/screens/outer_main_screens/new_order_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/screens/outer_main_screens/portfolio_screen.dart";
import "package:customer/screens/product_details/ProductDetails.dart";
import "package:customer/screens/sample_screens/firebase_sample_screen.dart";
import "package:customer/screens/settings_screens/change_language_screen.dart";
import "package:get/get.dart";

class AppRoutes {
  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();
  static final AppRoutes _singleton = AppRoutes._internal();

  final String mainNavigationScreen = "/";                          // This screen is independent, you can use "/" in this.
  final String homeScreen = "/homeScreen";                          // This screen is attached to mainNavigationScreen, do not use "/" in this.
  final String portfolioScreen = "/portfolioScreen";                // This screen is attached to mainNavigationScreen, do not use "/" in this.
  final String newOrderScreen = "/newOrderScreen";                  // This screen is attached to mainNavigationScreen, do not use "/" in this.
  final String helpScreen = "/helpScreen";                          // This screen is attached to mainNavigationScreen, do not use "/" in this.
  final String orderHistoryScreen = "/orderHistoryScreen";          // This screen is attached to mainNavigationScreen, do not use "/" in this.
  final String accountScreen = "/accountScreen";                    // This screen is independent, you can use "/" in this.
  final String changeLanguageScreen = "/changeLanguageScreen";      // This screen is independent, you can use "/" in this.
  final String firebaseSampleScreen = "/firebaseSampleScreen";      // This screen is independent, you can use "/" in this.
  final String productDetailScreen = "/productDetailScreen";      // This screen is independent, you can use "/" in this.

  List<GetPage<dynamic>> getPages() {
    final GetPage<dynamic> mainNavigationRoute = GetPage<dynamic>(
      name: mainNavigationScreen,
      page: MainNavigationScreen.new,
      binding: MainNavigationBinding(),
    );
    final GetPage<dynamic> homeRoute = GetPage<dynamic>(
      name: homeScreen,
      page: HomeScreen.new,
      binding: HomeBinding(),
    );
    final GetPage<dynamic> portfolioRoute = GetPage<dynamic>(
      name: portfolioScreen,
      page: PortfolioScreen.new,
      binding: PortfolioBinding(),
    );
    final GetPage<dynamic> newOrderRoute = GetPage<dynamic>(
      name: newOrderScreen,
      page: NewOrderScreen.new,
      binding: NewOrderBinding(),
    );
    final GetPage<dynamic> helpRoute = GetPage<dynamic>(
      name: helpScreen,
      page: HelpScreen.new,
      binding: HelpBinding(),
    );
    final GetPage<dynamic> orderHistoryRoute = GetPage<dynamic>(
      name: orderHistoryScreen,
      page: OrderHistoryScreen.new,
      binding: OrderHistoryBinding(),
    );
    final GetPage<dynamic> accountRoute = GetPage<dynamic>(
      name: accountScreen,
      page: AccountScreen.new,
      binding: AccountBinding(),
    );
    final GetPage<dynamic> changeLanguageRoute = GetPage<dynamic>(
      name: changeLanguageScreen,
      page: ChangeLanguageScreen.new,
      binding: ChangeLanguageBinding(),
    );
    final GetPage<dynamic> firebaseSampleRoute = GetPage<dynamic>(
      name: firebaseSampleScreen,
      page: FirebaseSampleScreen.new,
      binding: FirebaseSampleBinding(),
    );
    final GetPage<dynamic> productDetailRoute = GetPage<dynamic>(
      name: productDetailScreen,
      page: ProductDetailScreen.new,
      binding: ProductDetailBinding(),
    );
    
    return <GetPage<dynamic>>[
      mainNavigationRoute,
      homeRoute,
      portfolioRoute,
      newOrderRoute,
      helpRoute,
      orderHistoryRoute,
      accountRoute,
      changeLanguageRoute,
      firebaseSampleRoute,
      productDetailRoute,
    ];
  }
}
