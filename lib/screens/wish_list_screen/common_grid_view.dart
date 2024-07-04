import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/wish_list_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTap,
    required this.onPressedToCart,
    required this.onPressedDelete,
    required this.type,
    super.key,
  });

  final PagingController<int, WishListItems> pagingController;
  final Function(WishListItems item) onTap;
  final Function(WishListItems item) onPressedToCart;
  final Function(WishListItems item) onPressedDelete;
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
        childAspectRatio: 1 / 1.80,
      ),
      builderDelegate: PagedChildBuilderDelegate<WishListItems>(
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          // return AppNoItemFoundWidget(
          //   title: "No items found",
          //   message: "The $type is currently empty.",
          //   onTryAgain: pagingController.refresh,
          // );
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
                    width: 100,
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
          return listAdapter(item);
        },
      ),
    );
  }

  Widget listAdapter(WishListItems item) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () async {
        onTap(item);
      },
      child: Padding(
        padding: EdgeInsets.zero,
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
            const SizedBox(height: 4),
            pricingWidget1(item),
          ],
        ),
      ),
    );
  }

  Widget pricingWidget1(WishListItems item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 32,
                child: AppElevatedButton(
                  text: "Move to Cart",
                  onPressed: () async {
                    onPressedToCart(item);
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 32,
              width: 32,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await openMoreOptionsWidget(
                    item: item,
                    onPressedDelete: onPressedDelete,
                  );
                },
                icon: CircleAvatar(
                  backgroundColor: AppColors().appPrimaryColor,
                  child: Icon(
                    Icons.more_horiz,
                    color: AppColors().appWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget productImage(WishListItems item) {
    final num discountPercent = item.discountPercent ?? 0;

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
                        "Get upto ${item.discountPercent ?? ""}% off",
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

  Widget productNameWidget(WishListItems item) {
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

  Widget productDescriptionWidget(WishListItems item) {
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

  Widget ratingBarWidget(WishListItems item) {
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

  Widget pricingWidget(WishListItems item) {
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

  Future<void> openMoreOptionsWidget({
    required WishListItems item,
    required Function(WishListItems item) onPressedDelete,
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
          ListTile(
            dense: true,
            title: const Text("Delete"),
            trailing: const Icon(Icons.delete),
            onTap: () async {
              AppNavService().pop();

              await openDeleteServiceWidget(
                item: item,
                onPressedDelete: onPressedDelete,
              );
            },
          ),
          const SizedBox(height: 48),
        ],
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );
    return Future<void>.value();
  }

  Future<void> openDeleteServiceWidget({
    required WishListItems item,
    required Function(WishListItems item) onPressedDelete,
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
                    text: "Do not delete product",
                    onPressed: () {
                      AppNavService().pop();
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 50,
                  child: AppTextButton(
                    text: "Delete product",
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
