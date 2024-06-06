// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/booking_controller/added_quotes_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
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
    return SizedBox(
      height: 32 + 8,
      width: double.infinity,
      child: PagedListView<int, Categories>(
        shrinkWrap: true,
        pagingController: controller.pagingControllerServices,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Categories>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, Categories item, int index) {
            final List<Categories> itemList =
                controller.pagingControllerServices.itemList ?? <Categories>[];
            final int length = itemList.length;
            final bool isLast = index == length - 1;
            return Obx(
              () {
                return Padding(
                  padding:
                      EdgeInsets.only(right: isLast ? 0.0 : 16.0, bottom: 4),
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
                              color: controller.rxSelectedCategory.value == item
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
            return AppNoItemFoundWidget(
              title: "No items found",
              message: "The new order list is currently empty.",
              onTryAgain: controller.pagingControllerNewOrder.refresh,
            );
          },
          itemBuilder: (BuildContext context, Bookings item, int index) {
            final List<Bookings> itemList =
                controller.pagingControllerNewOrder.itemList ?? <Bookings>[];
            final int length = itemList.length;
            final bool isLast = index == length - 1;

            final String status = item.status ?? "";
            final bool isStatusCorrect = status == "Created";

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: CommonImageWidget(
                                    imageUrl: item.vehicleCategory?.photo ?? "",
                                    fit: BoxFit.contain,
                                    imageType: ImageType.image,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Name:",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${item.customer?.firstName ?? ""} ${item.customer?.lastName ?? ""}",
                                          style: const TextStyle(
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
                                    children: <Widget>[
                                      const Text(
                                        "Mobile No.:",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          item.customer?.phoneNumber ?? "",
                                          style: const TextStyle(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Address:",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${item.deliveryAddress?.street ?? ""} ${item.deliveryAddress?.city ?? ""} ${item.deliveryAddress?.country ?? ""} ${item.deliveryAddress?.pinCode ?? ""}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: <Widget>[
                                      const Text(
                                        "Bill Amount:",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "₹${item.amount ?? ""}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider(),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    formatDate(
                                      date: item.scheduleDate ?? "",
                                    ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(
                                      time: item.approxStartTime ?? "",
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors().appPrimaryColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    formatTime(
                                      time: item.approxEndTime ?? "",
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: isStatusCorrect ? 8 : 0),
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
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () async {
                                      final String id = item.sId ?? "";

                                      bool value = false;
                                      value = await controller
                                          .confirmOrderAPICall(id: id);

                                      if (value) {
                                        await AppNavService().pushNamed(
                                          destination:
                                              AppRoutes().bookingPaymentScreen,
                                          arguments: <String, dynamic>{
                                            "id": id,
                                          },
                                        );

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
}
