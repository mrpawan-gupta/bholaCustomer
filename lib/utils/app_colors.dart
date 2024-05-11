import "package:flutter/material.dart";

class AppColors {
  factory AppColors() {
    return _singleton;
  }

  AppColors._internal();
  static final AppColors _singleton = AppColors._internal();

  final Color appPrimaryColor = Colors.green;
  final Color appTransparentColor = Colors.transparent;
  final Color appWhiteColor = Colors.white;
  final Color appGreyColor = Colors.grey;
  final Color appOrangeColor = Colors.orange;
  final Color appBlackColor = Colors.black;
  final Color appYellowColor = Colors.yellow;
  final Color appRedColor = Colors.red;
}
