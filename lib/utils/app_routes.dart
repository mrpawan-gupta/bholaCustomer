import "package:customer/bindings/account_binding.dart";
import "package:customer/bindings/login_screen_bindings/language_selection_binding.dart";
import "package:customer/bindings/login_screen_bindings/notification_screen_binding.dart";
import "package:customer/bindings/login_screen_bindings/otp_screen_binding.dart";
import "package:customer/bindings/login_screen_bindings/phone_number_screen_binding.dart";
import "package:customer/bindings/login_screen_bindings/splash_screen_binding.dart";
import "package:customer/bindings/main_navigation_binding.dart";
import "package:customer/bindings/outer_main_bindings/booking_binding.dart";
import "package:customer/bindings/outer_main_bindings/help_binding.dart";
import "package:customer/bindings/outer_main_bindings/home_binding.dart";
import "package:customer/bindings/outer_main_bindings/order_history_binding.dart";
import "package:customer/bindings/outer_main_bindings/portfolio_binding.dart";
import "package:customer/bindings/product_deatils_bindings/cart_bindings.dart";
import "package:customer/bindings/product_deatils_bindings/product_detail_page_bindings.dart";
import "package:customer/bindings/settings_bindings/change_language_binding.dart";
import "package:customer/screens/account_screen.dart";
import "package:customer/screens/login_screen/language_selection.dart";
import "package:customer/screens/login_screen/notification_screen.dart";
import "package:customer/screens/login_screen/otp_screen.dart";
import "package:customer/screens/login_screen/phone_number_screen.dart";
import "package:customer/screens/login_screen/splash_screen.dart";
import "package:customer/screens/main_navigation_screen.dart";
import "package:customer/screens/outer_main_screens/booking_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/screens/outer_main_screens/portfolio_screen.dart";
import "package:customer/screens/product_details/cart.dart";
import "package:customer/screens/product_details/product_details.dart";
import "package:customer/screens/settings_screens/change_language_screen.dart";
import "package:get/get.dart";

class AppRoutes {
  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();
  static final AppRoutes _singleton = AppRoutes._internal();

  final String splashScreen = "/";
  final String languageSelectionScreen = "/languageSelection";
  final String notificationScreen = "/notificationScreen";
  final String phoneNoScreen = "/phoneNoScreen";
  final String otpScreen = "/otpScreen";

  final String mainNavigationScreen = "/mainNavigationScreen";
  final String homeScreen = "/homeScreen";
  final String portfolioScreen = "/portfolioScreen";
  final String bookingScreen = "/bookingScreen";
  final String newOrderScreen = "/newOrderScreen";
  final String helpScreen = "/helpScreen";
  final String orderHistoryScreen = "/orderHistoryScreen";
  final String accountScreen = "/accountScreen";
  final String changeLanguageScreen = "/changeLanguageScreen";
  final String productDetailScreen = "/productDetailScreen";
  final String cartScreen = "/cartScreen";

  List<GetPage<dynamic>> getPages() {
    final GetPage<dynamic> splashScreenRoute = GetPage<dynamic>(
      name: splashScreen,
      page: SplashScreen.new,
      binding: SplashScreenBinding(),
    );
    final GetPage<dynamic> languageSelectionRoute = GetPage<dynamic>(
      name: languageSelectionScreen,
      page: LanguageSelectionPage.new,
      binding: LanguageSelectionBinding(),
    );
    final GetPage<dynamic> notificationScreenRoute = GetPage<dynamic>(
      name: notificationScreen,
      page: NotificationScreen.new,
      binding: NotificationScreenBinding(),
    );
    final GetPage<dynamic> phoneNumberScreenRoute = GetPage<dynamic>(
      name: phoneNoScreen,
      page: PhoneNumberScreen.new,
      binding: PhoneNumberScreenBinding(),
    );
    final GetPage<dynamic> otpScreenRoute = GetPage<dynamic>(
      name: otpScreen,
      page: OTPScreen.new,
      binding: OTPScreenBinding(),
    );

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

    final GetPage<dynamic> bookingRoute = GetPage<dynamic>(
      name: portfolioScreen,
      page: BookingScreen.new,
      binding: BookingBinding(),
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
    final GetPage<dynamic> productDetailRoute = GetPage<dynamic>(
      name: productDetailScreen,
      page: ProductDetailScreen.new,
      binding: ProductDetailBinding(),
    );

    final GetPage<dynamic> cartRoute = GetPage<dynamic>(
      name: cartScreen,
      page: CartScreen.new,
      binding: CartBinding(),
    );

    return <GetPage<dynamic>>[
      splashScreenRoute,
      languageSelectionRoute,
      notificationScreenRoute,
      phoneNumberScreenRoute,
      otpScreenRoute,
      mainNavigationRoute,
      homeRoute,
      portfolioRoute,
      bookingRoute,
      helpRoute,
      orderHistoryRoute,
      accountRoute,
      changeLanguageRoute,
      productDetailRoute,
      cartRoute,
    ];
  }
}
