// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";

class HelpScreen extends GetView<HelpController> {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            // return AppNoItemFoundWidget(
            //   title: "No items found",
            //   message: "The order history list is currently empty.",
            //   onTryAgain: controller.pagingControllerNewOrder.refresh,
            // );
            return SizedBox(
              height: Get.height / 1.5,
              width: Get.width,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Icon(
                      Icons.fire_truck,
                      color: AppColors().appPrimaryColor,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Your live order list is empty!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Explore more & shortlist some rental services!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: AppTextButton(
                        text: "Start Booking",
                        onPressed: () async {
                          await tabControllerFunction(2);

                          controller.pagingControllerNewOrder.refresh();
                        },
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
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.0),
                  onTap: () async {
                    await AppNavService().pushNamed(
                      destination: AppRoutes().bookingDetailsScreen,
                      arguments: <String, dynamic>{"id": item.sId ?? ""},
                    );

                    controller.pagingControllerNewOrder.refresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item.vehicleCategory?.name ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.sId ?? "",
                                    style: const TextStyle(fontSize: 10),
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
                          children: <Widget>[
                            Expanded(
                              child: Column(
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
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
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
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
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
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    "End Time",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(
                                      time: item.approxEndTime ?? "",
                                    ),
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
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    "Total amount (Price per Acre * Farm Area)",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "₹${item.amount ?? 0}",
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
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text(
                                    "Booking Status",
                                    style: TextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    getBookingStatusString(
                                      status: item.status ?? "",
                                    ),
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
}
