import "package:customer/controllers/wish_list_controller/wish_list_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/wish_list_model.dart";
import "package:customer/screens/wish_list_screen/common_grid_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";

class WishListScreen extends GetWidget<WishListController> {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Wish List"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return LiquidPullToRefresh(
                    showChildOpacityTransition: false,
                    color: AppColors().appPrimaryColor,
                    backgroundColor: AppColors().appWhiteColor,
                    onRefresh: () async {
                      controller.pagingControllerCategories.refresh();
                      controller.pagingControllerWishList.refresh();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            chipSelection(),
                            const SizedBox(height: 16 - 4),
                            gridView(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chipSelection() {
    return SizedBox(
      height: 32 + 8,
      width: double.infinity,
      child: PagedListView<int, Categories>(
        shrinkWrap: true,
        pagingController: controller.pagingControllerCategories,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Categories>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return const SizedBox();
          },
          itemBuilder: (BuildContext context, Categories item, int index) {
            final List<Categories> itemList =
                controller.pagingControllerCategories.itemList ??
                    <Categories>[];
            final int length = itemList.length;
            final bool isLast = index == length - 1;
            return Obx(
              () {
                return Padding(
                  padding:
                      EdgeInsets.only(right: isLast ? 0.0 : 16.0, bottom: 4),
                  child: Card(
                    margin: EdgeInsets.zero,
                    elevation: 4,
                    color: controller.rxSelectedCategory.value == item
                        ? AppColors().appPrimaryColor
                        : AppColors().appWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      side: BorderSide(
                        color: AppColors().appPrimaryColor,
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    surfaceTintColor:
                        controller.rxSelectedCategory.value == item
                            ? AppColors().appPrimaryColor
                            : AppColors().appWhiteColor,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () async {
                        final String itemId = item.sId ?? "";
                        final String selectedId =
                            controller.rxSelectedCategory.value.sId ?? "";

                        controller.updateSelectedCategory(
                          itemId == selectedId ? Categories() : item,
                        );

                        controller.pagingControllerWishList.refresh();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            item.name ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.rxSelectedCategory.value == item
                                  ? AppColors().appWhiteColor
                                  : AppColors().appPrimaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget gridView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonGridView(
          pagingController: controller.pagingControllerWishList,
          onTap: (WishListItems item) async {
            await AppNavService().pushNamed(
              destination: AppRoutes().viewGenericProductDetailsScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );

            controller.pagingControllerWishList.refresh();
          },
          onPressedToCart: (WishListItems item) async {
            await controller.addToCartAPICall(id: item.sId ?? "");

            await AppNavService().pushNamed(
              destination: AppRoutes().cartScreen,
              arguments: <String, dynamic>{},
            );

            controller.pagingControllerWishList.refresh();
          },
          onPressedDelete: (WishListItems item) async {
            bool value = false;
            value = await controller.deleteProductAPICall(id: item.sId ?? "");

            if (value) {
              controller.pagingControllerWishList.refresh();
            } else {}
          },
          type: "wish list",
        ),
      ],
    );
  }
}
