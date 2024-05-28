import "dart:convert";

import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:customer/models/create_booking.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_all_services.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:customer/utils/localization/app_language_keys.dart";
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Obx(
              () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    searchBarWidget(),
                    const SizedBox(height: 16),
                    cropTextFieldWidget(),
                    const SizedBox(height: 16),
                    slotWidget(),
                    const SizedBox(height: 16),
                    scheduleAndServiceWidget(),
                    const SizedBox(height: 16),
                    farmAreaWidget(),
                    const SizedBox(height: 16),
                    clearFormWidget(),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ),
        buttonWidget(context),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SearchAnchor.bar(
            barLeading: Icon(
              Icons.search,
              color: AppColors().appPrimaryColor,
            ),
            barHintText: "Search by addresses",
            searchController: controller.searchController,
            onChanged: controller.updateQuery,
            onSubmitted: controller.updateQuery,
            barShape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors().appGreyColor.withOpacity(0.10),
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            barElevation: const MaterialStatePropertyAll<double>(0),
            viewElevation: 0,
            isFullScreen: false,
            barHintStyle: MaterialStatePropertyAll<TextStyle>(
              TextStyle(
                color: AppColors().appGreyColor,
              ),
            ),
            viewHeaderHintStyle: TextStyle(
              color: AppColors().appGreyColor,
            ),
            barTrailing: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.location_on,
                  color: AppColors().appPrimaryColor,
                ),
                onPressed: showPlacePicker,
              ),
            ],
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
        ],
      ),
    );
  }

  Widget cropTextFieldWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Crop",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              child: AppTextField(
                                controller: controller.cropNameController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.done,
                                readOnly: false,
                                obscureText: false,
                                maxLines: 1,
                                maxLength: null,
                                onChanged: controller.rxCropName,
                                onTap: () {},
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z]"),
                                  ),
                                  FilteringTextInputFormatter.deny(
                                    RegExp(r"\s"),
                                  ),
                                ],
                                enabled: true,
                                autofillHints: const <String>[],
                                hintText: "Wheat",
                                hintStyle: TextStyle(
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
                      "Date",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              child: AppTextField(
                                controller: controller.dateController,
                                keyboardType: TextInputType.none,
                                textCapitalization: TextCapitalization.none,
                                textInputAction: TextInputAction.done,
                                readOnly: true,
                                obscureText: false,
                                maxLines: 1,
                                maxLength: null,
                                onChanged: controller.rxDate,
                                onTap: () async {
                                  await selectDate(
                                    onPicked: (String tz, String format) {
                                      controller.dateController.text = format;
                                      controller.rxDate(tz);
                                    },
                                  );
                                },
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter,
                                ],
                                enabled: true,
                                autofillHints: const <String>[],
                                hintText: "Pick Date",
                                hintStyle: TextStyle(
                                  color: AppColors().appGreyColor,
                                ),
                                prefixIcon: null,
                                suffixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: AppColors().appPrimaryColor,
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
            ],
          ),
        ],
      ),
    );
  }

  Widget slotWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "Slot",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: DecoratedBox(
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
                          child: AppTextField(
                            controller: controller.startTimeController,
                            keyboardType: TextInputType.none,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.done,
                            readOnly: true,
                            obscureText: false,
                            maxLines: 1,
                            maxLength: null,
                            onChanged: controller.rxStartTime,
                            onTap: () async {
                              await selectTime(
                                onPicked: (String tz, String format) {
                                  controller.startTimeController.text = format;
                                  controller.rxStartTime(tz);
                                },
                              );
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            enabled: true,
                            autofillHints: const <String>[],
                            hintText: "Start Time",
                            hintStyle: TextStyle(
                              color: AppColors().appGreyColor,
                            ),
                            prefixIcon: null,
                            suffixIcon: Icon(
                              Icons.access_time,
                              color: AppColors().appPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DecoratedBox(
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
                          child: AppTextField(
                            controller: controller.endTimeController,
                            keyboardType: TextInputType.none,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.done,
                            readOnly: true,
                            obscureText: false,
                            maxLines: 1,
                            maxLength: null,
                            onChanged: controller.rxEndTime,
                            onTap: () async {
                              await selectTime(
                                onPicked: (String tz, String format) {
                                  controller.endTimeController.text = format;
                                  controller.rxEndTime(tz);
                                },
                              );
                            },
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.singleLineFormatter,
                            ],
                            enabled: true,
                            autofillHints: const <String>[],
                            hintText: "End Time",
                            hintStyle: TextStyle(
                              color: AppColors().appGreyColor,
                            ),
                            prefixIcon: null,
                            suffixIcon: Icon(
                              Icons.access_time,
                              color: AppColors().appPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget scheduleAndServiceWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Categories>(
                                  value: mapEquals(
                                    controller.rxSelectedCategory.value
                                        .toJson(),
                                    Categories().toJson(),
                                  )
                                      ? null
                                      : controller.rxSelectedCategory.value,
                                  items: controller.categoriesList.map(
                                    (
                                      Categories value,
                                    ) {
                                      return DropdownMenuItem<Categories>(
                                        value: value,
                                        child: Text(value.name ?? ""),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (
                                    Categories? value,
                                  ) async {
                                    if (value != null) {
                                      controller.rxSelectedCategory(value);

                                      await controller.getServicesAPI();
                                    } else {}
                                  },
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors().appPrimaryColor,
                                  ),
                                  hint: Text(
                                    "Pick Category",
                                    style: TextStyle(
                                      color: AppColors().appGreyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
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
                      "Service",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Services>(
                                  value: mapEquals(
                                    controller.rxSelectedService.value.toJson(),
                                    Services().toJson(),
                                  )
                                      ? null
                                      : controller.rxSelectedService.value,
                                  items: controller.servicesList.map(
                                    (
                                      Services value,
                                    ) {
                                      return DropdownMenuItem<Services>(
                                        value: value,
                                        child: Text(value.name ?? ""),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (
                                    Services? value,
                                  ) {
                                    if (value != null) {
                                      controller.rxSelectedService(value);
                                    } else {}
                                  },
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors().appPrimaryColor,
                                  ),
                                  hint: Text(
                                    "Pick Service",
                                    style: TextStyle(
                                      color: AppColors().appGreyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget farmAreaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Farm Area",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: AppColors().appPrimaryColor,
                ),
                child: Text(
                  "${controller.rxFarmArea.value} Acre",
                  style: TextStyle(color: AppColors().appWhiteColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
                          // ignore: avoid_dynamic_calls
                          final dynamic temp = value.toStringAsFixed(2);
                          final double temp2 = double.tryParse(temp) ?? 0.0;
                          controller.rxFarmArea(temp2);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppElevatedButton(
            text: "Get Quote",
            onPressed: () async {
              final String reason = controller.validateForm();

              if (reason.isEmpty) {
                CreateBookingData model = CreateBookingData();
                model = await controller.createBookingAPI()

                  //
                  ..vendorsAvailable = true;
                //

                if (!mapEquals(model.toJson(), CreateBookingData().toJson())) {
                  final String id = model.booking?.sId ?? "";

                  await openBookingGlanceWidget(
                    data: model,
                    onPressedConfirm: () async {
                      bool value = false;
                      value = await controller.confirmOrderAPICall(id: id);

                      if (value) {
                        controller.clearForm();

                        final String data = json.encode(model.toJson());
                        await AppNavService().pushNamed(
                          destination: AppRoutes().bookingPaymentScreen,
                          arguments: <String, dynamic>{"id": id, "data": data},
                        );
                      } else {}
                    },
                    onPressedSupport: AppWhatsApp().openWhatsApp,
                  );
                } else {}
              } else {
                AppSnackbar().snackbarFailure(title: "Oops", message: reason);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget clearFormWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: controller.clearForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Clear Form",
                style: TextStyle(
                  color: AppColors().appPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
        AppSnackbar().snackbarFailure(
          title: "Oops",
          message: reason,
        );
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

  Future<void> openBookingGlanceWidget({
    required CreateBookingData data,
    required Function() onPressedConfirm,
    required Function() onPressedSupport,
  }) async {
    await Get.bottomSheet(
      (data.vendorsAvailable ?? false)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  AppLanguageKeys().strActionPerform.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "The selected service is currently available in your area.",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          "• Price Per Acre:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "₹${data.booking?.services?.first.price ?? 0}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          "• Farm Area:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${data.booking?.farmArea ?? 0}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          "• Total amount (Price per Acre * Farm Area):",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "₹${data.booking?.amount ?? 0}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: AppTextButton(
                            text: "Select different service",
                            onPressed: () async {
                              AppNavService().pop();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: AppElevatedButton(
                            text: "Confirm Booking",
                            onPressed: () {
                              AppNavService().pop();
                              onPressedConfirm();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 48),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 16),
                Text(
                  AppLanguageKeys().strActionPerform.tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    // ignore: lines_longer_than_80_chars
                    "The selected service is currently not available in your area. Try Selecting the different service or contact the support team.",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: AppTextButton(
                            text: "Select different service",
                            onPressed: () async {
                              AppNavService().pop();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: AppElevatedButton(
                            text: "Contact Support",
                            onPressed: () {
                              AppNavService().pop();
                              onPressedSupport();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 48),
              ],
            ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }
}
