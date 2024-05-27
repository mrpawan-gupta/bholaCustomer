import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/product_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTap,
    super.key,
  });

  final PagingController<int, Products> pagingController;
  final Function(Products item) onTap;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Products>(
      shrinkWrap: true,
      pagingController: pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1 / 1.56,
      ),
      builderDelegate: PagedChildBuilderDelegate<Products>(
        itemBuilder: (BuildContext context, Products item, int index) {
          return listAdapter(item);
        },
      ),
    );
  }

  Widget listAdapter(Products item) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () async {
        onTap(item);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            productImage(item),
            const SizedBox(height: 8),
            productNameWidget(item),
            const SizedBox(height: 4),
            productDescriptionWidget(item),
            const SizedBox(height: 4),
            ratingBarWidget(item),
            const SizedBox(height: 4),
            pricingWidget(item),
          ],
        ),
      ),
    );
  }

  Widget productImage(Products item) {
    final int discountPercent = item.discountPercent ?? 0;

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
                  child: CommonImageWidget(
                    imageUrl: item.photo ?? "",
                    fit: BoxFit.cover,
                    imageType: ImageType.image,
                  ),
                ),
                if (discountPercent != 0)
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
                        "${item.discountPercent ?? ""}%",
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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget productDescriptionWidget(Products item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.description ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget ratingBarWidget(Products item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RatingBar.builder(
          ignoreGestures: true,
          allowHalfRating: true,
          initialRating: item.cumulativeRating ?? 0.0,
          itemSize: 16,
          unratedColor: AppColors().appGrey,
          itemBuilder: (BuildContext context, int index) {
            return Icon(
              Icons.star,
              color: AppColors().appOrangeColor,
            );
          },
          onRatingUpdate: (double value) {},
        ),
      ],
    );
  }

  Widget pricingWidget(Products item) {
    final int price = item.price ?? 0;
    final int discountedPrice = item.discountedPrice ?? 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (discountedPrice == 0)
          Text(
            "₹$price",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors().appPrimaryColor,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        else
          Row(
            children: <Widget>[
              Flexible(
                child: Text(
                  "₹$discountedPrice",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors().appPrimaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  "₹$price",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
