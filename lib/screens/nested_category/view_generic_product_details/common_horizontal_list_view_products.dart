import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/related_suggested.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonHorizontalListViewProducts extends StatelessWidget {
  const CommonHorizontalListViewProducts({
    required this.pagingController,
    required this.onTap,
    required this.type,
    super.key,
  });

  final PagingController<int, Products> pagingController;
  final Function(Products item) onTap;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 6,
      width: double.infinity,
      child: PagedGridView<int, Products>(
        shrinkWrap: true,
        pagingController: pagingController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.40 / 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<Products>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return AppNoItemFoundWidget(
              title: "No items found",
              message: "The $type is currently empty.",
              onTryAgain: pagingController.refresh,
            );
          },
          itemBuilder: (BuildContext context, Products item, int index) {
            return listAdapter(item);
          },
        ),
      ),
    );
  }

  Widget listAdapter(Products item) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () async {
        onTap(item);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          productImage(item),
          const SizedBox(height: 8),
          productNameWidget(item),
          const SizedBox(height: 4),
          pricingWidget(item),
        ],
      ),
    );
  }

  Widget productImage(Products item) {
    final double cumulativeRating = item.cumulativeRating ?? 0.0;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 4,
                  margin: EdgeInsets.zero,
                  color: AppColors().appWhiteColor,
                  surfaceTintColor: AppColors().appWhiteColor,
                  child: CommonImageWidget(
                    imageUrl: item.photo ?? "",
                    fit: BoxFit.contain,
                    imageType: ImageType.image,
                  ),
                ),
                if (cumulativeRating != 0.0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors().appPrimaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        "$cumulativeRating★",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors().appWhiteColor,
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                Material(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () async {
                      onTap(item);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productNameWidget(Products item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.name ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget pricingWidget(Products item) {
    final num price = item.price ?? 0;
    final num discountedPrice = item.discountedPrice ?? 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (discountedPrice == 0)
          Text(
            "₹$price",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors().appPrimaryColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        else
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  "₹$discountedPrice",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors().appPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  "₹$price",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: AppColors().appGreyColor,
                    color: AppColors().appGreyColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
