import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class DisableButton extends StatelessWidget {
  const DisableButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors().appGreyColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        minimumSize: const Size(335.0, 48.0),
      ),
      child: Text(
        AppLanguageKeys().strNext.tr,
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          color: AppColors().appWhiteColor,
          height: 1.5,
        ),
      ),
    );
  }
}
