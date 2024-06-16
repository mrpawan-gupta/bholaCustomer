import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/controllers/login_screen_controllers/otp_screen_controller.dart";
import "package:customer/services/app_sms_retriever_implementation.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_timer_countdown/flutter_timer_countdown.dart";
import "package:get/get.dart";
import "package:pinput/pinput.dart";

class OTPScreen extends GetView<OTPScreenController> {
  const OTPScreen({super.key});

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
                    AppLanguageKeys().strEnter6Digits.tr,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "+91${controller.rxPhoneNumber.value}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors().appGreyColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Pinput(
                    smsRetriever: AppSMSRetrieverImplementation(),
                    length: 6,
                    autofocus: true,
                    controller: controller.otpController,
                    onChanged: (String value) {
                      controller
                        ..updateOTP(value)
                        ..unfocus();
                    },
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.singleLineFormatter,
                      FilteringTextInputFormatter.deny(RegExp(r"\s")),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    followingPinTheme: PinTheme(
                      height: 84,
                      width: 72,
                      decoration: BoxDecoration(
                        color: AppColors().appWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors().appGreyColor.withOpacity(0.10),
                          width: 2,
                        ),
                      ),
                    ),
                    defaultPinTheme: PinTheme(
                      height: 84,
                      width: 72,
                      decoration: BoxDecoration(
                        color: AppColors().appWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors().appPrimaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () {
                      return !controller.isTimePassed()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Resend OTP in: ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().appGreyColor,
                                  ),
                                ),
                                TimerCountdown(
                                  format: CountDownTimerFormat.secondsOnly,
                                  enableDescriptions: false,
                                  endTime: controller.otpResendDateTime.value,
                                  onTick: (Duration duration) {},
                                  onEnd: controller.timerEnd,
                                  timeTextStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors().appGreyColor,
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              borderRadius: BorderRadius.circular(32),
                              onTap: () async {
                                await controller.sendOTPAPICall();
                              },
                              child: Text(
                                AppLanguageKeys().strResend.tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors().appPrimaryColor,
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(height: Get.height / 16),
                  AppElevatedButton(
                    text: AppLanguageKeys().strContinue.tr,
                    onPressed: () async {
                      final String reason = controller.formValidate();
                      if (reason.isEmpty) {
                        await controller.verifyOTPAPICall();
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
}
