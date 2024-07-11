import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CommonHorizontalListViewBanner extends StatelessWidget {
  const CommonHorizontalListViewBanner({
    required this.pagingController,
    required this.onTap,
    required this.type,
    super.key,
  });

  final PagingController<int, Banners> pagingController;
  final Function(Banners item) onTap;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 8,
      width: double.infinity,
      child: PagedListView<int, Banners>(
        shrinkWrap: true,
        pagingController: pagingController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Banners>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, Banners item, int i) {
            final int length = pagingController.itemList?.length ?? 0;
            final bool isLast = i == length - 1;
            return Padding(
              padding: EdgeInsets.only(
                right: isLast ? 0.0 : 16.0,
              ),
              child: SizedBox(
                height: Get.height / 8,
                width: Get.width / 1.5,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: AppColors().appPrimaryColor),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  surfaceTintColor: AppColors().appWhiteColor,
                  child: Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: <Widget>[
                      stackWidget(item: item, index: i),
                      materialWidget(item: item, index: i),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget stackWidget({required Banners item, required int index}) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: <Widget>[
        CommonImageWidget(
          imageUrl: item.image ?? "",
          fit: BoxFit.contain,
          imageType: ImageType.image,
        ),
      ],
    );
  }

  Widget materialWidget({required Banners item, required int index}) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: InkWell(onTap: () async {}),
    );
  }
}
