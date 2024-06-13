import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/screens/outer_main_screens/category/my_utils/common_category_title_bar.dart";
import "package:customer/screens/outer_main_screens/category/my_utils/common_horizontal_grid_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        featuredServicesWidget(),
        const SizedBox(height: 32),
        featuredCategoriesidget(),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget featuredServicesWidget() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonCategoryTitleBar(
              title: "🚜 Rental Categories",
              onTapViewAll: () {},
              isViewAllNeeded: false,
            ),
          ),
          Divider(color: AppColors().appGrey, indent: 16, endIndent: 16),
          const SizedBox(height: 8),
          Expanded(
            child: CommonHorizontalGridView(
              pagingController: controller.pagingControllerServices,
              onTap: (Categories item) async {
                // await AppNavService().pushNamed(
                //   destination: AppRoutes().productListingScreen,
                //   arguments: <String, dynamic>{"id": item.sId ?? ""},
                // );

                await tabControllerFunction(2);
              },
              type: "rental categories list",
            ),
          ),
        ],
      ),
    );
  }

  Widget featuredCategoriesidget() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CommonCategoryTitleBar(
              title: "🌾 Product Categories",
              onTapViewAll: () {},
              isViewAllNeeded: false,
            ),
          ),
          Divider(color: AppColors().appGrey, indent: 16, endIndent: 16),
          const SizedBox(height: 8),
          Expanded(
            child: CommonHorizontalGridView(
              pagingController: controller.pagingControllerCategories,
              onTap: (Categories item) async {
                await AppNavService().pushNamed(
                  destination: AppRoutes().productListingScreen,
                  arguments: <String, dynamic>{"id": item.sId ?? ""},
                );
              },
              type: "product categories list",
            ),
          ),
        ],
      ),
    );
  }
}
