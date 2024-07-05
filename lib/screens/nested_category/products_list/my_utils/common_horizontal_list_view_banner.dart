import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/banner_model.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

final RxDouble defaultBannerHeight = 150.0.obs;
final RxDouble defaultBannerWidth = double.infinity.obs;

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
    return Obx(
      () {
        return SizedBox(
          height: defaultBannerHeight.value,
          width: defaultBannerWidth.value,
          child: PagedListView<int, Banners>(
            shrinkWrap: true,
            pagingController: pagingController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const ScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            builderDelegate: PagedChildBuilderDelegate<Banners>(
              noItemsFoundIndicatorBuilder: (BuildContext context) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (Duration timeStamp) {
                    defaultBannerHeight(0.0);
                    defaultBannerWidth(0.0);
                  },
                );
                return const SizedBox();
              },
              itemBuilder: (BuildContext context, Banners item, int i) {
                final int length = pagingController.itemList?.length ?? 0;
                final bool isLast = i == length - 1;
                return Padding(
                  padding: EdgeInsets.only(
                    top: 16.0,
                    bottom: 16.0,
                    right: isLast ? 0.0 : 16.0,
                  ),
                  child: SizedBox(
                    height: defaultBannerHeight.value,
                    width: defaultBannerHeight.value * 2,
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 0,
                      margin: EdgeInsets.zero,
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
      },
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
