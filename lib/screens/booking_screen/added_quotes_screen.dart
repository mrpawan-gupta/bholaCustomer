// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/booking_controller/added_quotes_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/screens/booking_screen/my_utils/pay_now_later_widget.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";

class AddedQuotesScreen extends GetView<AddedQuotesController> {
  const AddedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Already Added Quotes"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return LiquidPullToRefresh(
                    showChildOpacityTransition: false,
                    color: AppColors().appPrimaryColor,
                    backgroundColor: AppColors().appWhiteColor,
                    onRefresh: () async {
                      controller.pagingControllerServices.refresh();
                      controller.pagingControllerNewOrder.refresh();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            chipSelection(),
                            const SizedBox(height: 16 - 4),
                            cardWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chipSelection() {
    return ValueListenableBuilder<PagingState<int, Bookings>>(
      valueListenable: controller.pagingControllerNewOrder,
      builder: (
        BuildContext context,
        PagingState<int, Bookings> value,
        Widget? child,
      ) {
        final Map<String, dynamic> map1 =
            controller.rxSelectedCategory.value.toJson();
        final Map<String, dynamic> map2 = Categories().toJson();
        final bool isMapEquals = mapEquals(map1, map2);
        return (isMapEquals && (value.itemList?.isEmpty ?? false)) ||
                isMapEquals && (value.itemList?.isEmpty ?? true)
            ? const SizedBox(height: 16)
            : SizedBox(
                height: 32 + 8,
                width: double.infinity,
                child: PagedListView<int, Categories>(
                  shrinkWrap: true,
                  pagingController: controller.pagingControllerServices,
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  builderDelegate: PagedChildBuilderDelegate<Categories>(
                    noItemsFoundIndicatorBuilder: (BuildContext context) {
                      return const SizedBox();
                    },
                    itemBuilder:
                        (BuildContext context, Categories item, int index) {
                      final List<Categories> itemList =
                          controller.pagingControllerServices.itemList ??
                              <Categories>[];
                      final int length = itemList.length;
                      final bool isLast = index == length - 1;
                      return Obx(
                        () {
                          return Padding(
                            padding: EdgeInsets.only(
                              right: isLast ? 0.0 : 16.0,
                              bottom: 4,
                            ),
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 4,
                              color: controller.rxSelectedCategory.value == item
                                  ? AppColors().appPrimaryColor
                                  : AppColors().appWhiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: BorderSide(
                                  color: AppColors().appPrimaryColor,
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              surfaceTintColor:
                                  controller.rxSelectedCategory.value == item
                                      ? AppColors().appPrimaryColor
                                      : AppColors().appWhiteColor,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                onTap: () async {
                                  controller.updateSelectedCategory(item);
                                  controller.pagingControllerNewOrder.refresh();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      item.name ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller
                                                    .rxSelectedCategory.value ==
                                                item
                                            ? AppColors().appWhiteColor
                                            : AppColors().appPrimaryColor,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
      },
    );
  }

  Widget cardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PagedListView<int, Bookings>(
        shrinkWrap: true,
        pagingController: controller.pagingControllerNewOrder,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Bookings>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return SizedBox(
              height: Get.height / 1.5,
              width: Get.width,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Icon(
                      Icons.agriculture,
                      color: AppColors().appPrimaryColor,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "You haven't booked anything yet!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Please try booking whatever rental services you want!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: (Get.width) / 2,
                      child: AppTextButton(
                        text: "Book Now",
                        onPressed: AppNavService().pop,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
          itemBuilder: (BuildContext context, Bookings item, int index) {
            final List<Bookings> itemList =
                controller.pagingControllerNewOrder.itemList ?? <Bookings>[];
            final int length = itemList.length;
            final bool isLast = index == length - 1;
            final String status = item.status ?? "";
            final bool isStatusCorrect = status == bookingCreated;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 32.0 : 16.0),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(
                    color: getBorderColor(status: item.status ?? ""),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                surfaceTintColor: AppColors().appWhiteColor,
                color: AppColors().appWhiteColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: () async {
                    await navigate(item: item);

                    controller.pagingControllerNewOrder.refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: CommonImageWidget(
                                imageUrl: item.vehicleCategory?.photo ?? "",
                                fit: BoxFit.contain,
                                imageType: ImageType.image,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking For",
                                        style: TextStyle(fontSize: 10),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          item.vehicleCategory?.name ?? "",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking Status",
                                        style: TextStyle(fontSize: 10),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          getBookingStatusString(
                                            status: item.status ?? "",
                                          ),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking ID:",
                                        style: TextStyle(fontSize: 10),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          item.sId ?? "",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () async {
                                final String id = item.sId ?? "";

                                await Clipboard.setData(
                                  ClipboardData(text: id),
                                );

                                AppSnackbar().snackbarSuccess(
                                  title: "Yay!",
                                  message: "Booking ID copied to clipboard!",
                                );
                              },
                            ),
                          ],
                        ),
                        const Divider(),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: mapEquals(
                                  item.vendor?.toJson() ?? Customer().toJson(),
                                  Customer().toJson(),
                                )
                                    ? const Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Vendor Information:",
                                            style: TextStyle(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "No vendor has accepted this booking yet.",
                                            style: TextStyle(fontSize: 10),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Please allow some time for this to be processed.",
                                            style: TextStyle(fontSize: 10),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "Vendor Information:",
                                            style: TextStyle(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "${item.vendor?.firstName ?? ""} ${item.vendor?.lastName ?? ""}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            (item.vendor?.phoneNumber ?? "")
                                                    .isNotEmpty
                                                ? item.vendor?.phoneNumber ?? ""
                                                : "Phone number is not provided",
                                            style:
                                                const TextStyle(fontSize: 10),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            (item.vendor?.email ?? "")
                                                    .isNotEmpty
                                                ? item.vendor?.email ?? ""
                                                : "Email address is not provided",
                                            style:
                                                const TextStyle(fontSize: 10),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Delivery Address",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${item.deliveryAddress?.street ?? ""} ${item.deliveryAddress?.city ?? ""} ${item.deliveryAddress?.country ?? ""} ${item.deliveryAddress?.pinCode ?? ""}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Start Time",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(
                                      time: item.approxStartTime ?? "",
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                    "End Time",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(time: item.approxEndTime ?? ""),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                    "Est. hours",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${item.hours ?? 0} hours",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "Date",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatDate(date: item.scheduleDate ?? ""),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                    "Crop Name",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.crop?.name ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
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
                                    "Farm Area",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${item.farmArea ?? 0} Acre",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isStatusCorrect ? 16 : 0),
                        if (isStatusCorrect)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                      color: AppColors().appPrimaryColor,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  surfaceTintColor: AppColors().appWhiteColor,
                                  color: AppColors().appWhiteColor,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () async {
                                      final String id = item.sId ?? "";

                                      bool value = false;
                                      value = await controller
                                          .confirmOrderAPICall(id: id);

                                      if (value) {
                                        await openPayNowLaterWidget(id: id);

                                        controller.pagingControllerNewOrder
                                            .refresh();
                                      } else {}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          "Confirm Booking",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors().appPrimaryColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Card(
                                  margin: EdgeInsets.zero,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(
                                      color: AppColors().appRedColor,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  surfaceTintColor: AppColors().appWhiteColor,
                                  color: AppColors().appWhiteColor,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () async {
                                      final String id = item.sId ?? "";

                                      bool value = false;
                                      value = await controller
                                          .cancelBookingAPICall(id: id);

                                      if (value) {
                                        controller.pagingControllerNewOrder
                                            .refresh();
                                      } else {}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          "Cancel Booking",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors().appRedColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> navigate({required Bookings item}) async {
    final String displayType = item.type ?? "";
    final bool isMedicineSupported = displayType == displayTypeAreaWithMedicine;

    isMedicineSupported
        ? await AppNavService().pushNamed(
            destination: AppRoutes().bookingAddOnsScreen,
            arguments: <String, dynamic>{"id": item.sId ?? ""},
          )
        : await AppNavService().pushNamed(
            destination: AppRoutes().bookingDetailsScreen,
            arguments: <String, dynamic>{"id": item.sId ?? ""},
          );

    return Future<void>.value();
  }

  Future<void> openPayNowLaterWidget({required String id}) async {
    final bool? result = await Get.bottomSheet(
      const PayNowLaterWidget(),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );

    if (result != null) {
      if (result) {
        await AppNavService().pushNamed(
          destination: AppRoutes().paymentScreen,
          arguments: <String, dynamic>{"id": id},
        );
      } else {}
    } else {}

    return Future<void>.value();
  }
}
