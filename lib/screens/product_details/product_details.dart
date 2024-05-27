import "package:customer/common_functions/date_time_functions.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/controllers/product_detail_page_controllers/product_detail_page_controllers.dart";
import "package:customer/models/product_details_model.dart";
import "package:customer/screens/widgets/text_widgets.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:get/get.dart";
import "package:page_view_dot_indicator/page_view_dot_indicator.dart";
import "package:pod_player/pod_player.dart";

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      pageViewWidget(),
                      const SizedBox(
                        height: 8,
                      ),
                      buildProductDetailsWidget(),
                      buildDeliveryAddressWidget(context),
                      const SizedBox(
                        height: 15,
                      ),
                      buildProductPhotoWidget(),
                      const SizedBox(
                        height: 18,
                      ),
                      buildRatingsWidget(context),
                      reviewsWidget(),
                      priceAndButtonWidget(context),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageViewWidget() {
    final ProductDetailsData data = controller.rxProductDetailsData.value;
    final List<String> thumbnails = <String>[
      data.photo ?? "",
      data.video ?? "",
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: PageView.builder(
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            String imageUrl = "";
                            if (index == 0) {
                              imageUrl = data.photo ?? "";
                            } else if (index == 1) {
                              imageUrl = data.video ?? "";
                            }
                            return index != 1
                                ? CommonImageWidget(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              imageType: ImageType.image,
                            )
                                : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Flexible(
                                child: PodVideoPlayer(
                                  controller: controller.podPlayerController,
                                ),
                              ),
                            );
                          },
                          onPageChanged: controller.updateCurrentIndex,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 60,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(thumbnails.length, (int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: index != 1
                                    ? Image.network(
                                  thumbnails[index],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                                    : Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.black26,
                                  child: const Icon(
                                    Icons.play_circle_filled,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            PageViewDotIndicator(
              currentItem: controller.rxCurrentIndex.value,
              count: 2,
              selectedColor: AppColors().appPrimaryColor,
              unselectedColor: AppColors().appGreyColor,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildProductDetailsWidget() {
    final ProductDetailController controller =
        Get.find<ProductDetailController>();
    final ProductDetailsData data = controller.rxProductDetailsData.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          text: data.name ?? "",
          color: Colors.black,
          size: 22,
          fontWeight: FontWeight.bold,
          isLineThrough: false,
        ),
        Row(
          children: <Widget>[
            TextWidget(
              text: "\$${data.price}",
              color: Colors.black,
              size: 18,
              fontWeight: FontWeight.bold,
              isLineThrough: false,
            ),
            const SizedBox(
              width: 20,
            ),
            TextWidget(
              text: AppLanguageKeys().strMRP,
              color: Colors.grey,
              size: 17,
              fontWeight: FontWeight.w600,
              isLineThrough: false,
            ),
            const SizedBox(
              width: 5,
            ),
            TextWidget(
              text: "\$${data.price}",
              color: Colors.grey,
              size: 17,
              fontWeight: FontWeight.w600,
              isLineThrough: true,
            ),
            const SizedBox(
              width: 10,
            ),
            TextWidget(
              text: "${data.discountPercent ?? ""}%",
              color: Colors.orange,
              size: 17,
              fontWeight: FontWeight.bold,
              isLineThrough: false,
            ),
          ],
        ),
        const SizedBox(
          height: 2,
        ),
        Row(
          children: <Widget>[
            const Icon(
              Icons.star,
              color: Colors.orange,
              size: 15,
            ),
            TextWidget(
              text:
                  "${data.cumulativeRating ?? ""} (${data.reviewCount} Reviews)",
              color: Colors.grey,
              size: 14,
              fontWeight: FontWeight.w500,
              isLineThrough: false,
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.description ?? "",
                maxLines: controller.descTextShowFlag.value ? null : 2,
                overflow: controller.descTextShowFlag.value
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 3,
              ),
              if (data.description != null && data.description!.length > 80)
                InkWell(
                  onTap: controller.toggleDescTextShowFlag,
                  child: Row(
                    children: <Widget>[
                      Text(
                        controller.descTextShowFlag.value
                            ? AppLanguageKeys().strReadMore
                            : AppLanguageKeys().strReadLess,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Icon(
                        controller.descTextShowFlag.value
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget buildDeliveryAddressWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextWidget(
          text: AppLanguageKeys().strDeliveryAddress.tr,
          color: AppColors().appBlackColor,
          size: 19,
          fontWeight: FontWeight.bold,
          isLineThrough: false,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextWidget(
                      text: AppLanguageKeys().strRohan.tr,
                      color: AppColors().appBlackColor,
                      size: 16,
                      fontWeight: FontWeight.bold,
                      isLineThrough: false,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Text(
                        AppLanguageKeys().strText.tr,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.edit_calendar_rounded,
                  color: AppColors().appPrimaryColor,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          height: 75,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.fire_truck_sharp,
                  size: 30,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        TextWidget(
                          text: "Free Delivery   | ",
                          color: AppColors().appPrimaryColor,
                          size: 16,
                          fontWeight: FontWeight.bold,
                          isLineThrough: false,
                        ),
                        TextWidget(
                          text: "    Delivery By",
                          color: AppColors().appBlackColor,
                          size: 16,
                          fontWeight: FontWeight.w600,
                          isLineThrough: false,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextWidget(
                      text: "6th April 2024",
                      color: AppColors().appBlackColor,
                      size: 14,
                      fontWeight: FontWeight.w600,
                      isLineThrough: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProductPhotoWidget() {
    final ProductDetailController controller =
        Get.find<ProductDetailController>();
    final String photoUrl = controller.productPhoto.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWidget(
              text: AppLanguageKeys().strSuggested.tr,
              color: AppColors().appBlackColor,
              size: 19,
              fontWeight: FontWeight.bold,
              isLineThrough: false,
            ),
            TextWidget(
              text: AppLanguageKeys().strSeeAll.tr,
              color: AppColors().appBlackColor,
              size: 15,
              fontWeight: FontWeight.bold,
              isLineThrough: false,
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (photoUrl.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              photoUrl,
              height: 200,
              fit: BoxFit.cover,
            ),
          )
        else
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            alignment: Alignment.center,
            child: Text("No photo available"),
          ),
      ],
    );
  }

  Widget buildRatingsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextWidget(
              text: AppLanguageKeys().strRatings.tr,
              color: AppColors().appBlackColor,
              size: 19,
              fontWeight: FontWeight.bold,
              isLineThrough: false,
            ),
            Icon(
              Icons.edit_calendar_rounded,
              color: AppColors().appPrimaryColor,
              size: 30,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          height: 160,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildRatingRow(context, 5, 1, 150),
                      const SizedBox(height: 2),
                      buildRatingRow(context, 4, 1, 130),
                      const SizedBox(height: 2),
                      buildRatingRow(context, 3, 1, 100),
                      const SizedBox(height: 2),
                      buildRatingRow(context, 2, 1, 70),
                      const SizedBox(height: 2),
                      buildRatingRow(context, 1, 1, 50),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: <Widget>[
                        TextWidget(
                          text: "4.0",
                          color: AppColors().appBlackColor,
                          size: 30,
                          fontWeight: FontWeight.bold,
                          isLineThrough: false,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: AppColors().appOrangeColor,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors().appOrangeColor,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors().appOrangeColor,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors().appGreyColor,
                            ),
                            Icon(
                              Icons.star,
                              color: AppColors().appGreyColor,
                            ),
                          ],
                        ),
                        TextWidget(
                          text: "52 Reviews",
                          color: AppColors().appBlackColor,
                          size: 17,
                          fontWeight: FontWeight.w500,
                          isLineThrough: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRatingRow(
      BuildContext context, int star, double value, double width) {
    return Row(
      children: <Widget>[
        TextWidget(
          text: star.toString(),
          color: AppColors().appBlackColor,
          size: 15,
          fontWeight: FontWeight.bold,
          isLineThrough: false,
        ),
        const SizedBox(width: 5),
        Icon(
          Icons.star,
          color: AppColors().appOrangeColor,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: width,
          height: 10,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              value: value,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors().appPrimaryColor,
              ),
              backgroundColor: const Color(0xffD6D6D6),
            ),
          ),
        ),
      ],
    );
  }

  Widget reviewsWidget() {
    final ProductDetailsData data = controller.rxProductDetailsData.value;
    return data.reviews?.isEmpty ?? true
        ? const SizedBox()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListView.separated(
                shrinkWrap: true,
                itemCount: data.reviews?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(indent: 16, endIndent: 16);
                },
                itemBuilder: (BuildContext context, int index) {
                  final Reviews item = data.reviews?[index] ?? Reviews();
                  final String customerFirstName = item.customerFirstName ?? "";
                  final String customerLastName = item.customerLastName ?? "";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          foregroundImage: NetworkImage(
                            item.customerProfilePhoto ?? "",
                          ),
                        ),
                        title: Text(
                          "$customerFirstName $customerLastName",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Flexible(
                              child: IgnorePointer(
                                // child: RatingBar.builder(
                                //   initialRating: (item.star ?? 0.0).toDouble(),
                                //   itemSize: 16,
                                //   unratedColor: AppColors().appGrey_,
                                //   itemBuilder:
                                //       (BuildContext context, int index) {
                                //     return Icon(
                                //       Icons.star,
                                //       color: AppColors().appOrangeColor,
                                //     );
                                //   },
                                //   onRatingUpdate: (double value) {},
                                // ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              formattedDateTime(
                                dateTimeString: item.date ?? "",
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          item.review ?? "",
                          style: TextStyle(color: AppColors().appGrey_),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          );
  }


  Widget priceAndButtonWidget(BuildContext context) {
    final ProductDetailsData data = controller.rxProductDetailsData.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidget(
              text: AppLanguageKeys().strPrice.tr,
              color: AppColors().appBlackColor,
              size: 15,
              fontWeight: FontWeight.w500,
              isLineThrough: false,
            ),
            TextWidget(
              text: "\$${data.price}",
              color: AppColors().appPrimaryColor,
              size: 20,
              fontWeight: FontWeight.bold,
              isLineThrough: false,
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width / 1.8,
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(
                AppColors().appWhiteColor,
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                AppColors().appPrimaryColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: AppColors().appPrimaryColor,
                  ),
                ),
              ),
            ),
            onPressed: () async {
              await AppNavService().pushNamed(
                destination: AppRoutes().cartScreen,
                arguments: <String, dynamic>{},
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "ADD TO CART",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Icon(
                  CupertinoIcons.arrow_right,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
