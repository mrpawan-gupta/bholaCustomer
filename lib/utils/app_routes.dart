import "package:customer/bindings/booking_binding/added_quotes_binding.dart";
import "package:customer/bindings/booking_binding/booking_details_binding.dart";
import "package:customer/bindings/booking_binding/booking_payment_binding.dart";
import "package:customer/bindings/cart_binding/cart_binding.dart";
import "package:customer/bindings/login_screen_bindings/intro_slider_binding.dart";
// import "package:customer/bindings/login_screen_bindings/language_selection_binding.dart";
import "package:customer/bindings/login_screen_bindings/otp_screen_binding.dart";
import "package:customer/bindings/login_screen_bindings/phone_number_screen_binding.dart";
import "package:customer/bindings/login_screen_bindings/splash_screen_binding.dart";
import "package:customer/bindings/main_navigation_binding.dart";
import "package:customer/bindings/nested_category/products_list_binding.dart";
import "package:customer/bindings/nested_category/view_generic_product_details_binding.dart";
import "package:customer/bindings/outer_main_bindings/booking_binding.dart";
import "package:customer/bindings/outer_main_bindings/category_binding.dart";
import "package:customer/bindings/outer_main_bindings/help_binding.dart";
import "package:customer/bindings/outer_main_bindings/home_binding.dart";
import "package:customer/bindings/outer_main_bindings/order_history_binding.dart";
import "package:customer/bindings/settings_bindings/app_info_binding.dart";
import "package:customer/bindings/settings_bindings/change_language_binding.dart";
import "package:customer/bindings/settings_bindings/edit_profile_binding.dart";
import "package:customer/bindings/settings_bindings/settings_main_binding.dart";
import "package:customer/bindings/settings_bindings/support_binding.dart";
import "package:customer/bindings/wish_list_binding/wish_list_binding.dart";
import "package:customer/screens/booking_screen/added_quotes_screen.dart";
import "package:customer/screens/booking_screen/booking_details_screen.dart";
import "package:customer/screens/booking_screen/booking_payment_screen.dart";
import "package:customer/screens/cart_screen/cart_screen.dart";
import "package:customer/screens/login_screen/intro_slider_screen.dart";
// import "package:customer/screens/login_screen/language_selection.dart";
import "package:customer/screens/login_screen/otp_screen.dart";
import "package:customer/screens/login_screen/phone_number_screen.dart";
import "package:customer/screens/login_screen/splash_screen.dart";
import "package:customer/screens/main_navigation_screen.dart";
import "package:customer/screens/nested_category/products_list/products_list_screen.dart";
import "package:customer/screens/nested_category/view_generic_product_details/view_generic_product_details_screen.dart";
import "package:customer/screens/outer_main_screens/booking_screen.dart";
import "package:customer/screens/outer_main_screens/category/category_screen.dart";
import "package:customer/screens/outer_main_screens/help_screen.dart";
import "package:customer/screens/outer_main_screens/home/home_screen.dart";
import "package:customer/screens/outer_main_screens/order_history_screen.dart";
import "package:customer/screens/settings_screens/app_info_screen.dart";
import "package:customer/screens/settings_screens/change_language_screen.dart";
import "package:customer/screens/settings_screens/edit_profile_screen.dart";
import "package:customer/screens/settings_screens/settings_main_screen.dart";
import "package:customer/screens/settings_screens/support_screen.dart";
import "package:customer/screens/wish_list_screen/wish_list_screen.dart";
import "package:get/get.dart";

class AppRoutes {
  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();
  static final AppRoutes _singleton = AppRoutes._internal();

  final String splashScreen = "/";
  // final String languageSelectionScreen = "/languageSelection";
  final String introSliderScreen = "/introSliderScreen";
  final String phoneNoScreen = "/phoneNoScreen";
  final String otpScreen = "/otpScreen";

  final String mainNavigationScreen = "/mainNavigationScreen";
  final String homeScreen = "/homeScreen";
  final String categoryScreen = "/categoryScreen";
  final String bookingScreen = "/bookingScreen";
  final String helpScreen = "/helpScreen";
  final String orderHistoryScreen = "/orderHistoryScreen";

  final String bookingPaymentScreen = "/bookingPaymentScreen";
  final String bookingDetailsScreen = "/bookingDetailsScreen";
  final String addedQuotesScreen = "/addedQuotesScreen";

  final String settingsMainScreen = "/settingsMainScreen";
  final String editProfileScreen = "/editProfileScreen";
  final String changeLanguageScreen = "/changeLanguageScreen";
  final String appInfoScreen = "/appInfoScreen";
  final String supportScreen = "/supportScreen";

  final String productListingScreen = "/productListingScreen";
  final String viewGenericProductDetailsScreen =
      "/viewGenericProductDetailsScreen";

  final String wishListScreen = "/wishListScreen";
  final String cartScreen = "/cartScreen";

  List<GetPage<dynamic>> getPages() {
    final GetPage<dynamic> splashScreenRoute = GetPage<dynamic>(
      name: splashScreen,
      page: SplashScreen.new,
      binding: SplashScreenBinding(),
    );
    // final GetPage<dynamic> languageSelectionRoute = GetPage<dynamic>(
    //   name: languageSelectionScreen,
    //   page: LanguageSelectionPage.new,
    //   binding: LanguageSelectionBinding(),
    // );
    final GetPage<dynamic> introSliderRoute = GetPage<dynamic>(
      name: introSliderScreen,
      page: IntroSliderScreen.new,
      binding: IntroSliderBinding(),
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
    final GetPage<dynamic> categoryRoute = GetPage<dynamic>(
      name: categoryScreen,
      page: CategoryScreen.new,
      binding: CategoryBinding(),
    );
    final GetPage<dynamic> bookingRoute = GetPage<dynamic>(
      name: bookingScreen,
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

    final GetPage<dynamic> bookingPaymentRoute = GetPage<dynamic>(
      name: bookingPaymentScreen,
      page: BookingPaymentScreen.new,
      binding: BookingPaymentBinding(),
    );
    final GetPage<dynamic> bookingDetailsRoute = GetPage<dynamic>(
      name: bookingDetailsScreen,
      page: BookingDetailsScreen.new,
      binding: BookingDetailsBinding(),
    );
    final GetPage<dynamic> addedQuotesRoute = GetPage<dynamic>(
      name: addedQuotesScreen,
      page: AddedQuotesScreen.new,
      binding: AddedQuotesBinding(),
    );

    final GetPage<dynamic> settingsMainRoute = GetPage<dynamic>(
      name: settingsMainScreen,
      page: SettingsMainScreen.new,
      binding: SettingsMainBinding(),
    );
    final GetPage<dynamic> editProfileRoute = GetPage<dynamic>(
      name: editProfileScreen,
      page: EditProfileScreen.new,
      binding: EditProfileBinding(),
    );
    final GetPage<dynamic> changeLanguageRoute = GetPage<dynamic>(
      name: changeLanguageScreen,
      page: ChangeLanguageScreen.new,
      binding: ChangeLanguageBinding(),
    );
    final GetPage<dynamic> appInfoRoute = GetPage<dynamic>(
      name: appInfoScreen,
      page: AppInfoScreen.new,
      binding: AppInfoBinding(),
    );
    final GetPage<dynamic> supportRoute = GetPage<dynamic>(
      name: supportScreen,
      page: SupportScreen.new,
      binding: SupportBinding(),
    );

    final GetPage<dynamic> productListingRoute = GetPage<dynamic>(
      name: productListingScreen,
      page: ProductsListScreen.new,
      binding: ProductsListBinding(),
    );
    final GetPage<dynamic> viewGenericProductDetailsRoute = GetPage<dynamic>(
      name: viewGenericProductDetailsScreen,
      page: ViewGenericProductDetailsScreen.new,
      binding: ViewGenericProductDetailsBinding(),
    );

    final GetPage<dynamic> wishListRoute = GetPage<dynamic>(
      name: wishListScreen,
      page: WishListScreen.new,
      binding: WishListBinding(),
    );
    final GetPage<dynamic> cartRoute = GetPage<dynamic>(
      name: cartScreen,
      page: CartScreen.new,
      binding: CartBinding(),
    );

    return <GetPage<dynamic>>[
      splashScreenRoute,
      // languageSelectionRoute,
      introSliderRoute,
      phoneNumberScreenRoute,
      otpScreenRoute,
      mainNavigationRoute,
      homeRoute,
      categoryRoute,
      bookingRoute,
      helpRoute,
      orderHistoryRoute,
      settingsMainRoute,
      changeLanguageRoute,
      appInfoRoute,
      supportRoute,
      productListingRoute,
      editProfileRoute,
      bookingDetailsRoute,
      bookingPaymentRoute,
      viewGenericProductDetailsRoute,
      addedQuotesRoute,
      wishListRoute,
      cartRoute,
    ];
  }
}
