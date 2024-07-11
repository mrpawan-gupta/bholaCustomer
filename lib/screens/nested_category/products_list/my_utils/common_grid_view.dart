import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/product_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:like_button/like_button.dart";

class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTap,
    required this.onTapAddToWish,
    required this.onTapAddToCart,
    required this.incQty,
    required this.decQty,
    required this.onPressedDelete,
    required this.type,
    super.key,
  });

  final PagingController<int, Products> pagingController;
  final Function(Products item) onTap;
  final Function(Products item, {required bool isLiked}) onTapAddToWish;
  final Function(Products item) onTapAddToCart;
  final Function(Products item) incQty;
  final Function(Products item) decQty;
  final Function(Products item) onPressedDelete;
  final String type;

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
        childAspectRatio: 1 / 1.64,
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
          final int length = (pagingController.itemList ?? <Products>[]).length;
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

  Widget listAdapter(Products item, int index) {
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

  Widget productImage(Products item) {
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

  Widget productNameAndDetailsWidget(Products item) {
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

  Widget pricingWidget(Products item) {
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

  Widget likeButton(Products item) {
    final bool isInWishList = item.isInWishList ?? false;

    return LikeButton(
      size: 24,
      isLiked: isInWishList,
      onTap: (bool isLiked) {
        onTapAddToWish(item, isLiked: isLiked);

        return Future<bool>.value(!isInWishList);
      },
    );
  }

  Widget priceAndLikeRow(Products item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: pricingWidget(item)),
        likeButton(item),
      ],
    );
  }

  Widget bottomButton(Products item) {
    final bool isInCartList = (item.cartQty ?? 0) > 0;

    return SizedBox(
      height: 32,
      child: isInCartList
          ? Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              margin: EdgeInsets.zero,
              color: AppColors().appPrimaryColor,
              surfaceTintColor: AppColors().appWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: InkWell(
                onTap: () async {},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () async {
                            if ((item.cartQty ?? 0) > 1) {
                              decQty(item);
                            } else {
                              await openDeleteCartItemWidget(
                                item: item,
                                onPressedDelete: onPressedDelete,
                              );
                            }
                          },
                          child: ColoredBox(
                            color: AppColors().appWhiteColor.withOpacity(0.16),
                            child: Icon(
                              Icons.remove,
                              color: AppColors().appWhiteColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${item.cartQty ?? 0}",
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.0),
                          onTap: () async {
                            if ((item.cartQty ?? 0) < 100) {
                              incQty(item);
                            } else {}
                          },
                          child: ColoredBox(
                            color: AppColors().appWhiteColor.withOpacity(0.16),
                            child: Icon(
                              Icons.add,
                              color: AppColors().appWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              margin: EdgeInsets.zero,
              color: AppColors().appPrimaryColor,
              surfaceTintColor: AppColors().appWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: InkWell(
                onTap: () {
                  onTapAddToCart(item);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Add to Cart",
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

  Future<void> openDeleteCartItemWidget({
    required Products item,
    required Function(Products item) onPressedDelete,
  }) async {
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
              "Are you sure you want to delete? It is an irreversible process!",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
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
                    text: "Do not delete cart item",
                    onPressed: () {
                      AppNavService().pop();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: AppTextButton(
                    text: "Delete cart item",
                    onPressed: () async {
                      AppNavService().pop();

                      onPressedDelete(item);
                    },
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
}
