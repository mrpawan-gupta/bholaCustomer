import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/wish_list_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:like_button/like_button.dart";

class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTap,
    required this.onTapAddToWish,
    required this.onTapBottomButton,
    required this.type,
    super.key,
  });

  final PagingController<int, WishListItems> pagingController;
  final Function(WishListItems item) onTap;
  final Function(WishListItems item, {required bool isLiked}) onTapAddToWish;
  final Function(WishListItems item) onTapBottomButton;
  final String type;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, WishListItems>(
      shrinkWrap: true,
      pagingController: pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1 / 1.64,
      ),
      builderDelegate: PagedChildBuilderDelegate<WishListItems>(
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
                    Icons.favorite,
                    color: AppColors().appRedColor,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Your wishlist is empty!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Explore more & shortlist some items!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: (Get.width) / 2,
                    child: AppTextButton(
                      text: "Start Shopping",
                      onPressed: () async {
                        await AppNavService().pushNamed(
                          destination: AppRoutes().productListingScreen,
                          arguments: <String, dynamic>{},
                        );

                        pagingController.refresh();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
        itemBuilder: (BuildContext context, WishListItems item, int index) {
          final int length =
              (pagingController.itemList ?? <WishListItems>[]).length;
          final bool isLast1 = index == length - 1;
          final bool isLast2 = index == length - 2;
          return Column(
            children: <Widget>[
              Expanded(child: listAdapter(item, index)),
              SizedBox(height: isLast1 || isLast2 ? 16 : 0),
            ],
          );
        },
      ),
    );
  }

  Widget listAdapter(WishListItems item, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () async {
        onTap(item);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          productImage(item),
          const SizedBox(height: 4),
          const SizedBox(height: 4),
          productNameAndDetailsWidget(item),
          const SizedBox(height: 4),
          priceAndLikeRow(item),
          const SizedBox(height: 4),
          const SizedBox(height: 4),
          bottomButton(item),
        ],
      ),
    );
  }

  Widget productImage(WishListItems item) {
    final num discountPercent = item.discountPercent ?? 0;
    final num cumulativeRating = item.cumulativeRating ?? 0.0;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Stack(
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
                  child: CommonImageWidget(
                    imageUrl: item.photo ?? "",
                    fit: BoxFit.contain,
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
                        "${item.discountPercent ?? ""}% off",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors().appWhiteColor,
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox(),
                if (cumulativeRating != 0.0)
                  Positioned(
                    bottom: 0,
                    left: 0,
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
                        "$cumulativeRating ★",
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

  Widget productNameAndDetailsWidget(WishListItems item) {
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
        Text(
          item.category?.name ?? "",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors().appGrey,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "${item.quantity ?? ""} ${item.unit ?? ""}",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget pricingWidget(WishListItems item) {
    final num price = item.price ?? 0;
    final num discountedPrice = item.discountedPrice ?? 0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (discountedPrice == 0)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "₹$price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().appPrimaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors().appGrey,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors().appGreyColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
        else
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "₹$discountedPrice",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors().appPrimaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "₹$price",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors().appGrey,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors().appGreyColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
      ],
    );
  }

  Widget likeButton(WishListItems item) {
    const bool isInWishList = true;

    return LikeButton(
      size: 24,
      isLiked: isInWishList,
      onTap: (bool isLiked) {
        onTapAddToWish(item, isLiked: isLiked);

        return Future<bool>.value(!isInWishList);
      },
    );
  }

  Widget priceAndLikeRow(WishListItems item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: pricingWidget(item)),
        likeButton(item),
      ],
    );
  }

  Widget bottomButton(WishListItems item) {
    final bool isInCartList = (item.cartQty ?? 0) > 0;

    return SizedBox(
      height: 32,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: AppColors().appWhiteColor,
        color: AppColors().appPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: InkWell(
          onTap: () {
            onTapBottomButton(item);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Text(
                    isInCartList ? "View in Cart" : "Add to Cart",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors().appWhiteColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
