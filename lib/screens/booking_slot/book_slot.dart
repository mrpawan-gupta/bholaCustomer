import "package:customer/common_widgets/search.dart";
import "package:customer/controllers/booking_slot_controllers/book_slot_controllers.dart";
import "package:customer/screens/widgets/textWidgets.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:syncfusion_flutter_sliders/sliders.dart";



class BookSlot extends GetView<BookSlotController> {
   const BookSlot({super.key});


  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != controller.selectedDate.value) {
      controller.updateSelectedDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().appWhiteColor,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors().appWhiteColor,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          AppLanguageKeys().strBhola.tr,
          style:  TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors().appOrangeColor,
              fontSize: 30,
              fontStyle: FontStyle.italic,),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            AppAssetsImages.menu,
            height: 35,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsImages.cart,
              height: 28,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              AppAssetsImages.notification,
              height: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 80),
        child: Column(
          children: <Widget>[
            SearchTab(
              text: AppLanguageKeys().strFarm_Location.tr,
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text: AppLanguageKeys().strSchedule.tr,
                      color: AppColors().appBlackColor,
                      size: 19,
                      fontWeight: FontWeight.bold,
                      isLineThrough: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () => selectDate(context),
                      child: Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          border: Border.all(
                            width: 3,
                            color: AppColors().appPrimaryColor,
                          ),
                        ),
                        child:  Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLanguageKeys().strSelect1.tr,
                              ),
                               Icon(
                                Icons.date_range,
                                color: AppColors().appPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text: AppLanguageKeys().strCrop.tr,
                      color: AppColors().appBlackColor,
                      size: 19,
                      fontWeight: FontWeight.bold,
                      isLineThrough: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          width: 3,
                          color: AppColors().appPrimaryColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: DropdownButton(
                          icon:  Icon(
                            // Add this
                            Icons.arrow_drop_down, // Add this
                            color: AppColors().appPrimaryColor, // Add this
                          ),
                          underline: Container(),
                          hint: controller.dropDownValue.value == ""
                              ?  Text(AppLanguageKeys().strSelect.tr,)
                              : Text(
                            controller.dropDownValue.value,
                            style:  TextStyle(
                              color: AppColors().appPrimaryColor,),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style:  TextStyle(
                            color: AppColors().appPrimaryColor,),
                          items: <String>["One", "Two", "Three"].map(
                                (String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (String? val) {
                            if(val != null) {
                              controller.updateDropDownValue(val);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: AppLanguageKeys().strSlot.tr,
                color: AppColors().appBlackColor,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: AppColors().appPrimaryColor,
                    backgroundColor: Colors.green[100],
                    label:  Text(AppLanguageKeys().strMorning.tr),
                    selected: controller.value.value == 0,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 0 : -1);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: AppColors().appPrimaryColor,
                    backgroundColor: Colors.green[100],
                    label:  Text(AppLanguageKeys().strAfternoon.tr,),
                    selected: controller.value.value == 1,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 1 : false);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: AppColors().appPrimaryColor,
                    backgroundColor: Colors.green[100],
                    label:  Text(AppLanguageKeys().strEvening.tr,),
                    selected: controller.value.value == 2,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 2 : false);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ChoiceChip(
                    pressElevation: 0.0,
                    selectedColor: AppColors().appPrimaryColor,
                    backgroundColor: Colors.green[100],
                    label:  Text(AppLanguageKeys().strNight.tr,),
                    selected: controller.value.value == 3,
                    onSelected: (bool selected) {
                      controller.updateValue(selected ? 3 : false);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextWidget(
                text: AppLanguageKeys().strService.tr,
                color: AppColors().appBlackColor,
                size: 19,
                fontWeight: FontWeight.bold,
                isLineThrough: false,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(
                      width: 3,
                      color: AppColors().appPrimaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: DropdownButton(
                      icon:  Icon(
                        // Add this
                        Icons.arrow_drop_down, // Add this
                        color: AppColors().appPrimaryColor, // Add this
                      ),
                      underline: Container(),
                      hint: controller.dropDownValue.value == ""
                          ?  Text(AppLanguageKeys().strSelect.tr,)
                          : Text(
                        controller.dropDownValue.value,
                        style:  TextStyle(
                          color: AppColors().appPrimaryColor,),
                      ),
                      isExpanded: true,
                      iconSize: 30.0,
                      style:  TextStyle(color: AppColors().appPrimaryColor,),
                      items: <String>["One", "Two", "Three"].map(
                            (String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        },
                      ).toList(),
                      onChanged: (String? val) {
                        if(val != null) {
                          controller.updateDropDownValue(val);
                        }
                      },
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 3,
                        color: AppColors().appPrimaryColor,
                      ),
                    ),
                    child:  Icon(
                      Icons.add,
                      color: AppColors().appPrimaryColor,
                      size: 40,
                    ),),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextWidget(
                  text: AppLanguageKeys().strFarm_Area.tr,
                  color: AppColors().appBlackColor,
                  size: 19,
                  fontWeight: FontWeight.bold,
                  isLineThrough: false,
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors().appGreyColor,),
                    height: 30,
                    width: 70,
                    child:  Center(child: Text(AppLanguageKeys().
                    str15_Acer.tr,),),),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  child: SfSlider(
                    activeColor: AppColors().appPrimaryColor,
                    max: 20.0,
                    value: controller.sliderSel.value,
                    interval: 5,
                    stepSize: 1,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 5,
                    onChanged: (value) {
                      if(value != null) {
                        controller.updateSliderValue(value);
                      }
                    },
                  ),
                ),
                Container(
                    height: 50,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 3,
                        color: AppColors().appPrimaryColor,
                      ),
                    ),
                    child:  Center(
                        child: Text("10",
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors().appPrimaryColor,
                                fontWeight: FontWeight.w600,),),),),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(AppColors().appWhiteColor,),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors().appPrimaryColor,),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side:  BorderSide(
                                color: AppColors().appPrimaryColor,),),),),
                  onPressed: () async {
                    await AppNavService().pushNamed(
                      destination: AppRoutes().selectedSlotScreen,
                      arguments: <String, dynamic>{},
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text( AppLanguageKeys().strGET_OUOTE.tr
                          .toUpperCase(),
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
