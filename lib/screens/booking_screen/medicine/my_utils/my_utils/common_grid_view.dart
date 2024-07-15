import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/get_all_medicines_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTap,
    required this.onTapResetAndRefresh,
    required this.type,
    super.key,
  });

  final PagingController<int, CropMedicines> pagingController;
  final Function(CropMedicines item) onTap;
  final Function() onTapResetAndRefresh;
  final String type;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, CropMedicines>(
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
      builderDelegate: PagedChildBuilderDelegate<CropMedicines>(
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
                    Icons.medication,
                    color: AppColors().appPrimaryColor,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No medicines found in this crop!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "If you've applied filters, try changing/removing it.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: AppTextButton(
                      text: "Reset & Refresh",
                      onPressed: onTapResetAndRefresh,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
        itemBuilder: (BuildContext context, CropMedicines item, int index) {
          final int length =
              (pagingController.itemList ?? <CropMedicines>[]).length;
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

  Widget listAdapter(CropMedicines item, int index) {
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
        ],
      ),
    );
  }

  Widget productImage(CropMedicines item) {
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

  Widget productNameAndDetailsWidget(CropMedicines item) {
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
          item.brand ?? "",
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors().appGrey,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          item.description ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget pricingWidget(CropMedicines item) {
    final num price = item.price ?? 0;

    return Column(
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
      ],
    );
  }

  Widget priceAndLikeRow(CropMedicines item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: pricingWidget(item)),
      ],
    );
  }
}
