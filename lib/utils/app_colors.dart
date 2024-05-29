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
  final Color appGrey = const Color.fromRGBO(60, 60, 67, 0.6);
  final Color appBlueColor = Colors.blue;
  final Color appGrey_ = const Color.fromRGBO(60, 60, 67, 0.6);
}
