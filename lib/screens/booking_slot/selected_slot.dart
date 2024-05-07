import "package:customer/controllers/booking_slot_controllers/selected_slot_controllers.dart";
import "package:customer/screens/widgets/textWidgets.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";



class SelectedSlot extends GetView<SelectedSlotController> {
  const SelectedSlot({super.key});


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
          text: "${AppLanguageKeys().strQuote.tr}, "
              "Quote",
          color: Colors.black,
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
                text: "${AppLanguageKeys().strSelect_Slot.tr}, "
                    "Select Slot",
                color: Colors.black,
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: controller.selectedOption.value == 1
                      ? Colors.green.shade100
                      : Colors.grey.shade200,),
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
                                : Colors.grey.shade900
                        ,),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: "${AppLanguageKeys().strMorning.tr}, "
                                  "Morning",
                              color: Colors.black,
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
                                  text: "${AppLanguageKeys().strRent.tr}, "
                                      "Rent will be",
                                  color: Colors.black,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.1000",
                                  color: Colors.black,
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
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        if(value != null) {
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: controller.selectedOption.value == 2
                      ? Colors.green.shade100
                      : Colors.grey.shade200,),
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
                              text: "${AppLanguageKeys().strAfternoon.tr}, "
                                  "Afternoon",
                              color: Colors.black,
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
                                  text: "${AppLanguageKeys().strRent.tr}, "
                                      "Rent will be",
                                  color: Colors.black,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.2000",
                                  color: Colors.black,
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
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        if(value != null) {
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: controller.selectedOption.value == 3
                      ? Colors.green.shade100
                      : Colors.grey.shade200,),
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
                                : Colors.grey.shade900,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: "${AppLanguageKeys().strEvening.tr}, "
                                  "Evening",
                              color: Colors.black,
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
                                  text: "${AppLanguageKeys().strRent.tr}, "
                                      "Rent will be",
                                  color: Colors.black,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.3000",
                                  color: Colors.black,
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
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        if(value != null) {
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: controller.selectedOption.value == 4
                      ? Colors.green.shade100
                      : Colors.grey.shade200,),
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
                                : Colors.grey.shade900,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextWidget(
                              text: "${AppLanguageKeys().strNight.tr}, "
                                  "Night",
                              color: Colors.black,
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
                                  text: "${AppLanguageKeys().strRent.tr}, "
                                      "Rent will be",
                                  color: Colors.black,
                                  size: 14,
                                  fontWeight: FontWeight.w400,
                                  isLineThrough: false,
                                ),
                                TextWidget(
                                  text: "Rs.1000",
                                  color: Colors.black,
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
                      activeColor: Colors.green,
                      onChanged: (int? value) {
                        if(value != null) {
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
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.green),),),),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${AppLanguageKeys().strBook_Service.tr}, "
                  "Book Service".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold,),),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        CupertinoIcons.arrow_right,
                        size: 22,
                      ),
                    ],
                  ),),
            ),
          ],
        ),
      ),
    );
  }
}
