// ignore_for_file: lines_longer_than_80_chars
// import "dart:async";
// import "dart:io";

// import "package:customer/common_functions/dependencies_injection.dart";
// import "package:customer/firebase_options.dart";
// import "package:customer/services/app_analytics_service.dart";
// import "package:customer/services/app_nav_service.dart";
// import "package:customer/services/app_storage_service.dart";
// import "package:customer/utils/app_colors.dart";
// import "package:customer/utils/app_fonts.dart";
// import "package:customer/utils/app_keyboard_manager.dart";
// import "package:customer/utils/app_loader.dart";
// import "package:customer/utils/app_logger.dart";
// import "package:customer/utils/app_routes.dart";
// import "package:customer/utils/localization/app_translations.dart";
// import "package:customer/utils/my_http_overrides.dart";
// import "package:firebase_core/firebase_core.dart";
// import "package:firebase_crashlytics/firebase_crashlytics.dart";
// import "package:firebase_messaging/firebase_messaging.dart";
// import "package:flutter/foundation.dart";
// import "package:flutter/material.dart";
// import "package:flutter_localizations/flutter_localizations.dart";
// import "package:get/get.dart";
// import "package:upgrader/upgrader.dart";

// @pragma("vm:entry-point")
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   return Future<void>.value();
// }

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   SecurityContext.defaultContext.allowLegacyUnsafeRenegotiation = true;
//   HttpOverrides.global = MyHttpOverrides();

//   final FirebaseOptions options = DefaultFirebaseOptions.currentPlatform;
//   await Firebase.initializeApp(options: options);

//   if (kReleaseMode) {
//     FlutterError.onError = (FlutterErrorDetails errorDetails) {
//       AppLogger().error(
//         message: "FlutterError.onError: ${errorDetails.exceptionAsString()}",
//         error: errorDetails.exception,
//         stackTrace: errorDetails.stack,
//       );
//       FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
//     };
//     PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
//       AppLogger().error(
//         message: "PlatformDispatcher.instance.onError",
//         error: error,
//         stackTrace: stack,
//       );
//       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//       return true;
//     };
//   } else {}

//   injectDependencies();
//   await initDependencies();

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: "Ahinsa Aggregator Customer App",
//       theme: themeData(brightness: Brightness.light),
//       darkTheme: themeData(brightness: Brightness.light),
//       getPages: AppRoutes().getPages(),
//       routingCallback: AppNavService().observer,
//       navigatorKey: Get.key,
//       navigatorObservers: <NavigatorObserver>[
//         AppAnalyticsService().firebaseAnalyticsObserver(),
//       ],
//       debugShowCheckedModeBanner: false,
//       builder: (BuildContext context, Widget? child) {
//         final Locale locale = AppStorageService().getUserLangFromStorage();
//         return MediaQuery(
//           data: context.mediaQuery.copyWith(textScaler: TextScaler.noScaling),
//           child: AppLoader().globalLoaderOverlay(
//             child: AppKeyboardManager().globalKeyboardDismisser(
//               child: UpgradeAlert(
//                 navigatorKey: Get.key,
//                 upgrader: Upgrader(
//                   languageCode: locale.languageCode,
//                   countryCode: locale.countryCode ?? "",
//                   debugLogging: kDebugMode,
//                   durationUntilAlertAgain: Duration.zero,
//                 ),
//                 showIgnore: false,
//                 showLater: false,
//                 child: child ?? const SizedBox(),
//               ),
//             ),
//           ),
//         );
//       },
//       translations: AppTranslations(),
//       locale: AppStorageService().getUserLangFromStorage(),
//       supportedLocales: AppTranslations().supportedLocales(),
//       fallbackLocale: AppTranslations().supportedLocales()[0],
//       localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       defaultTransition: Transition.cupertino,
//       transitionDuration: Get.defaultTransitionDuration,
//     );
//   }

//   ThemeData themeData({required Brightness brightness}) {
//     final ThemeData themeData = ThemeData(
//       useMaterial3: true,
//       brightness: brightness,
//       colorSchemeSeed: AppColors().appPrimaryColor,
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       applyElevationOverlayColor: true,
//       textTheme: AppFonts().getTextTheme(),
//     );
//     return themeData;
//   }
// }
