// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, lines_longer_than_80_chars

import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";
import "package:customer/common_functions/stream_functions.dart";
import "package:customer/common_widgets/app_text_field.dart";
import "package:customer/controllers/nested_category/products_list_controller.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/screens/nested_category/products_list/my_utils/common_grid_view.dart";
import "package:customer/screens/nested_category/products_list/my_utils/common_horizontal_list_view_banner.dart";
import "package:customer/screens/nested_category/products_list/my_utils/filter_category_widget.dart";
import "package:customer/screens/nested_category/products_list/my_utils/filter_range_widget.dart";
import "package:customer/screens/nested_category/products_list/my_utils/filter_sort_by_widget.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_debouncer.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class ProductsListScreen extends GetView<ProductsListController> {
  const ProductsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Products Listing"),
            surfaceTintColor: AppColors().appTransparentColor,
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().wishListScreen,
                        arguments: <String, dynamic>{},
                      );

                      functionSinkAdd();
                    },
                    icon: Badge(
                      isLabelVisible: rxWishListCount.value != 0,
                      label: Text("${rxWishListCount.value}"),
                      textColor: AppColors().appWhiteColor,
                      backgroundColor: AppColors().appPrimaryColor,
                      child: Image.asset(
                        AppAssetsImages().appBarWish,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        color: rxWishListCount.value != 0
                            ? AppColors().appPrimaryColor
                            : AppColors().appGreyColor,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await AppNavService().pushNamed(
                        destination: AppRoutes().cartScreen,
                        arguments: <String, dynamic>{},
                      );

                      functionSinkAdd();
                    },
                    icon: Badge(
                      isLabelVisible: rxCartListCount.value != 0,
                      label: Text("${rxCartListCount.value}"),
                      textColor: AppColors().appWhiteColor,
                      backgroundColor: AppColors().appPrimaryColor,
                      child: Image.asset(
                        AppAssetsImages().appBarCart,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        color: rxCartListCount.value != 0
                            ? AppColors().appPrimaryColor
                            : AppColors().appGreyColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
          body: SafeArea(
            child: Obx(
              () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    searchBarWidget(),
                    const SizedBox(height: 16),
                    filterWidget(),
                    // const SizedBox(height: 16),
                    // actionChipsWidget(),
                    const SizedBox(height: 0),
                    banners(),
                    const SizedBox(height: 0),
                    gridView(),
                    // const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors().appGreyColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 16 + 8),
                  Icon(Icons.search, color: AppColors().appGreyColor),
                  const SizedBox(width: 16 + 8),
                  Expanded(
                    child: AppTextField(
                      controller: controller.searchController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.search,
                      readOnly: false,
                      obscureText: false,
                      maxLines: 1,
                      maxLength: null,
                      onChanged: (String value) {
                        controller.updateSearchQuery(value);

                        AppDebouncer().debounce(
                          controller.pagingControllerRecently.refresh,
                        );
                      },
                      onTap: () {},
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      enabled: true,
                      autofillHints: const <String>[],
                      hintText: "Search here...",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors().appGreyColor,
                      ),
                      prefixIcon: null,
                      suffixIcon: null,
                    ),
                  ),
                  const SizedBox(width: 16 + 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterCount().value > 0
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.filter_alt_outlined,
                        color: controller.filterCount().value > 0
                            ? AppColors().appWhiteColor
                            : AppColors().appGrey,
                      ),
                      const SizedBox(width: 4),
                      CircleAvatar(
                        backgroundColor: AppColors().appWhiteColor,
                        radius: 12,
                        child: Text(
                          "${controller.filterCount().value}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterIsPriceApplied().value
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: openFilterRangeWidget,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Text(
                          "Price",
                          style: TextStyle(
                            color: controller.filterIsPriceApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (controller.filterIsPriceApplied().value)
                          CircleAvatar(
                            backgroundColor: AppColors().appWhiteColor,
                            radius: 12,
                            child: const Text(
                              "1",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        else
                          Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: controller.filterIsPriceApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterIsSortByApplied().value
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: openFilterSortByWidget,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Text(
                          "Sort By",
                          style: TextStyle(
                            color: controller.filterIsSortByApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (controller.filterIsSortByApplied().value)
                          CircleAvatar(
                            backgroundColor: AppColors().appWhiteColor,
                            radius: 12,
                            child: const Text(
                              "1",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        else
                          Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: controller.filterIsSortByApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: controller.filterIsCategoryApplied().value
                      ? AppColors().appPrimaryColor
                      : AppColors().appGrey.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: openFilterCategoryWidget,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 4),
                        Text(
                          "Category",
                          style: TextStyle(
                            color: controller.filterIsCategoryApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        if (controller.filterIsCategoryApplied().value)
                          CircleAvatar(
                            backgroundColor: AppColors().appWhiteColor,
                            radius: 12,
                            child: const Text(
                              "1",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        else
                          Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: controller.filterIsCategoryApplied().value
                                ? AppColors().appWhiteColor
                                : AppColors().appGrey,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget actionChipsWidget() {
    return controller.filterList().isEmpty
        ? const SizedBox()
        : Column(
            children: <Widget>[
              const SizedBox(height: 0),
              SizedBox(
                height: kToolbarHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filterList().length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  physics: const ScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<int, String> filterList = controller.filterList();
                    final int key = filterList.keys.elementAt(index);
                    final String value = filterList.values.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Chip(
                        shape: const StadiumBorder(),
                        label: Text(value),
                        deleteIcon: const Icon(Icons.remove_circle, size: 20),
                        deleteIconColor: AppColors().appRedColor,
                        onDeleted: () {
                          controller.onDeleteFilter(key);

                          controller.pagingControllerRecently.refresh();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
  }

  Widget banners() {
    return ValueListenableBuilder<PagingState<int, Banners>>(
      valueListenable: controller.pagingControllerBanners,
      builder: (
        BuildContext context,
        PagingState<int, Banners> value,
        Widget? child,
      ) {
        return (value.itemList?.isEmpty ?? false)
            ? const SizedBox(height: 16)
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 16),
                  CommonHorizontalListViewBanner(
                    pagingController: controller.pagingControllerBanners,
                    onTap: (Banners item) {},
                    type: "banners list",
                  ),
                  const SizedBox(height: 16),
                ],
              );
      },
    );
  }

  Widget gridView() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: CommonGridView(
              pagingController: controller.pagingControllerRecently,
              onTap: (Products item) async {
                await AppNavService().pushNamed(
                  destination: AppRoutes().viewGenericProductDetailsScreen,
                  arguments: <String, dynamic>{"id": item.sId ?? ""},
                );

                controller.pagingControllerRecently.refresh();
              },
              onTapAddToWish: (Products item, {required bool isLiked}) async {
                bool value = false;
                value = isLiked
                    ? await removeFromWishListAPICall(productId: item.sId ?? "")
                    : await addToWishListAPICall(productId: item.sId ?? "");

                if (value) {
                  item.isInWishList = !(item.isInWishList ?? false);
                  isLiked = item.isInWishList ?? false;
                  controller.pagingControllerRecently.notifyListeners();
                } else {}
              },
              onTapAddToCart: (Products item) async {
                (bool, String) value = (false, "");
                value = await addToCartAPICall(productId: item.sId ?? "");

                if (value.$1) {
                  item
                    ..cartQty = 1
                    ..cartItemId = value.$2;
                  controller.pagingControllerRecently.notifyListeners();
                } else {}
              },
              incQty: (Products item) async {
                final num newQty = (item.cartQty ?? 0) + 1;

                bool value = false;
                value = await updateCartAPICall(
                  itemId: item.cartItemId ?? "",
                  cartId: item.cartId ?? "",
                  qty: newQty,
                );

                if (value) {
                  item.cartQty = newQty;
                  controller.pagingControllerRecently.notifyListeners();
                } else {}
              },
              decQty: (Products item) async {
                final num newQty = (item.cartQty ?? 0) - 1;

                bool value = false;
                value = await updateCartAPICall(
                  itemId: item.cartItemId ?? "",
                  cartId: item.cartId ?? "",
                  qty: newQty,
                );

                if (value) {
                  item.cartQty = newQty;
                  controller.pagingControllerRecently.notifyListeners();
                } else {}
              },
              onPressedDelete: (Products item) async {
                bool value = false;
                value = await removeFromCartAPICall(
                  itemId: item.cartItemId ?? "",
                  cartId: item.cartId ?? "",
                );

                if (value) {
                  item.cartQty = 0;
                  controller.pagingControllerRecently.notifyListeners();
                } else {}
              },
              type: "product list",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> openFilterRangeWidget() async {
    final double minimumRange = controller.rxFilterMinRange.value;
    final double maximumRange = controller.rxFilterMaxRange.value;

    final (double, double)? result = await Get.bottomSheet(
      FilterRangeWidget(minimumRange: minimumRange, maximumRange: maximumRange),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );

    if (result != null) {
      controller
        ..updateFilterMinRange(result.$1)
        ..updateFilterMaxRange(result.$2);

      controller.pagingControllerRecently.refresh();
    } else {}

    return Future<void>.value();
  }

  Future<void> openFilterSortByWidget() async {
    final String selectedSortBy = controller.rxFilterSelectedSortBy.value;

    final String? result = await Get.bottomSheet(
      FilterSortByWidget(
        selectedSortBy: selectedSortBy,
        sortByList: controller.defaultSortBy,
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );

    if (result != null) {
      controller.updateFilterSelectedSortBy(result);

      controller.pagingControllerRecently.refresh();
    } else {}

    return Future<void>.value();
  }

  Future<void> openFilterCategoryWidget() async {
    final Categories selectedCategory =
        controller.rxFilterSelectedCategory.value;

    final Categories? result = await Get.bottomSheet(
      FilterCategoryByWidget(
        selectedCategory: selectedCategory,
        categoriesList: controller.categoriesList,
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isScrollControlled: true,
    );

    if (result != null) {
      controller.updateFilterSelectedCategory(result);

      controller.pagingControllerRecently.refresh();
    } else {}

    return Future<void>.value();
  }
}
