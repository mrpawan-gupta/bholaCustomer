import "package:customer/utils/app_colors.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";
import "package:flutter/services.dart";

class AppOrientations {
  factory AppOrientations() {
    return _singleton;
  }

  AppOrientations._internal();
  static final AppOrientations _singleton = AppOrientations._internal();

  Future<void> initAppOrientations() async {
    await setPreferredOrientations();
    await setEnabledSystemUIMode();
    await setSystemUIOverlayStyle();
    return Future<void>.value();
  }

  Future<void> setPreferredOrientations() async {
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    return Future<void>.value();
  }

  Future<void> setEnabledSystemUIMode() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    return Future<void>.value();
  }

  Future<void> setSystemUIOverlayStyle() async {
    const ThemeMode themeMode = ThemeMode.light;
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle();
    switch (themeMode) {
      case ThemeMode.system:
        final SchedulerBinding schedulerBinding = SchedulerBinding.instance;
        final PlatformDispatcher pd = schedulerBinding.platformDispatcher;
        final Brightness platformBrightness = pd.platformBrightness;
        systemUiOverlayStyle = platformBrightness == Brightness.dark
            ? SystemUiOverlayStyle.light.copyWith(
                statusBarColor: AppColors().appTransparentColor,
                systemNavigationBarColor: AppColors().appTransparentColor,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: AppColors().appTransparentColor,
                systemNavigationBarColor: AppColors().appTransparentColor,
              );
        break;
      case ThemeMode.light:
        systemUiOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: AppColors().appTransparentColor,
          systemNavigationBarColor: AppColors().appTransparentColor,
        );
        break;
      case ThemeMode.dark:
        systemUiOverlayStyle = SystemUiOverlayStyle.light.copyWith(
          statusBarColor: AppColors().appTransparentColor,
          systemNavigationBarColor: AppColors().appTransparentColor,
        );
        break;
    }
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return Future<void>.value();
  }
}
