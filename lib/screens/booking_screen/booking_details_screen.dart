// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_widgets/app_review_rating_widget.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/booking_controller/booking_details_controller.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class BookingDetailsScreen extends GetWidget<BookingDetailsController> {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Booking Details"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        cardWidget(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                decideActionButtonWidget(),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget cardWidget() {
    final Bookings item = controller.rxBookings.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          onTap: () async {},
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              "Customer Info:",
                              style: TextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${item.customer?.firstName ?? ""} ${item.customer?.lastName ?? ""}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.customer?.phoneNumber ?? "",
                              style: const TextStyle(fontSize: 10),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.customer?.email ?? "",
                              style: const TextStyle(fontSize: 10),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const VerticalDivider(),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              "Vendor Info:",
                              style: TextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${item.vendor?.firstName ?? ""} ${item.vendor?.lastName ?? ""}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.vendor?.phoneNumber ?? "",
                              style: const TextStyle(fontSize: 10),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.vendor?.email ?? "",
                              style: const TextStyle(fontSize: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            "Serv. Name",
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.services?.first.service?.name ?? "",
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
                            "Serv. Price",
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "₹${item.services?.first.price ?? 0}",
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
                            "Serv. Area",
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${item.services?.first.area ?? 0} Acre",
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
                            "Crop Name",
                            style: TextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.crop ?? "",
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
                            getBookingStatusString(status: item.status ?? ""),
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
  }

  Widget decideActionButtonWidget() {
    final Bookings item = controller.rxBookings.value;
    final bool isVisibleConfirmAndCancelButton =
        controller.isVisibleConfirmAndCancelButton();
    final bool isVisibleCancelButton = controller.isVisibleCancelButton();
    final bool isVisibleReviewRating = controller.isVisibleReviewRating();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (isVisibleConfirmAndCancelButton)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
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
                        final String id = controller.rxBookingId.value;

                        bool value = false;
                        value = await controller.confirmOrderAPICall(id: id);

                        if (value) {
                          await AppNavService().pushNamed(
                            destination: AppRoutes().bookingPaymentScreen,
                            arguments: <String, dynamic>{"id": id},
                          );

                          await controller.getBookingAPICall();
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
                        final String id = controller.rxBookingId.value;

                        bool value = false;
                        value = await controller.cancelBookingAPICall(id: id);

                        if (value) {
                          AppNavService().pop();
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
            ),
          )
        else
          const SizedBox(),
        if (isVisibleCancelButton)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                        final String id = controller.rxBookingId.value;

                        bool value = false;
                        value = await controller.cancelBookingAPICall(id: id);

                        if (value) {
                          AppNavService().pop();
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
            ),
          )
        else
          const SizedBox(),
        if (isVisibleReviewRating)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(
                        color: getBorderColor(
                          status: item.status ?? "",
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    surfaceTintColor: AppColors().appWhiteColor,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () async {
                        final (num, String)? result = await Get.bottomSheet(
                          const AppReviewRatingWidget(
                            initialReview: "",
                            initialRating: 1,
                          ),
                          backgroundColor:
                              Theme.of(Get.context!).scaffoldBackgroundColor,
                          isScrollControlled: true,
                        );

                        if (result != null) {
                          bool value = false;
                          value = await controller.addReviewRatingAPICall(
                            id: item.sId ?? "",
                            rating: result.$1,
                            review: result.$2,
                          );

                          if (value) {
                            await controller.getBookingAPICall();
                          } else {}
                        } else {}
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Add Review & Rating",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getBorderColor(
                                status: item.status ?? "",
                              ),
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
            ),
          )
        else
          const SizedBox(),
      ],
    );
  }
}
