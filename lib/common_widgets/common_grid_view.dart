import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/common_widgets/common_gradient.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/common_widgets/empty_vehicle_or_product_widget.dart";
import "package:customer/models/product_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/localization/app_language_keys.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";


class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTapExistingProduct,
    required this.onTapNewProduct,
    super.key,
  });

  final PagingController<int, Products> pagingController;
  final Function(Products item) onTapExistingProduct;
  final Function() onTapNewProduct;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Products>(
      shrinkWrap: true,
      pagingController: pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      builderDelegate: PagedChildBuilderDelegate<Products>(
        itemBuilder: (BuildContext context, Products item, int i) {
          // final int length = pagingController.itemList?.length ?? 0;
          // final bool isLast = i == length - 1;
          final Map<String, dynamic> defaultItem = item.toJson();
          final Map<String, dynamic> defaultModel = Products().toJson();
          final bool isManuallyAdded = mapEquals(defaultItem, defaultModel);
          return SizedBox(
            height: 150,
            width: 150,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              margin: EdgeInsets.zero,
              child: !isManuallyAdded
                  ? Stack(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: <Widget>[
                        stackWidget(item: item, index: i),
                        materialWidget(item: item, index: i),
                      ],
                    )
                  : EmptyVehicleOrProductWidget(
                      text: AppLanguageKeys().strClickHereToAddNewProduct.tr,
                      onTap: onTapNewProduct,
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget stackWidget({required Products item, required int index}) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: <Widget>[
        CommonImageWidget(
          imageUrl: item.photo ?? "",
          fit: BoxFit.cover,
        ),
        AnimatedOpacity(
          opacity: 1.00,
          duration: const Duration(milliseconds: 250),
          child: commonGradientWidget(
            photo: item,
            index: index,
          ),
        ),
      ],
    );
  }

  Widget materialWidget({required Products item, required int index}) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          onTapExistingProduct(item);
        },
      ),
    );
  }

  Widget commonGradientWidget({required Products photo, required int index}) {
    return CommonGradient(
      child: Material(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.transparent,
        child: MaybeMarqueeText(
          text: photo.name ?? "",
          style: TextStyle(
            fontSize: 16,
            color: AppColors().appWhiteColor,
            fontWeight: FontWeight.bold,
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
