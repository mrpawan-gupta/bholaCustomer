import "package:customer/controllers/outer_main_controllers/booking_slot_controllers/selected_slot_controllers.dart";
import "package:customer/screens/widgets/text_widgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SelectedSlotScreen extends GetView<SelectedSlotController> {
  const SelectedSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          CupertinoIcons.back,
          size: 35,
        ),
        centerTitle: true,
        titleSpacing: 0,
        title: TextWidget(
          text: AppLanguageKeys().strQuote.tr,
          color: AppColors().appBlackColor,
          size: 25,
          fontWeight: FontWeight.bold,
          isLineThrough: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: AppLanguageKeys().strSelectSlot.tr,
                color: AppColors().appBlackColor,
                size: 20,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().appGreyColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: controller.selectedOption.value == 1
                    ? Colors.green.shade100
                    : AppColors().appGreyColor,
              ),
              height: 80,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          AppAssetsImages.morning,
                          height: 50,
                          width: 50,
                          color: controller.selectedOption.value == 1
                              ? Colors.green.shade900
                              : Colors.grey.shade900,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: AppLanguageKeys().strMorning.tr,
                              color: AppColors().appBlackColor,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              isLineThrough: false,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                TextWidget(
                                  text: AppLanguageKeys().strRent.tr,
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.1000",
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  isLineThrough: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Radio<int>(
                      value: 1,
                      groupValue: controller.selectedOption.value,
                      activeColor: AppColors().appPrimaryColor,
                      onChanged: (int? value) {
                        if (value != null) {
                          controller.setSelectedOption(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().appGreyColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: controller.selectedOption.value == 2
                    ? Colors.green.shade100
                    : AppColors().appGreyColor,
              ),
              height: 80,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          AppAssetsImages.afternoon,
                          height: 50,
                          width: 50,
                          color: controller.selectedOption.value == 2
                              ? Colors.green.shade900
                              : Colors.grey.shade900,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: AppLanguageKeys().strAfternoon.tr,
                              color: AppColors().appBlackColor,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              isLineThrough: false,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                TextWidget(
                                  text: AppLanguageKeys().strRent.tr,
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.2000",
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  isLineThrough: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Radio<int>(
                      value: 2,
                      groupValue: controller.selectedOption.value,
                      activeColor: AppColors().appPrimaryColor,
                      onChanged: (int? value) {
                        if (value != null) {
                          controller.setSelectedOption(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().appGreyColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: controller.selectedOption.value == 3
                    ? Colors.green.shade100
                    : AppColors().appGreyColor,
              ),
              height: 80,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          AppAssetsImages.evening,
                          height: 50,
                          width: 50,
                          color: controller.selectedOption.value == 3
                              ? Colors.green.shade900
                              : AppColors().appGreyColor,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: AppLanguageKeys().strEvening.tr,
                              color: AppColors().appBlackColor,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              isLineThrough: false,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                TextWidget(
                                  text: AppLanguageKeys().strRent.tr,
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.3000",
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  isLineThrough: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Radio<int>(
                      value: 3,
                      groupValue: controller.selectedOption.value,
                      activeColor: AppColors().appPrimaryColor,
                      onChanged: (int? value) {
                        if (value != null) {
                          controller.setSelectedOption(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors().appGreyColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: controller.selectedOption.value == 4
                    ? Colors.green.shade100
                    : AppColors().appGreyColor,
              ),
              height: 80,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          AppAssetsImages.night,
                          height: 50,
                          width: 50,
                          color: controller.selectedOption.value == 4
                              ? Colors.green.shade900
                              : AppColors().appGreyColor,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: AppLanguageKeys().strNight.tr,
                              color: AppColors().appBlackColor,
                              size: 16,
                              fontWeight: FontWeight.bold,
                              isLineThrough: false,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                TextWidget(
                                  text: AppLanguageKeys().strRent.tr,
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.1000",
                                  color: AppColors().appBlackColor,
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  isLineThrough: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Radio<int>(
                      value: 4,
                      groupValue: controller.selectedOption.value,
                      activeColor: AppColors().appPrimaryColor,
                      onChanged: (int? value) {
                        if (value != null) {
                          controller.setSelectedOption(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    AppColors().appWhiteColor,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors().appPrimaryColor,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: AppColors().appPrimaryColor,
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLanguageKeys().strBookService.tr.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      CupertinoIcons.arrow_right,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
