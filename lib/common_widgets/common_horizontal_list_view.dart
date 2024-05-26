import "package:customer/common_widgets/app_maybe_marquee.dart";
import "package:customer/common_widgets/common_gradient.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";


class CommonHorizontalListView extends StatelessWidget {
  const CommonHorizontalListView({
    required this.pagingController,
    required this.onTap,
    super.key,
  });

  final PagingController<int, Categories> pagingController;
  final Function(Categories item) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: PagedListView<int, Categories>(
        shrinkWrap: true,
        pagingController: pagingController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Categories>(
          itemBuilder: (BuildContext context, Categories item, int i) {
            final int length = pagingController.itemList?.length ?? 0;
            final bool isLast = i == length - 1;
            return Padding(
              padding: EdgeInsets.only(
                right: isLast ? 0.0 : 16.0,
              ),
              child: SizedBox(
                height: 150,
                width: 150,
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
  }

  Widget stackWidget({required Categories item, required int index}) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: <Widget>[
        CommonImageWidget(
          imageUrl: item.photo ?? "",
          fit: BoxFit.cover,
          imageType: ImageType.image,
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

  Widget materialWidget({required Categories item, required int index}) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          onTap(item);
        },
      ),
    );
  }

  Widget commonGradientWidget({required Categories photo, required int index}) {
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
