import "package:customer/common_functions/rental_booking_stream.dart";
import "package:customer/common_widgets/app_elevated_button.dart";
import "package:customer/common_widgets/app_text_button.dart";
import "package:customer/controllers/main_navigation_controller.dart";
import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/screens/outer_main_screens/category/my_utils/common_category_title_bar.dart";
import "package:customer/screens/outer_main_screens/category/my_utils/common_horizontal_grid_view.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        featuredServicesWidget(),
        featuredCategoriesidget(),
        Divider(color: AppColors().appGrey, indent: 16, endIndent: 16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 16),
            Expanded(
              child: AppTextButton(
                text: "❔ Looking for something else? Tap here.",
                onPressed: () async {
                  await AppNavService().pushNamed(
                    destination: AppRoutes().supportScreen,
                    arguments: <String, dynamic>{},
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget featuredServicesWidget() {
    return ValueListenableBuilder<PagingState<int, Categories>>(
      valueListenable: controller.pagingControllerServices,
      builder: (
        BuildContext context,
        PagingState<int, Categories> value,
        Widget? child,
      ) {
        return Expanded(
          child: (value.itemList?.isEmpty ?? false)
              ? const SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CommonCategoryTitleBar(
                        title: "🚜 Rental Categories",
                        onTapViewAll: () async {
                          await tabControllerFunction(2);
                        },
                        isViewAllNeeded: true,
                        itemType: Types.services,
                      ),
                    ),
                    Divider(
                      color: AppColors().appGrey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      child: Text(
                        "🌟 Our most popular vehicles categories! 🌟",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: CommonHorizontalGridView(
                        pagingController: controller.pagingControllerServices,
                        onTap: (Categories item) async {
                          final bool isApproved =
                              (item.status ?? "") == "Approved";
                          if (isApproved) {
                            RentalBookingStream().functionSinkAdd(
                              id: item.sId ?? "",
                            );

                            await tabControllerFunction(2);
                          } else {
                            AppSnackbar().snackbarFailure(
                              title: "Oops!",
                              message: "Coming Soon!",
                            );
                          }
                        },
                        needViewAll: false,
                        onTapViewAll: (Categories item) async {},
                        type: "rental services list",
                        itemType: Types.services,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: AppElevatedButton(
                              text: "Book Now",
                              onPressed: () async {
                                await tabControllerFunction(2);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
        );
      },
    );
  }

  Widget featuredCategoriesidget() {
    return ValueListenableBuilder<PagingState<int, Categories>>(
      valueListenable: controller.pagingControllerCategories,
      builder: (
        BuildContext context,
        PagingState<int, Categories> value,
        Widget? child,
      ) {
        return Expanded(
          child: (value.itemList?.isEmpty ?? false)
              ? const SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CommonCategoryTitleBar(
                        title: "🌾 Product Categories",
                        onTapViewAll: () async {
                          await AppNavService().pushNamed(
                            destination: AppRoutes().productListingScreen,
                            arguments: <String, dynamic>{},
                          );
                        },
                        isViewAllNeeded: true,
                        itemType: Types.products,
                      ),
                    ),
                    Divider(
                      color: AppColors().appGrey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      child: Text(
                        "🌟 Our most popular products categories! 🌟",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: CommonHorizontalGridView(
                        pagingController: controller.pagingControllerCategories,
                        onTap: (Categories item) async {
                          await AppNavService().pushNamed(
                            destination: AppRoutes().productListingScreen,
                            arguments: <String, dynamic>{"id": item.sId ?? ""},
                          );
                        },
                        needViewAll: false,
                        onTapViewAll: (Categories item) async {},
                        type: "product categories list",
                        itemType: Types.products,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            width: double.infinity,
                            child: AppElevatedButton(
                              text: "View All",
                              onPressed: () async {
                                await AppNavService().pushNamed(
                                  destination: AppRoutes().productListingScreen,
                                  arguments: <String, dynamic>{},
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
        );
      },
    );
  }
}
