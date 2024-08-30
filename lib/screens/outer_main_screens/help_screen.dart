// ignore_for_file: lines_longer_than_80_chars

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/common_functions/order_booking_stream.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_debouncer.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
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
                  controller.pagingControllerCategories.refresh();
                  controller.pagingControllerServicesLive.refresh();
                  controller.pagingControllerCategoriesLive.refresh();

                  OrderBookingStream().functionSinkAdd();
                },
                child: Obx(
                  () {
                    return Column(
                      children: <Widget>[
                        const SizedBox(height: 16),
                        TabBar(
                          controller: controller.tabController,
                          padding: EdgeInsets.zero,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          tabs: <Widget>[
                            commonTab(
                              index: 0,
                              isSelected: controller.rxCurrentIndex.value == 0,
                              item: controller.items[0],
                            ),
                            commonTab(
                              index: 1,
                              isSelected: controller.rxCurrentIndex.value == 1,
                              item: controller.items[1],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  chipSelectionServices(),
                                  const SizedBox(height: 16),
                                  Expanded(child: cardWidgetServices()),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  chipSelectionCategories(),
                                  const SizedBox(height: 16),
                                  Expanded(child: cardWidgetCategories()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget commonTab({
    required int index,
    required bool isSelected,
    required DashboardClass item,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 8 : 0,
        right: index == 1 ? 8 : 0,
      ),
      child: SizedBox(
        height: kToolbarHeight,
        width: double.infinity,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          surfaceTintColor: AppColors().appWhiteColor,
          color: AppColors().appWhiteColor,
          child: InkWell(
            onTap: () async {
              controller.tabController.animateTo(index);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: isSelected
                      ? <Color>[
                          AppColors().appPrimaryColor,
                          AppColors().appPrimaryColor.withOpacity(0.16),
                        ]
                      : <Color>[
                          Colors.white,
                          Colors.white.withOpacity(0.16),
                        ],
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    item.iconData,
                    size: 24,
                    color: isSelected
                        ? AppColors().appWhiteColor
                        : AppColors().appBlackColor,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors().appWhiteColor
                            : AppColors().appBlackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chipSelectionServices() {
    return ValueListenableBuilder<PagingState<int, Bookings>>(
      valueListenable: controller.pagingControllerServicesLive,
      builder: (
        BuildContext context,
        PagingState<int, Bookings> value,
        Widget? child,
      ) {
        final Map<String, dynamic> map1 =
            controller.rxSelectedServices.value.toJson();
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
                              color: controller.rxSelectedServices.value == item
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
                                  controller.rxSelectedServices.value == item
                                      ? AppColors().appPrimaryColor
                                      : AppColors().appWhiteColor,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12.0),
                                onTap: () async {
                                  controller.updateSelectedServices(item);
                                  controller.pagingControllerServicesLive
                                      .refresh();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      item.name ?? "",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: controller
                                                    .rxSelectedServices.value ==
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

  Widget chipSelectionCategories() {
    return ValueListenableBuilder<PagingState<int, Bookings>>(
      valueListenable: controller.pagingControllerCategoriesLive,
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
                  pagingController: controller.pagingControllerCategories,
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
                          controller.pagingControllerCategories.itemList ??
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
                                  controller.pagingControllerCategoriesLive
                                      .refresh();
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

  Widget cardWidgetServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PagedListView<int, Bookings>(
        shrinkWrap: true,
        pagingController: controller.pagingControllerServicesLive,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Bookings>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return SizedBox(
              height: Get.height / 2,
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
                      width: (Get.width) / 2,
                      child: AppTextButton(
                        text: "Start Booking",
                        onPressed: () {
                          AppDebouncer().debounce(
                            () async {
                              await tabControllerFunction(2);

                              controller.pagingControllerServicesLive.refresh();
                            },
                          );
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
                controller.pagingControllerServicesLive.itemList ??
                    <Bookings>[];
            final int length = itemList.length;
            final bool isLast = index == length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 32.0 : 16.0),
              child: Stack(
                children: <Widget>[
                  Card(
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
                        await AppNavService().pushNamed(
                          destination: AppRoutes().bookingDetailsScreen,
                          arguments: <String, dynamic>{"id": item.sId ?? ""},
                        );

                        controller.pagingControllerServicesLive.refresh();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        item.services?.first.service?.name ??
                                            "",
                                        style: const TextStyle(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking ID",
                                        style: TextStyle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.sId ?? "",
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
                                IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () async {
                                    final String id = item.sId ?? "";

                                    await Clipboard.setData(
                                      ClipboardData(text: id),
                                    );

                                    AppSnackbar().snackbarSuccess(
                                      title: "Yay!",
                                      message:
                                          "Booking ID copied to clipboard!",
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
                                      item.vendor?.toJson() ??
                                          Customer().toJson(),
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
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Please allow some time for this to be processed.",
                                                style: TextStyle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "You're free to attend to your other work.",
                                                style: TextStyle(),
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
                                                    ? item.vendor
                                                            ?.phoneNumber ??
                                                        ""
                                                    : "Phone number is not provided",
                                                style: const TextStyle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                (item.vendor?.email ?? "")
                                                        .isNotEmpty
                                                    ? item.vendor?.email ?? ""
                                                    : "Email address is not provided",
                                                style: const TextStyle(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking Date",
                                        style: TextStyle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formatDate(
                                          date: item.scheduleDate ?? "",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getBorderColor(status: item.status ?? ""),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        getBookingStatusString(status: item.status ?? ""),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors().appWhiteColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget cardWidgetCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: PagedListView<int, Bookings>(
        shrinkWrap: true,
        pagingController: controller.pagingControllerCategoriesLive,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Bookings>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return SizedBox(
              height: Get.height / 2,
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
                      width: (Get.width) / 2,
                      child: AppTextButton(
                        text: "Start Booking",
                        onPressed: () {
                          AppDebouncer().debounce(
                            () async {
                              await tabControllerFunction(2);

                              controller.pagingControllerCategoriesLive
                                  .refresh();
                            },
                          );
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
                controller.pagingControllerCategoriesLive.itemList ??
                    <Bookings>[];
            final int length = itemList.length;
            final bool isLast = index == length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 32.0 : 16.0),
              child: Stack(
                children: <Widget>[
                  Card(
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
                        await AppNavService().pushNamed(
                          destination: AppRoutes().bookingDetailsScreen,
                          arguments: <String, dynamic>{"id": item.sId ?? ""},
                        );

                        controller.pagingControllerCategoriesLive.refresh();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        item.services?.first.service?.name ??
                                            "",
                                        style: const TextStyle(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking ID",
                                        style: TextStyle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        item.sId ?? "",
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
                                IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () async {
                                    final String id = item.sId ?? "";

                                    await Clipboard.setData(
                                      ClipboardData(text: id),
                                    );

                                    AppSnackbar().snackbarSuccess(
                                      title: "Yay!",
                                      message:
                                          "Booking ID copied to clipboard!",
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
                                      item.vendor?.toJson() ??
                                          Customer().toJson(),
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
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "Please allow some time for this to be processed.",
                                                style: TextStyle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                "You're free to attend to your other work.",
                                                style: TextStyle(),
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
                                                    ? item.vendor
                                                            ?.phoneNumber ??
                                                        ""
                                                    : "Phone number is not provided",
                                                style: const TextStyle(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                (item.vendor?.email ?? "")
                                                        .isNotEmpty
                                                    ? item.vendor?.email ?? ""
                                                    : "Email address is not provided",
                                                style: const TextStyle(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Text(
                                        "Booking Date",
                                        style: TextStyle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formatDate(
                                          date: item.scheduleDate ?? "",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getBorderColor(status: item.status ?? ""),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        getBookingStatusString(status: item.status ?? ""),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors().appWhiteColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
