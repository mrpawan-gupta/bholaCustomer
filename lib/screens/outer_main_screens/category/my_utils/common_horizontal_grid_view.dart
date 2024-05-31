import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonHorizontalGridView extends StatelessWidget {
  const CommonHorizontalGridView({
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
    return PagedGridView<int, Categories>(
      shrinkWrap: true,
      pagingController: pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.16 / 1,
      ),
      scrollDirection: Axis.horizontal,
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
          Expanded(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              margin: EdgeInsets.zero,
              color: AppColors().appGrey.withOpacity(0.10),
              child: CommonImageWidget(
                imageUrl: item.photo ?? "",
                fit: BoxFit.cover,
                imageType: ImageType.image,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.name ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
