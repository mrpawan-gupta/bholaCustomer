import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/screens/outer_main_screens/home/my_utils/common_home_title_bar.dart";
import "package:customer/screens/outer_main_screens/home/my_utils/common_horizontal_list_view.dart";
import "package:customer/screens/outer_main_screens/home/my_utils/common_horizontal_list_view_banner.dart";
import "package:customer/screens/outer_main_screens/home/my_utils/common_horizontal_list_view_products.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart";

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  controller
                    ..pagingControllerServices.refresh()
                    ..pagingControllerCategories.refresh()
                    ..pagingControllerBanners.refresh();
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
                        featuredServicesWidget(),
                        const SizedBox(height: 32),
                        featuredCategoriesWidget(),
                        const SizedBox(height: 16),
                        banners(),
                        const SizedBox(height: 16),
                        dynamicWidget(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget featuredServicesWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CommonHomeTitleBar(
            title: "🚜 Featured Services",
            isViewAllNeeded: false,
            onTapViewAll: () {},
          ),
        ),
        Divider(
          color: AppColors().appGrey,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
        CommonHorizontalListView(
          pagingController: controller.pagingControllerServices,
          onTap: (Categories item) async {
            final bool isApproved = (item.status ?? "") == "Approved";
            if (isApproved) {
              await tabControllerFunction(2);
            } else {
              AppSnackbar().snackbarFailure(
                title: "Oops!",
                message: "Coming Soon!",
              );
            }
          },
          needViewAll: true,
          onTapViewAll: (Categories item) async {
            final bool isApproved = (item.status ?? "") == "Approved";
            if (isApproved) {
              await tabControllerFunction(2);
            } else {
              AppSnackbar().snackbarFailure(
                title: "Oops!",
                message: "Coming Soon!",
              );
            }
          },
          type: "rental categories list",
          itemString: "Categories",
        ),
      ],
    );
  }

  Widget featuredCategoriesWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CommonHomeTitleBar(
            title: "🌾 Featured Categories",
            isViewAllNeeded: false,
            onTapViewAll: () {},
          ),
        ),
        Divider(
          color: AppColors().appGrey,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
        CommonHorizontalListView(
          pagingController: controller.pagingControllerCategories,
          onTap: (Categories item) async {
            await AppNavService().pushNamed(
              destination: AppRoutes().productListingScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );
          },
          needViewAll: true,
          onTapViewAll: (Categories item) async {
            await AppNavService().pushNamed(
              destination: AppRoutes().productListingScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );
          },
          type: "product services list",
          itemString: "Services",
        ),
      ],
    );
  }

  Widget banners() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonHorizontalListViewBanner(
          pagingController: controller.pagingControllerBanners,
          onTap: (Banners item) {},
          type: "banners list",
        ),
      ],
    );
  }

  Widget dynamicWidget() {
    return ValueListenableBuilder<PagingState<int, Categories>>(
      valueListenable: controller.valueNotifierCategories,
      builder: (
        BuildContext context,
        PagingState<int, Categories> value,
        Widget? child,
      ) {
        return valueListenableBuilderAdapter();
      },
    );
  }

  Widget valueListenableBuilderAdapter() {
    final List<PagingController<int, Products>> dynamicList =
        controller.pagingControllerDynamic;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dynamicList.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (BuildContext context, int i) {
        final PagingController<int, Products> pagingController = dynamicList[i];
        final List<Categories> categoriesList =
            controller.pagingControllerCategories.itemList ?? <Categories>[];
        final Categories categories = categoriesList[i];
        final bool isLast = i == dynamicList.length - 1;
        return listViewAdapter(pagingController, categories, isLast: isLast);
      },
    );
  }

  Widget listViewAdapter(
    PagingController<int, Products> pagingController,
    Categories category, {
    required bool isLast,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0.0 : 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonHomeTitleBar(
              title: "🌾 ${category.name ?? ""}",
              isViewAllNeeded: true,
              onTapViewAll: () async {
                await AppNavService().pushNamed(
                  destination: AppRoutes().productListingScreen,
                  arguments: <String, dynamic>{"id": category.sId ?? ""},
                );
              },
            ),
          ),
          Divider(
            color: AppColors().appGrey,
            indent: 16,
            endIndent: 16,
          ),
          const SizedBox(height: 8),
          CommonHorizontalListViewProducts(
            pagingController: pagingController,
            onTap: (Products item) async {
              await AppNavService().pushNamed(
                destination: AppRoutes().viewGenericProductDetailsScreen,
                arguments: <String, dynamic>{"id": item.sId ?? ""},
              );
            },
            onTapAddToWish: (Products item, {required bool isLiked}) {},
            onTapAddToCart: (Products item) {},
            incQty: (Products item) {},
            decQty: (Products item) {},
            type: "${category.name ?? ""} list",
          ),
        ],
      ),
    );
  }
}
