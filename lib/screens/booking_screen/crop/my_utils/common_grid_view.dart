import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/get_all_crops_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonGridView extends StatelessWidget {
  const CommonGridView({
    required this.pagingController,
    required this.onTap,
    required this.type,
    super.key,
  });

  final PagingController<int, Crops> pagingController;
  final Function(Crops item) onTap;
  final String type;

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Crops>(
      shrinkWrap: true,
      pagingController: pagingController,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1 / 1.32,
      ),
      builderDelegate: PagedChildBuilderDelegate<Crops>(
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return const SizedBox();
        },
        itemBuilder: (BuildContext context, Crops item, int index) {
          final int length = (pagingController.itemList ?? <Crops>[]).length;
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

  Widget listAdapter(Crops item, int index) {
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
        ],
      ),
    );
  }

  Widget productImage(Crops item) {
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

  Widget productNameAndDetailsWidget(Crops item) {
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
          item.description ?? "",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
