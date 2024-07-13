import "package:customer/services/app_internet_connection_checker_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppFonts {
  factory AppFonts() {
    return _singleton;
  }

  AppFonts._internal();
  static final AppFonts _singleton = AppFonts._internal();

  TextTheme getTextTheme() {
    TextTheme textTheme = const TextTheme();
    final bool value = AppNetCheckService().hasConnectionSynchronous;
    GoogleFonts.config.allowRuntimeFetching = value;
    try {
      if (value) {
        textTheme = GoogleFonts.latoTextTheme();
        AppLogger().info(message: "getTextTheme(): Font Updated to Lato.");
      } else {
        AppLogger().info(message: "getTextTheme(): Font Not Updated to Lato.");
      }
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
    } finally {}
    return textTheme;
  }
}
