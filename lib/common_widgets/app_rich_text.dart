import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_in_app_browser.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

class AppRichText extends StatefulWidget {
  const AppRichText({super.key});

  @override
  State<AppRichText> createState() => _AppRichTextState();
}

class _AppRichTextState extends State<AppRichText> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: "By signing up, I agree to the ",
            style: TextStyle(color: AppColors().appBlackColor),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
          TextSpan(
            text: "Terms and Conditions",
            style: TextStyle(color: AppColors().appBlueColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await AppInAppBrowser().openInAppBrowser(
                  url: AppConstants().appURLsTAndCCustomer,
                );
              },
          ),
          TextSpan(
            text: " and ",
            style: TextStyle(color: AppColors().appBlackColor),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(color: AppColors().appBlueColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await AppInAppBrowser().openInAppBrowser(
                  url: AppConstants().appURLsPrivacyPolicy,
                );
              },
          ),
          TextSpan(
            text: ".",
            style: TextStyle(color: AppColors().appBlackColor),
            recognizer: TapGestureRecognizer()..onTap = () async {},
          ),
        ],
      ),
    );
  }
}
