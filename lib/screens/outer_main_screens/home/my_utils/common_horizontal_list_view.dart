import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonHorizontalListView extends StatelessWidget {
  const CommonHorizontalListView({
    required this.pagingController,
    required this.onTap,
    required this.type,
    super.key,
  });

  final PagingController<int, Categories> pagingController;
  final Function(Categories item) onTap;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 6,
      width: double.infinity,
      child: PagedGridView<int, Categories>(
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
          childAspectRatio: 1.32 / 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<Categories>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return AppNoItemFoundWidget(
              title: "No items found",
              message: "The $type is currently empty.",
              onTryAgain: pagingController.refresh,
            );
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
          const SizedBox(height: 8),
          productNameWidget(item),
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

  Widget productNameWidget(Categories item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          item.name ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
