import "package:customer/services/app_analytics_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_fonts.dart";
import "package:customer/utils/app_keyboard_manager.dart";
import "package:customer/utils/app_loader.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_translations.dart";
import "package:feature_discovery/feature_discovery.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:get/get.dart";
import "package:upgrader/upgrader.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Ahinsa Aggregator Customer App",
      theme: themeData(brightness: Brightness.light),
      darkTheme: themeData(brightness: Brightness.light),
      getPages: AppRoutes().getPages(),
      routingCallback: AppNavService().observer,
      navigatorKey: Get.key,
      navigatorObservers: <NavigatorObserver>[
        AppAnalyticsService().firebaseAnalyticsObserver(),
      ],
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        final Locale locale = AppStorageService().getUserLangFromStorage();
        return MediaQuery(
          data: context.mediaQuery.copyWith(textScaler: TextScaler.noScaling),
          child: AppLoader().globalLoaderOverlay(
            child: AppKeyboardManager().globalKeyboardDismisser(
              child: UpgradeAlert(
                navigatorKey: Get.key,
                upgrader: Upgrader(
                  languageCode: locale.languageCode,
                  countryCode: locale.countryCode ?? "",
                  debugLogging: kDebugMode,
                  durationUntilAlertAgain: Duration.zero,
                ),
                showIgnore: false,
                showLater: false,
                child: FeatureDiscovery(
                  child: flavorBanner(
                    child: child ?? const SizedBox(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      translations: AppTranslations(),
      locale: AppStorageService().getUserLangFromStorage(),
      supportedLocales: AppTranslations().supportedLocales(),
      fallbackLocale: AppTranslations().supportedLocales()[0],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      defaultTransition: Transition.cupertino,
      transitionDuration: Get.defaultTransitionDuration,
    );
  }

  ThemeData themeData({required Brightness brightness}) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: AppColors().appPrimaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      applyElevationOverlayColor: true,
      textTheme: AppFonts().getTextTheme(),
    );
  }

  Widget flavorBanner({required Widget child}) {
    Widget widget = const SizedBox();
    const String flavor = appFlavor ?? "";
    switch (flavor) {
      case "dev":
        widget = Banner(
          message: flavor,
          location: BannerLocation.topEnd,
          child: child,
        );
        break;
      case "prd":
        widget = child;
        break;
      default:
        break;
    }
    return widget;
  }
}
