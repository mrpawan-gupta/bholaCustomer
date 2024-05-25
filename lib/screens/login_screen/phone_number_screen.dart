import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/login_screen_controllers/phone_number_screen_controller.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class PhoneNumberScreen extends GetView<PhoneNumberScreenController> {
  const PhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: Get.height / 4,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                AppAssetsImages().splash,
                height: Get.height,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 32),
                  Text(
                    AppLanguageKeys().strEnterYourPhoneNumber.tr,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    AppLanguageKeys().strAConfirmationCode.tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors().appGreyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: AppColors().appGreyColor.withOpacity(0.10),
                        width: 2,
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 16 + 8),
                          Image.asset(
                            AppAssetsImages().flag,
                            height: 24,
                            width: 24 + 8,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          VerticalDivider(
                            color: AppColors().appGreyColor,
                            indent: 8,
                            endIndent: 8,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "+91",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppColors().appGreyColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AppTextField(
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.phone,
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.done,
                              readOnly: false,
                              obscureText: false,
                              maxLines: 1,
                              maxLength: null,
                              onChanged: (String value) async {
                                value.length.isGreaterThan(10)
                                    ? controller.stringOperation(
                                        fullPhoneNumber: value,
                                      )
                                    : controller.updatePhoneNo(
                                        value,
                                      );

                                controller.unfocus(callAPI: sendOTPAPICall);
                              },
                              onTap: () {},
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.singleLineFormatter,
                                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                              ],
                              enabled: true,
                              autofillHints: const <String>[
                                AutofillHints.telephoneNumber,
                              ],
                              hintText: "9876543210",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors().appGreyColor,
                              ),
                              prefixIcon: null,
                              suffixIcon: null,
                            ),
                          ),
                          const SizedBox(width: 16 + 8),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height / 8),
                  AppElevatedButton(
                    text: AppLanguageKeys().strContinue.tr,
                    onPressed: () async {
                      final String reason = controller.validate();
                      if (reason.isEmpty) {
                        await sendOTPAPICall();
                      } else {
                        AppSnackbar().snackbarFailure(
                          title: "Oops",
                          message: reason,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendOTPAPICall() async {
    await controller.sendOTPAPICall(
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(
          title: "Yay!",
          message: json["message"],
        );

        await AppNavService().pushNamed(
          destination: AppRoutes().otpScreen,
          arguments: <String, dynamic>{
            "phoneNumber": controller.rxPhoneNumber.value,
          },
        );
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(
          title: "Oops",
          message: json["message"],
        );
      },
    );
    return Future<void>.value();
  }
}
