// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:customer/models/create_booking.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_all_crops_model.dart";
import "package:customer/models/get_all_services.dart";
import "package:customer/screens/outer_main_screens/booking/my_utils/custom_dd_for_categories.dart";
import "package:customer/screens/outer_main_screens/booking/my_utils/custom_dd_for_services.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_intro_bottom_sheet.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:place_picker/place_picker.dart";
import "package:syncfusion_flutter_sliders/sliders.dart";

class BookingScreen extends GetView<BookingController> {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Obx(
              () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    searchBarWidget(),
                    categoryAndServiceWidget(),
                    cropAndTimeWidget(),
                    slotWidget(),
                    timeDiffWidget(),
                    farmAreaWidget(),
                    clearAllFormDataButton(),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ),
        getQuoteButtonWidget(context),
        const SizedBox(height: 16),
        viewAlreadyAddedQuotationsButton(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget searchBarWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: SearchAnchor.bar(
                searchController: controller.searchController,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                onChanged: controller.updateQuery,
                onSubmitted: controller.updateQuery,
                isFullScreen: false,
                barBackgroundColor: MaterialStatePropertyAll<Color>(
                  AppColors().appWhiteColor,
                ),
                viewBackgroundColor: AppColors().appWhiteColor,
                barLeading: Icon(
                  Icons.search,
                  color: AppColors().appPrimaryColor,
                ),
                barTrailing: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.location_on,
                      color: AppColors().appPrimaryColor,
                    ),
                    onPressed: reviewLocationPermissionStatus,
                  ),
                ],
                barHintText: "Search by addresses",
                viewHintText: "Search by addresses",
                barElevation: const MaterialStatePropertyAll<double>(0),
                viewElevation: 0,
                barHintStyle: MaterialStatePropertyAll<TextStyle>(
                  TextStyle(
                    fontSize: 14,
                    color: AppColors().appGreyColor,
                  ),
                ),
                viewHeaderHintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors().appGreyColor,
                ),
                barShape: MaterialStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(
                      color: AppColors().appGreyColor.withOpacity(0.10),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                viewShape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppColors().appGreyColor.withOpacity(0.10),
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                suggestionsBuilder: (
                  BuildContext context,
                  SearchController searchController,
                ) {
                  final List<Address> items = controller.getSuggestions();
                  return List<Widget>.generate(
                    items.length,
                    (int index) {
                      final String item = items[index].street ?? "";
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.pin_drop_outlined,
                          color: AppColors().appPrimaryColor,
                        ),
                        title: Text(item),
                        onTap: () {
                          controller.searchController.text = item;
                          controller.rxSearchQuery(item);

                          if (searchController.isOpen) {
                            searchController.closeView(item);
                          } else {}
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget categoryAndServiceWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Rental category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: controller.categoriesList.isEmpty
                            ? AppColors().appRedColor.withOpacity(0.10)
                            : AppColors().appGreyColor.withOpacity(0.10),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 16 + 8),
                          Expanded(
                            child: CustomDDForCategories(
                              selectedItem: mapEquals(
                                controller.rxSelectedCategory.value.toJson(),
                                Categories().toJson(),
                              )
                                  ? null
                                  : controller.rxSelectedCategory.value,
                              items: controller.categoriesList,
                              onChanged: (Categories? value) async {
                                if (value != null) {
                                  await controller.updateFormFurther(value);
                                } else {}
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Rental service",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: controller.servicesList.isEmpty
                            ? AppColors().appRedColor.withOpacity(0.10)
                            : AppColors().appGreyColor.withOpacity(0.10),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 16 + 8),
                          Expanded(
                            child: CustomDDForServices(
                              selectedItem: mapEquals(
                                controller.rxSelectedService.value.toJson(),
                                Services().toJson(),
                              )
                                  ? null
                                  : controller.rxSelectedService.value,
                              items: controller.servicesList,
                              onChanged: (Services? value) {
                                if (value != null) {
                                  controller.rxSelectedService(value);
                                } else {}
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget cropAndTimeWidget() {
    final bool cond1 = controller.rxNeedToShowAreaWidget.value;
    final bool cond2 = controller.rxNeedToShowHourWidget.value;
    final bool isOptional = !cond1 & cond2;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isOptional ? "Crop name (optional)" : "Crop name",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors().appGreyColor.withOpacity(0.10),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 16 + 8),
                          Expanded(
                            child: commonTextField(
                              controller: controller.cropNameController,
                              readOnly: true,
                              onChanged: controller.rxCropName,
                              onTap: onTapCropName,
                              hintText: "Wheat",
                              suffixIcon: IconButton(
                                icon: controller.rxCropName.value.isEmpty
                                    ? const Icon(Icons.yard)
                                    : const Icon(Icons.close),
                                color: AppColors().appPrimaryColor,
                                onPressed: controller.rxCropName.value.isEmpty
                                    ? () {}
                                    : () {
                                        controller.rxSelectedCrop(Crops());
                                        controller.cropNameController.clear();
                                        controller.rxCropName("");
                                      },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Booking Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors().appGreyColor.withOpacity(0.10),
                      ),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(width: 16 + 8),
                          Expanded(
                            child: commonTextField(
                              controller: controller.dateController,
                              readOnly: true,
                              onChanged: controller.rxDate,
                              onTap: openDatePicker,
                              hintText: "01-01-2024",
                              suffixIcon: IconButton(
                                icon: controller.rxDate.value.isEmpty
                                    ? const Icon(Icons.calendar_month)
                                    : const Icon(Icons.close),
                                color: AppColors().appPrimaryColor,
                                onPressed: controller.rxDate.value.isEmpty
                                    ? () {}
                                    : () {
                                        controller.dateController.clear();
                                        controller.rxDate("");
                                      },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget slotWidget() {
    return (controller.rxNeedToShowHourWidget.value)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Slot start time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors().appGreyColor.withOpacity(0.10),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 16 + 8),
                                Expanded(
                                  child: commonTextField(
                                    controller: controller.startTimeController,
                                    readOnly: true,
                                    onChanged: controller.rxStartTime,
                                    onTap: openStartTimePicker,
                                    hintText: "10:00 AM",
                                    suffixIcon: IconButton(
                                      icon: controller.rxStartTime.value.isEmpty
                                          ? const Icon(Icons.access_time_filled)
                                          : const Icon(Icons.close),
                                      color: AppColors().appPrimaryColor,
                                      onPressed:
                                          controller.rxStartTime.value.isEmpty
                                              ? () {}
                                              : () {
                                                  controller.startTimeController
                                                      .clear();
                                                  controller.rxStartTime("");
                                                },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Slot end time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors().appGreyColor.withOpacity(0.10),
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: <Widget>[
                                const SizedBox(width: 16 + 8),
                                Expanded(
                                  child: commonTextField(
                                    controller: controller.endTimeController,
                                    readOnly: true,
                                    onChanged: controller.rxEndTime,
                                    onTap: openEndTimePicker,
                                    hintText: "12:00 PM",
                                    suffixIcon: IconButton(
                                      icon: controller.rxEndTime.value.isEmpty
                                          ? const Icon(Icons.access_time_filled)
                                          : const Icon(Icons.close),
                                      color: AppColors().appPrimaryColor,
                                      onPressed:
                                          controller.rxEndTime.value.isEmpty
                                              ? () {}
                                              : () {
                                                  controller.endTimeController
                                                      .clear();
                                                  controller.rxEndTime("");
                                                },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 16),
            ],
          )
        : const SizedBox();
  }

  Widget timeDiffWidget() {
    final double value = controller.timeDiff();
    return (controller.rxNeedToShowHourWidget.value)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 16),
                  const Text(
                    "🕰️",
                    style: TextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 4),
                  const Flexible(
                    child: Text(
                      "Start time & End time difference:",
                      style: TextStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "$value hours",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: value == 0.0
                          ? AppColors().appBlackColor
                          : value > 0.0
                              ? AppColors().appPrimaryColor
                              : value < 0.0
                                  ? AppColors().appRedColor
                                  : AppColors().appBlackColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 16),
            ],
          )
        : const SizedBox();
  }

  Widget farmAreaWidget() {
    return (controller.rxNeedToShowAreaWidget.value)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              "Farm Area",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: AppColors().appPrimaryColor,
                                  ),
                                  child: Text(
                                    "${controller.rxFarmArea.value} Acre",
                                    style: TextStyle(
                                      color: AppColors().appWhiteColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors().appGreyColor.withOpacity(0.10),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  const SizedBox(width: 8),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (controller.rxFarmArea.value > 1) {
                                        controller.rxFarmArea(
                                          controller.rxFarmArea.value - 1,
                                        );
                                      } else {}
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      size: 32,
                                    ),
                                    color: AppColors().appPrimaryColor,
                                  ),
                                  Expanded(
                                    child: SfSlider(
                                      max: 100.0,
                                      value: controller.rxFarmArea.value,
                                      stepSize: 1,
                                      interval: 25,
                                      showTicks: true,
                                      showLabels: true,
                                      enableTooltip: true,
                                      minorTicksPerInterval: 1,
                                      activeColor: AppColors().appPrimaryColor,
                                      // ignore: avoid_annotating_with_dynamic
                                      onChanged: (dynamic value) {
                                        final dynamic temp =
                                            // ignore: avoid_dynamic_calls
                                            value.toStringAsFixed(2);
                                        final double temp2 =
                                            double.tryParse(temp) ?? 0.0;
                                        controller.rxFarmArea(temp2);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (controller.rxFarmArea.value < 100) {
                                        controller.rxFarmArea(
                                          controller.rxFarmArea.value + 1,
                                        );
                                      } else {}
                                    },
                                    icon:
                                        const Icon(Icons.add_circle, size: 32),
                                    color: AppColors().appPrimaryColor,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                              const SizedBox(height: 8 + 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              const SizedBox(height: 16),
            ],
          )
        : const SizedBox();
  }

  Widget getQuoteButtonWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: AppElevatedButton(
                text: "Get Quote",
                onPressed: onPressedGetQuote,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ],
    );
  }

  Widget clearAllFormDataButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: commonButton(
                text: "Clear all form data",
                onTap: controller.clearForm,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget viewAlreadyAddedQuotationsButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: commonButton(
                text: "View already added quotations",
                onTap: () async {
                  await AppNavService().pushNamed(
                    destination: AppRoutes().addedQuotesScreen,
                    arguments: <String, dynamic>{},
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget commonButton({required String text, required Function() onTap}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors().appGreyColor.withOpacity(0.10),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: AppColors().appPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<void> openDatePicker() async {
    await selectDate(
      onPicked: (String tz, String format) {
        controller.dateController.text = format;
        controller.rxDate(tz);
      },
    );
    return Future<void>.value();
  }

  Future<void> openStartTimePicker() async {
    await selectTime(
      onPicked: (String tz, String format) {
        controller.startTimeController.text = format;
        controller.rxStartTime(tz);
      },
    );
    return Future<void>.value();
  }

  Future<void> openEndTimePicker() async {
    await selectTime(
      onPicked: (String tz, String format) {
        controller.endTimeController.text = format;
        controller.rxEndTime(tz);
      },
    );
    return Future<void>.value();
  }

  Widget commonTextField({
    required TextEditingController controller,
    required bool readOnly,
    required void Function(String) onChanged,
    required void Function() onTap,
    required String hintText,
    required Widget? suffixIcon,
  }) {
    return AppTextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      readOnly: readOnly,
      obscureText: false,
      maxLines: 1,
      maxLength: null,
      onChanged: onChanged,
      onTap: onTap,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      enabled: true,
      autofillHints: const <String>[],
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 14, color: AppColors().appGreyColor),
      prefixIcon: null,
      suffixIcon: suffixIcon,
    );
  }

  Future<void> reviewLocationPermissionStatus() async {
    final bool try0 = await controller.checkLocationFunction();
    if (try0 == true) {
      await showPlacePicker();
    } else {
      await AppIntroBottomSheet().openLocationSheet(
        onContinue: () async {
          await controller.requestLocationFunction();

          final bool try1 = await controller.checkLocationFunction();
          if (try1 == true) {
            await showPlacePicker();
          } else {}
        },
      );
    }
    return Future<void>.value();
  }

  Future<void> showPlacePicker() async {
    final PlacePicker route = PlacePicker(AppConstants().googleMapAPIKey);

    final dynamic result = await Navigator.of(Get.context!).push(
      MaterialPageRoute<dynamic>(builder: (BuildContext context) => route),
    );

    if (result != null && result is LocationResult) {
      final String reason = controller.validateLocationResult(result: result);
      if (reason.isEmpty) {
        await controller.setAddressesAPI(result: result);

        final String formattedAddress = result.formattedAddress ?? "";
        controller.searchController.text = formattedAddress;
        controller.rxSearchQuery(formattedAddress);
        if (controller.searchController.isOpen) {
          controller.searchController.closeView(formattedAddress);
        } else {}
      } else {
        AppSnackbar().snackbarFailure(title: "Oops", message: reason);
      }
    } else {}
    return Future<void>.value();
  }

  Future<void> selectDate({
    required Function(String tz, String format) onPicked,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final DateTime dateTime = picked;
      final String formattedDate = DateFormat("dd-MM-yyyy").format(dateTime);
      onPicked(dateTime.toString(), formattedDate);
    } else {}
    return Future<void>.value();
  }

  Future<void> selectTime({
    required Function(String tz, String format) onPicked,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final DateTime dateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        picked.hour,
        picked.minute,
      );
      final String formattedTime = DateFormat("hh:mm a").format(dateTime);
      onPicked(dateTime.toString(), formattedTime);
    } else {}
    return Future<void>.value();
  }

  Future<void> onTapCropName() async {
    if ((controller.rxSelectedCategory.value.name ?? "").isNotEmpty) {
      final dynamic result = await AppNavService().pushNamed(
        destination: AppRoutes().selectCropScreen,
        arguments: <String, dynamic>{},
      );

      if (result != null && result is Crops) {
        final Crops temp = controller.rxSelectedCrop.value;
        final String selectedId = temp.sId ?? "";
        final String newId = result.sId ?? "";
        if (selectedId != newId) {
          controller.rxSelectedCrop(result);
          controller.cropNameController.text = result.name ?? "";
          controller.rxCropName(result.name ?? "");
        } else {}
      } else {}
    } else {
      AppSnackbar().snackbarFailure(
        title: "Oops",
        message: "Please select rental category first.",
      );
    }
    return Future<void>.value();
  }

  Future<void> onPressedGetQuote() async {
    final String reason = controller.validateForm();

    if (reason.isEmpty) {
      CreateBookingData model = CreateBookingData();
      model = await controller.createBookingAPI();

      final Map<String, dynamic> map1 = model.toJson();
      final Map<String, dynamic> map2 = CreateBookingData().toJson();
      final bool condition = !mapEquals(map1, map2);

      if (condition) {
        final Categories category = controller.rxSelectedCategory.value;
        final String displayType = category.displayType ?? "";
        final bool isMedicineSupported = displayType == displayTypeAreaWithMedicine;
        isMedicineSupported
            ? await AppNavService().pushNamed(
                destination: AppRoutes().bookingAddOnsScreen,
                arguments: <String, dynamic>{"id": model.sId ?? ""},
              )
            : await AppNavService().pushNamed(
                destination: AppRoutes().bookingDetailsScreen,
                arguments: <String, dynamic>{"id": model.sId ?? ""},
              );
        controller.clearForm();
      } else {}
    } else {
      AppSnackbar().snackbarFailure(title: "Oops", message: reason);
    }
    return Future<void>.value();
  }
}
