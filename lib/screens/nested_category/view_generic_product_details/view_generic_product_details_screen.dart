// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars

import "dart:async";

import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";
import "package:customer/common_functions/order_booking_stream.dart";
import "package:customer/common_widgets/app_bottom_indicator.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/nested_category/view_generic_product_details_controller.dart";
import "package:customer/models/generic_product_details_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/models/rating_summary.dart";
import "package:customer/models/review_rating_model.dart";
import "package:customer/screens/nested_category/view_generic_product_details/common_generic_product_title_bar.dart";
import "package:customer/screens/nested_category/view_generic_product_details/common_horizontal_list_view_products.dart";
import "package:customer/screens/review_rating_screen/my_utils/common_list_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_in_app_browser.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:gauge_indicator/gauge_indicator.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:pod_player/pod_player.dart";
import "package:read_more_text/read_more_text.dart";

class ViewGenericProductDetailsScreen
    extends GetWidget<ViewGenericProductDetailsController> {
  const ViewGenericProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Product Details"),
            surfaceTintColor: AppColors().appTransparentColor,
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().wishListScreen,
                        arguments: <String, dynamic>{},
                      );

                      OrderBookingStream().functionSinkAdd();
                    },
                    icon: Badge(
                      isLabelVisible: rxWishListCount.value != 0,
                      label: Text("${rxWishListCount.value}"),
                      textColor: AppColors().appWhiteColor,
                      backgroundColor: AppColors().appPrimaryColor,
                      child: Image.asset(
                        AppAssetsImages().appBarWish,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        color: rxWishListCount.value != 0
                            ? AppColors().appPrimaryColor
                            : AppColors().appGreyColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().cartScreen,
                        arguments: <String, dynamic>{},
                      );

                      OrderBookingStream().functionSinkAdd();
                    },
                    icon: Badge(
                      isLabelVisible: rxCartListCount.value != 0,
                      label: Text("${rxCartListCount.value}"),
                      textColor: AppColors().appWhiteColor,
                      backgroundColor: AppColors().appPrimaryColor,
                      child: Image.asset(
                        AppAssetsImages().appBarCart,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        color: rxCartListCount.value != 0
                            ? AppColors().appPrimaryColor
                            : AppColors().appGreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(width: 16),
                      Expanded(
                        child: commonAppBarBottom(
                          iconData: Icons.shopping_bag_outlined,
                          name: "Coming soon!",
                          onTap: () async {
                            await AppNavService().pushNamed(
                              destination: AppRoutes().supportScreen,
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
              ),
            ),
          ),
          body: SafeArea(
            child: Obx(
              () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            pageViewWidget(),
                            const SizedBox(height: 16),
                            basicInfoWidget(),
                            const SizedBox(height: 16),
                            descriptionWidget(),
                            const SizedBox(height: 16),
                            advanceInfoWidget(),
                            const SizedBox(height: 0),
                            policyInfoWidget(),
                            const SizedBox(height: 16),
                            suggestedWidget(),
                            const SizedBox(height: 0),
                            ratingBarGraphWidget(),
                            const SizedBox(height: 16),
                            reviewsWidget(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    buttons(),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget pageViewWidget() {
    final GenericProductData data = controller.rxProductDetailsData.value;
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                String imageUrl = "";
                if (index == 0) {
                  imageUrl = data.photo ?? "";
                } else if (index == 1) {
                  imageUrl = data.video ?? "";
                } else {}
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(12.0),
                    child: index != 1
                        ? CommonImageWidget(
                            imageUrl: imageUrl,
                            fit: BoxFit.contain,
                            imageType: ImageType.image,
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PodVideoPlayer(
                              controller: controller.podPlayerController,
                            ),
                          ),
                  ),
                );
              },
              onPageChanged: controller.updateCurrentIndex,
            ),
          ),
          const SizedBox(height: 16),
          Align(
            child: AppBottomIndicator(
              length: 2,
              index: controller.rxCurrentIndex.value,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget basicInfoWidget() {
    final GenericProductData data = controller.rxProductDetailsData.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            data.name ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  "Pricing:",
                  style: TextStyle(color: AppColors().appGrey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(child: pricingWidget()),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  "Ratings:",
                  style: TextStyle(color: AppColors().appGrey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${data.cumulativeRating ?? 0}",
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
              Text(
                "(${data.reviewCount ?? 0} Reviews)",
                style: TextStyle(color: AppColors().appGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pricingWidget() {
    final GenericProductData data = controller.rxProductDetailsData.value;

    final num price = data.price ?? 0;
    final num discountedPrice = data.discountedPrice ?? 0;
    final num discountPercent = data.discountPercent ?? 0;
    final bool condition = discountedPrice == 0 || discountPercent == 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (condition)
          Text(
            "₹$price",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors().appPrimaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        else
          Row(
            children: <Widget>[
              Text(
                "₹$discountedPrice",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().appPrimaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
              Text(
                "₹$price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().appGrey,
                  decoration: TextDecoration.lineThrough,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 8),
              Text(
                "($discountPercent% off)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().appOrangeColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
      ],
    );
  }

  Widget descriptionWidget() {
    final GenericProductData data = controller.rxProductDetailsData.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Product Description:",
            style: TextStyle(color: AppColors().appGrey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          ReadMoreText(
            (data.description ?? "").isNotEmpty
                ? data.description ?? ""
                : "Description is not provided.",
            numLines: 2,
            readMoreText: "Read more",
            readLessText: "Read less",
            readMoreAlign: Alignment.bottomLeft,
            readMoreIconColor: AppColors().appPrimaryColor,
            readMoreTextStyle: TextStyle(color: AppColors().appPrimaryColor),
          ),
        ],
      ),
    );
  }

  Widget advanceInfoWidget() {
    return controller.getAddressOrAddressPlaceholder() == "-"
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonGenericProductTitleBar(
                  title: "Delivery Address",
                  onTapViewAll: () {},
                  isViewAllNeeded: false,
                ),
                const SizedBox(height: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(color: AppColors().appPrimaryColor),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      surfaceTintColor: AppColors().appWhiteColor,
                      color: AppColors().appWhiteColor,
                      child: ListTile(
                        dense: true,
                        title: Text(
                          controller.getFullName(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          controller.getAddressOrAddressPlaceholder(),
                          style: const TextStyle(),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Icon(
                          Icons.home_outlined,
                          color: AppColors().appPrimaryColor,
                        ),
                        trailing: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              await AppNavService().pushNamed(
                                destination: AppRoutes().addressesListScreen,
                                arguments: <String, dynamic>{},
                              );

                              unawaited(controller.getAddressesAPI());
                            },
                            child: ColoredBox(
                              color:
                                  AppColors().appPrimaryColor.withOpacity(0.16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.edit_outlined,
                                  color: AppColors().appPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          await AppNavService().pushNamed(
                            destination: AppRoutes().addressesListScreen,
                            arguments: <String, dynamic>{},
                          );

                          unawaited(controller.getAddressesAPI());
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // const SizedBox(height: 16),
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Card(
                //       clipBehavior: Clip.antiAliasWithSaveLayer,
                //       elevation: 4,
                //       margin: EdgeInsets.zero,
                //       color: AppColors().appWhiteColor,
                //       surfaceTintColor: AppColors().appWhiteColor,
                //       color: AppColors().appWhiteColor,
                //       child: ListTile(
                //         dense: true,
                //         title: Text(
                //           "FREE Delivery",
                //           style: TextStyle(
                //             color: AppColors().appPrimaryColor,
                //             fontWeight: FontWeight.bold,
                //           ),
                //           maxLines: 2,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         subtitle: const Text(
                //           "Delivery By 6th April 2024",
                //           style: TextStyle(),
                //           maxLines: 2,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //         leading: Icon(
                //           Icons.emoji_transportation,
                //           color: AppColors().appPrimaryColor,
                //         ),
                //         trailing: Icon(
                //           Icons.calendar_month,
                //           color: AppColors().appPrimaryColor,
                //         ),
                //         onTap: () {},
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          );
  }

  Widget policyInfoWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: AppColors().appPrimaryColor),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    surfaceTintColor: AppColors().appWhiteColor,
                    color: AppColors().appWhiteColor,
                    child: InkWell(
                      onTap: openReturnPolicyWidget,
                      child: const Column(
                        children: <Widget>[
                          SizedBox(height: 16),
                          Icon(Icons.history),
                          SizedBox(height: 8),
                          Text(
                            "2-days return policy",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: AppColors().appPrimaryColor),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    surfaceTintColor: AppColors().appWhiteColor,
                    color: AppColors().appWhiteColor,
                    child: InkWell(
                      onTap: openCashOnDeliveyWidget,
                      child: const Column(
                        children: <Widget>[
                          SizedBox(height: 16),
                          Icon(Icons.currency_rupee),
                          SizedBox(height: 8),
                          Text(
                            "Cash-on-delivery",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget suggestedWidget() {
    return ValueListenableBuilder<PagingState<int, Products>>(
      valueListenable: controller.pagingControllerProducts,
      builder: (
        BuildContext context,
        PagingState<int, Products> value,
        Widget? child,
      ) {
        return (value.itemList?.isEmpty ?? false)
            ? const SizedBox(height: 16)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CommonGenericProductTitleBar(
                      title: "Suggested",
                      onTapViewAll: () {},
                      isViewAllNeeded: false,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CommonHorizontalListViewProducts(
                    pagingController: controller.pagingControllerProducts,
                    onTap: (Products item) async {
                      await AppNavService().pushNamed(
                        destination:
                            AppRoutes().viewGenericProductDetailsScreen,
                        arguments: <String, dynamic>{"id": item.sId ?? ""},
                      );

                      unawaited(controller.getProductDetailsAPICall());
                    },
                    onTapAddToWish: (
                      Products item, {
                      required bool isLiked,
                    }) async {
                      bool value = false;
                      value = isLiked
                          ? await removeFromWishListAPICall(
                              productId: item.sId ?? "",
                            )
                          : await addToWishListAPICall(
                              productId: item.sId ?? "",
                            );

                      if (value) {
                        item.isInWishList = !(item.isInWishList ?? false);
                        isLiked = item.isInWishList ?? false;
                        controller.pagingControllerProducts.notifyListeners();
                      } else {}
                    },
                    onTapAddToCart: (Products item) async {
                      (bool, String) value = (false, "");
                      value = await addToCartAPICall(productId: item.sId ?? "");

                      if (value.$1) {
                        item
                          ..cartQty = 1
                          ..cartItemId = value.$2;
                        controller.pagingControllerProducts.notifyListeners();
                      } else {}
                    },
                    incQty: (Products item) async {
                      final num newQty = (item.cartQty ?? 0) + 1;

                      bool value = false;
                      value = await updateCartAPICall(
                        itemId: item.cartItemId ?? "",
                        cartId: item.cartId ?? "",
                        qty: newQty,
                      );

                      if (value) {
                        item.cartQty = newQty;
                        controller.pagingControllerProducts.notifyListeners();
                      } else {}
                    },
                    decQty: (Products item) async {
                      final num newQty = (item.cartQty ?? 0) - 1;

                      bool value = false;
                      value = await updateCartAPICall(
                        itemId: item.cartItemId ?? "",
                        cartId: item.cartId ?? "",
                        qty: newQty,
                      );

                      if (value) {
                        item.cartQty = newQty;
                        controller.pagingControllerProducts.notifyListeners();
                      } else {}
                    },
                    onPressedDelete: (Products item) async {
                      bool value = false;
                      value = await removeFromCartAPICall(
                        itemId: item.cartItemId ?? "",
                        cartId: item.cartId ?? "",
                      );

                      if (value) {
                        item
                          ..cartQty = 0
                          ..cartItemId = "";
                        controller.pagingControllerProducts.notifyListeners();
                      } else {}
                    },
                    type: "Suggested list",
                  ),
                  const SizedBox(height: 16),
                ],
              );
      },
    );
  }

  Widget ratingBarGraphWidget() {
    final RatingSummaryData data = controller.rxRatingSummary.value;
    return mapEquals(data.toJson(), RatingSummaryData().toJson())
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonGenericProductTitleBar(
                  title: "Ratings",
                  onTapViewAll: () {},
                  isViewAllNeeded: false,
                ),
                const SizedBox(height: 8),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  surfaceTintColor: AppColors().appWhiteColor,
                  color: AppColors().appWhiteColor,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          const Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("5 ⭐"),
                              SizedBox(height: 4),
                              Text("4 ⭐"),
                              SizedBox(height: 4),
                              Text("3 ⭐"),
                              SizedBox(height: 4),
                              Text("2 ⭐"),
                              SizedBox(height: 4),
                              Text("1 ⭐"),
                            ],
                          ),
                          const SizedBox(width: 16),
                          if (mapEquals(
                            data.ratingsSummary?.toJson(),
                            RatingsSummary().toJson(),
                          ))
                            const SizedBox()
                          else
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  commonLinearProgressIndicator(
                                    value: (data.ratingsSummary?.i5 ?? 0) /
                                        (data.totalRatings ?? 0),
                                  ),
                                  const SizedBox(height: 16),
                                  commonLinearProgressIndicator(
                                    value: (data.ratingsSummary?.i4 ?? 0) /
                                        (data.totalRatings ?? 0),
                                  ),
                                  const SizedBox(height: 16),
                                  commonLinearProgressIndicator(
                                    value: (data.ratingsSummary?.i3 ?? 0) /
                                        (data.totalRatings ?? 0),
                                  ),
                                  const SizedBox(height: 16),
                                  commonLinearProgressIndicator(
                                    value: (data.ratingsSummary?.i2 ?? 0) /
                                        (data.totalRatings ?? 0),
                                  ),
                                  const SizedBox(height: 16),
                                  commonLinearProgressIndicator(
                                    value: (data.ratingsSummary?.i1 ?? 0) /
                                        (data.totalRatings ?? 0),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(width: 16),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${data.totalRatings ?? 0}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Builder(
                                builder: (BuildContext context) {
                                  double value = 0.0;
                                  final num temp = data.averageRating ?? 0.0;
                                  value = temp.toDouble();
                                  return RatingBar.builder(
                                    ignoreGestures: true,
                                    allowHalfRating: true,
                                    initialRating: value,
                                    itemSize: 16,
                                    unratedColor: AppColors().appGrey,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return Icon(
                                        Icons.star,
                                        color: AppColors().appOrangeColor,
                                      );
                                    },
                                    onRatingUpdate: (double value) {},
                                  );
                                },
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${data.totalRatings ?? 0} Reviews",
                                style: const TextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget reviewsWidget() {
    final GenericProductData data = controller.rxProductDetailsData.value;
    return data.reviews?.isEmpty ?? true
        ? const SizedBox()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CommonGenericProductTitleBar(
                  title: "Reviews",
                  onTapViewAll: () async {
                    await AppNavService().pushNamed(
                      destination: AppRoutes().reviewRatingScreen,
                      arguments: <String, dynamic>{
                        "id": data.sId ?? "",
                        "route": AppRoutes().viewGenericProductDetailsScreen,
                      },
                    );

                    unawaited(controller.getProductDetailsAPICall());
                  },
                  isViewAllNeeded: true,
                ),
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                itemCount: data.reviews?.length ?? 0,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(indent: 16, endIndent: 16);
                },
                itemBuilder: (BuildContext context, int index) {
                  final Reviews item = data.reviews?[index] ?? Reviews();

                  return reviewsListAdapter(
                    item: item,
                    onTap: (Reviews item) {},
                    onPressedEdit: (Reviews item) async {},
                    onPressedDelete: (Reviews item) async {},
                    type: "reviews list",
                    needMoreOptionsButton: false,
                  );
                },
              ),
            ],
          );
  }

  Widget gaugeWidget({required double value}) {
    return SizedBox(
      height: 50,
      child: RadialGauge(
        value: value,
        axis: const GaugeAxis(
          max: 180,
          pointer: GaugePointer.circle(color: Colors.black, radius: 8),
        ),
        child: Center(
          child: Text(
            "$value%",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget commonLinearProgressIndicator({required double value}) {
    return LinearProgressIndicator(
      value: value.isInfinite || value.isNaN ? 0 : value,
      minHeight: 8,
      borderRadius: BorderRadius.circular(100),
      valueColor: AlwaysStoppedAnimation<Color>(AppColors().appPrimaryColor),
    );
  }

  Widget buttons() {
    final GenericProductData data = controller.rxProductDetailsData.value;

    final bool isInWishList = data.isInWishList ?? false;
    final bool isInCartList = (data.cartQty ?? 0) > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: AppElevatedButton(
                text: isInWishList ? "Go to Wish List" : "Add to Wish List",
                onPressed: () async {
                  if (!isInWishList) {
                    await addToWishListAPICall(productId: data.sId ?? "");
                  } else {}

                  await AppNavService().pushNamed(
                    destination: AppRoutes().wishListScreen,
                    arguments: <String, dynamic>{},
                  );

                  unawaited(controller.getProductDetailsAPICall());
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: AppElevatedButton(
                text: isInCartList ? "Go to Cart List" : "Add to Cart List",
                onPressed: () async {
                  if (!isInCartList) {
                    await addToCartAPICall(productId: data.sId ?? "");
                  } else {}

                  await AppNavService().pushNamed(
                    destination: AppRoutes().cartScreen,
                    arguments: <String, dynamic>{},
                  );

                  unawaited(controller.getProductDetailsAPICall());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openReturnPolicyWidget() async {
    await Get.bottomSheet(
      Column(
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
              "Conditions for Product Return",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: Get.height / 2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "• Quality Issues: If the product does not meet the agreed-upon quality standards or if there are significant deviations from the product description, you may request a return or refund. Any issues must be reported within 48 hrs after delivery. Supporting evidence, such as photos or written statements, may be required to process your request.",
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "• Damaged or Defective Products: If the product is damaged or defective upon arrival, you may request a return or refund. Please report the issue within 48 hrs after delivery, and provide supporting evidence, such as photos or written statements.",
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "• Incorrect Product: If you receive a product different from what was ordered, you may request a return or refund. Please report the issue within 48 hrs after delivery, and provide supporting evidence, such as photos or written statements.",
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "• Unopened Products: Product must be unopened.",
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "• Return Shipping: You may be responsible for the return shipping costs. ",
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.public),
                      title: const Text("Refund Policy"),
                      subtitle: Text(AppConstants().appURLsRefundPolicy),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () async {
                        AppNavService().pop();

                        await AppInAppBrowser().openInAppBrowser(
                          url: AppConstants().appURLsRefundPolicy,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Okay",
                    onPressed: AppNavService().pop,
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

  Future<void> openCashOnDeliveyWidget() async {
    await Get.bottomSheet(
      Column(
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
              "Conditions for Cash-on-delivey",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "• Available. Select Cash on Delivery (COD) payment option while placing the order and later, pay in cash at the time of actual delivery of product. No advance payment needed.",
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: AppElevatedButton(
                    text: "Okay",
                    onPressed: AppNavService().pop,
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

  Widget commonAppBarBottom({
    required IconData iconData,
    required String name,
    required Function() onTap,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors().appPrimaryColor),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      surfaceTintColor: AppColors().appWhiteColor,
      color: AppColors().appWhiteColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  color: AppColors().appPrimaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors().appPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
