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
import "package:flutter/material.dart";
import "package:get/get.dart";
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
                    ..pagingControllerBanners.refresh()
                    ..pagingControllerCattleFeed.refresh()
                    ..pagingControllerFertilizer.refresh();
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
                        const SizedBox(height: 32),
                        banners(),
                        const SizedBox(height: 32),
                        cattleFeedWidget(),
                        const SizedBox(height: 32),
                        fertilizerWidget(),
                        // const SizedBox(height: 32),
                        // const SizedBox(height: 32),
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
            await AppNavService().pushNamed(
              destination: AppRoutes().productListingScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );
          },
          type: "rental categories list",
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
          type: "product categories list",
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

  Widget cattleFeedWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CommonHomeTitleBar(
            title: "🌾 Cattle Feed",
            isViewAllNeeded: true,
            onTapViewAll: () async {
              await AppNavService().pushNamed(
                destination: AppRoutes().productListingScreen,
                arguments: <String, dynamic>{},
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
          pagingController: controller.pagingControllerCattleFeed,
          onTap: (Products item) async {
            await AppNavService().pushNamed(
              destination: AppRoutes().viewGenericProductDetailsScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );
          },
          type: "Cattle Feed list",
        ),
      ],
    );
  }

  Widget fertilizerWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CommonHomeTitleBar(
            title: "🌾 Fertilizer",
            isViewAllNeeded: true,
            onTapViewAll: () async {
              await AppNavService().pushNamed(
                destination: AppRoutes().productListingScreen,
                arguments: <String, dynamic>{},
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
          pagingController: controller.pagingControllerFertilizer,
          onTap: (Products item) async {
            await AppNavService().pushNamed(
              destination: AppRoutes().viewGenericProductDetailsScreen,
              arguments: <String, dynamic>{"id": item.sId ?? ""},
            );
          },
          type: "Fertilizer list",
        ),
      ],
    );
  }
}
