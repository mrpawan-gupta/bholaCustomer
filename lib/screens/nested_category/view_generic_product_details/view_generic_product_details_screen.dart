import "dart:async";

import "package:customer/common_widgets/app_bottom_indicator.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/controllers/nested_category/view_generic_product_details_controller.dart";
import "package:customer/models/generic_product_details_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/models/rating_summary.dart";
import "package:customer/models/review_rating_model.dart";
import "package:customer/screens/nested_category/view_generic_product_details/common_generic_product_title_bar.dart";
import "package:customer/screens/nested_category/view_generic_product_details/common_horizontal_list_view_products.dart";
import "package:customer/screens/review_rating_screen/my_utils/common_list_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:gauge_indicator/gauge_indicator.dart";
import "package:get/get.dart";
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
                    },
                    icon: Badge(
                      isLabelVisible: rxWishListCount.value != 0,
                      label: Text("${rxWishListCount.value}"),
                      textColor: AppColors().appWhiteColor,
                      backgroundColor: AppColors().appPrimaryColor,
                      child: Icon(
                        Icons.favorite,
                        color: AppColors().appRedColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().cartScreen,
                        arguments: <String, dynamic>{},
                      );
                    },
                    icon: Badge(
                      isLabelVisible: rxCartListCount.value != 0,
                      label: Text("${rxCartListCount.value}"),
                      textColor: AppColors().appWhiteColor,
                      backgroundColor: AppColors().appPrimaryColor,
                      child: Icon(
                        Icons.shopping_cart,
                        color: AppColors().appPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
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
                            moreInfoWidget(),
                            const SizedBox(height: 16),
                            advanceInfoWidget(),
                            const SizedBox(height: 16),
                            suggestedWidget(),
                            const SizedBox(height: 16),
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

  Widget moreInfoWidget() {
    final GenericProductData data = controller.rxProductDetailsData.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonGenericProductTitleBar(
            title: "Product Description",
            onTapViewAll: () {},
            isViewAllNeeded: false,
          ),
          const SizedBox(height: 8),
          ReadMoreText(
            data.description ?? "",
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
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 4,
                      margin: EdgeInsets.zero,
                      color: AppColors().appWhiteColor,
                      surfaceTintColor: AppColors().appWhiteColor,
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
                        trailing: Icon(
                          Icons.edit,
                          color: AppColors().appPrimaryColor,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
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

  Widget suggestedWidget() {
    return Column(
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
              destination: AppRoutes().viewGenericProductDetailsScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );
          },
          onTapAddToWish: (Products item, {required bool isLiked}) {},
          onTapAddToCart: (Products item) {},
          incQty: (Products item) {},
          decQty: (Products item) {},
          type: "Suggested list",
        ),
        const SizedBox(height: 16),
      ],
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
                  color: AppColors().appWhiteColor,
                  surfaceTintColor: AppColors().appWhiteColor,
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
                text: "Add to Wish List",
                onPressed: () async {
                  await controller.addToWishListAPICall(id: data.sId ?? "");
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
                text: "Add to Cart",
                onPressed: () async {
                  await controller.addToCartAPICall(id: data.sId ?? "");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
