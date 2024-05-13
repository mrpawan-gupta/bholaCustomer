import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class AppFonts {
  factory AppFonts() {
    return _singleton;
  }

  AppFonts._internal();
  static final AppFonts _singleton = AppFonts._internal();

  TextTheme getTextTheme() {
    return GoogleFonts.interTextTheme();
  }
}
