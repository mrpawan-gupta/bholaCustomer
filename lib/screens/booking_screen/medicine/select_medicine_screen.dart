// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars

import "package:customer/common_functions/medicine_cart_functions.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/booking_controller/select_medicine_controller.dart";
import "package:customer/models/get_all_medicines_model.dart";
import "package:customer/screens/booking_screen/medicine/my_utils/my_utils/common_grid_view.dart";
import "package:customer/screens/booking_screen/medicine/my_utils/my_utils/filter_range_widget.dart";
import "package:customer/screens/booking_screen/medicine/my_utils/my_utils/filter_sort_by_widget.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_debouncer.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class SelectMedicineScreen extends GetView<SelectMedicineController> {
  const SelectMedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Select Medicine"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                searchBarWidget(),
                const SizedBox(height: 16),
                filterWidget(),
                const SizedBox(height: 16),
                // actionChipsWidget(),
                gridView(),
                // const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().appGreyColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 16 + 8),
                  Icon(Icons.search, color: AppColors().appGreyColor),
                  const SizedBox(width: 16 + 8),
                  Expanded(
                    child: AppTextField(
                      controller: controller.searchController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.search,
                      readOnly: false,
                      obscureText: false,
                      maxLines: 1,
                      maxLength: null,
                      onChanged: (String value) {
                        controller.updateSearchQuery(value);

                        AppDebouncer().debounce(
                          controller.pagingControllerMedicines.refresh,
                        );
                      },
                      onTap: () {},
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      enabled: true,
                      autofillHints: const <String>[],
                      hintText: "Search here...",
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
        ],
      ),
    );
  }

  Widget filterWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterCount().value > 0
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.filter_alt_outlined,
                        color: controller.filterCount().value > 0
                            ? AppColors().appWhiteColor
                            : AppColors().appGrey,
                      ),
                      const SizedBox(width: 4),
                      CircleAvatar(
                        backgroundColor: AppColors().appWhiteColor,
                        radius: 12,
                        child: Text(
                          "${controller.filterCount().value}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterIsPriceApplied().value
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: openFilterRangeWidget,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Text(
                          "Price",
                          style: TextStyle(
                            color: controller.filterIsPriceApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (controller.filterIsPriceApplied().value)
                          CircleAvatar(
                            backgroundColor: AppColors().appWhiteColor,
                            radius: 12,
                            child: const Text(
                              "1",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        else
                          Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: controller.filterIsPriceApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterIsSortByApplied().value
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: openFilterSortByWidget,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Text(
                          "Sort By",
                          style: TextStyle(
                            color: controller.filterIsSortByApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (controller.filterIsSortByApplied().value)
                          CircleAvatar(
                            backgroundColor: AppColors().appWhiteColor,
                            radius: 12,
                            child: const Text(
                              "1",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        else
                          Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: controller.filterIsSortByApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget actionChipsWidget() {
    return controller.filterList().isEmpty
        ? const SizedBox()
        : Column(
            children: <Widget>[
              const SizedBox(height: 0),
              SizedBox(
                height: kToolbarHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filterList().length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  physics: const ScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<int, String> filterList = controller.filterList();
                    final int key = filterList.keys.elementAt(index);
                    final String value = filterList.values.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        shape: const StadiumBorder(),
                        label: Text(value),
                        deleteIcon: const Icon(Icons.remove_circle, size: 20),
                        deleteIconColor: AppColors().appRedColor,
                        onDeleted: () {
                          controller.onDeleteFilter(key);

                          controller.pagingControllerMedicines.refresh();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
  }

  Widget gridView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CommonGridView(
              pagingController: controller.pagingControllerMedicines,
              onTap: (CropMedicines item) async {
                
              },
              onTapResetAndRefresh: () async {
                controller.searchController.text = "";
                controller
                  ..updateSearchQuery("")
                  ..updateFilterMinRange(defaultMinRange)
                  ..updateFilterMaxRange(defaultMaxRange)
                  ..updateFilterSelectedSortBy("");
                controller.pagingControllerMedicines.refresh();
              },
              onTapAddToBooking: (CropMedicines item) async {
                (bool, String) value = (false, "");
                value = await addMedicineToBookingAPICall(
                  bookingId: controller.rxBookingId.value,
                  medicineId: item.sId ?? "",
                );

                if (value.$1) {
                  item
                    ..bookingQty = 1
                    ..bookingMedicineId = value.$2;
                  controller.pagingControllerMedicines.notifyListeners();
                } else {}
              },
              incQty: (CropMedicines item) async {
                final num newQty = (item.bookingQty ?? 0) + 1;

                bool value = false;
                value = await updateMedicineInBookingAPICall(
                  bookingId: controller.rxBookingId.value,
                  itemId: item.bookingMedicineId ?? "",
                  qty: newQty,
                );

                if (value) {
                  item.bookingQty = newQty;
                  controller.pagingControllerMedicines.notifyListeners();
                } else {}
              },
              decQty: (CropMedicines item) async {
                final num newQty = (item.bookingQty ?? 0) - 1;

                bool value = false;
                value = await updateMedicineInBookingAPICall(
                  bookingId: controller.rxBookingId.value,
                  itemId: item.bookingMedicineId ?? "",
                  qty: newQty,
                );

                if (value) {
                  item.bookingQty = newQty;
                  controller.pagingControllerMedicines.notifyListeners();
                } else {}
              },
              onPressedDelete: (CropMedicines item) async {
                bool value = false;
                value = await removeMedicineFromBookingAPICall(
                  bookingId: controller.rxBookingId.value,
                  itemId: item.bookingMedicineId ?? "",
                );

                if (value) {
                  item
                    ..bookingQty = 0
                    ..bookingMedicineId = "";
                  controller.pagingControllerMedicines.notifyListeners();
                } else {}
              },
              type: "medicine list",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openFilterRangeWidget() async {
    final double minimumRange = controller.rxFilterMinRange.value;
    final double maximumRange = controller.rxFilterMaxRange.value;

    final (double, double)? result = await Get.bottomSheet(
      FilterRangeWidget(minimumRange: minimumRange, maximumRange: maximumRange),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );

    if (result != null) {
      controller
        ..updateFilterMinRange(result.$1)
        ..updateFilterMaxRange(result.$2);

      controller.pagingControllerMedicines.refresh();
    } else {}

    return Future<void>.value();
  }

  Future<void> openFilterSortByWidget() async {
    final String selectedSortBy = controller.rxFilterSelectedSortBy.value;

    final String? result = await Get.bottomSheet(
      FilterSortByWidget(
        selectedSortBy: selectedSortBy,
        sortByList: controller.defaultSortBy,
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );

    if (result != null) {
      controller.updateFilterSelectedSortBy(result);

      controller.pagingControllerMedicines.refresh();
    } else {}

    return Future<void>.value();
  }
}
