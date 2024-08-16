import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

enum Types { products, services }

class CommonHorizontalListView extends StatelessWidget {
  const CommonHorizontalListView({
    required this.pagingController,
    required this.onTap,
    required this.onTapViewAll,
    required this.type,
    required this.itemType,
    required this.needViewAll,
    super.key,
  });

  final PagingController<int, Categories> pagingController;
  final Function(Categories item) onTap;
  final Function(Categories item) onTapViewAll;
  final String type;
  final Types itemType;
  final bool needViewAll;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: needViewAll ? Get.height / 4.80 : Get.height / 5.96,
      width: double.infinity,
      child: PagedGridView<int, Categories>(
        shrinkWrap: true,
        pagingController: pagingController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: needViewAll ? 1.64 / 1 : 1.32 / 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<Categories>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, Categories item, int index) {
            return listAdapter(item);
          },
        ),
      ),
    );
  }

  Widget listAdapter(Categories item) {
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
          SizedBox(height: needViewAll ? 4 : 0),
          SizedBox(height: needViewAll ? 4 : 0),
          if (needViewAll) bottomButton(item) else const SizedBox(),
        ],
      ),
    );
  }

  Widget productImage(Categories item) {
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

  Widget productNameAndDetailsWidget(Categories item) {
    final num itemCount = itemType == Types.products
        ? item.productCount ?? 0
        : itemType == Types.services
            ? item.vehicleCount ?? 0
            : 0;
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
        Row(
          children: <Widget>[
            Text(
              itemCount != 0 ? "$itemCount" : "No",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: itemCount != 0
                    ? AppColors().appPrimaryColor
                    : AppColors().appGreyColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Flexible(
              child: Text(
                " ${itemType.name} available",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
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

  Widget bottomButton(Categories item) {
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
          onTap: () async {
            onTapViewAll(item);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Text(
                    itemType == Types.products
                        ? "View All"
                        : itemType == Types.services
                            ? "Book Now"
                            : "",
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
