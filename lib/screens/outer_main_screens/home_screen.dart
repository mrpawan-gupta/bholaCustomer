import "package:customer/common_widgets/common_home_title_bar.dart";
import "package:customer/common_widgets/common_horizontal_list_view.dart";
import "package:customer/common_widgets/common_horizontal_list_view_banner.dart";
import "package:customer/common_widgets/product_list_view.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_colors.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/localization/app_language_keys.dart";
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
                    ..pagingControllerRecently.refresh()
                    ..pagingControllerBooking.refresh();
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
                        searchBarWidget(),
                        const SizedBox(height: 16),
                        featuredServicesWidget(),
                        const SizedBox(height: 16),
                        weatherForecastWidget(),
                        const SizedBox(height: 32),
                        featuredCategoriesidget(),
                        const SizedBox(height: 32),
                        banners(),
                        const SizedBox(height: 32),
                        cattleFeedWidget(),
                        const SizedBox(height: 32),
                        fertilizerWidget(),
                        const SizedBox(height: 42),
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

  Widget searchBarWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintText: "Search here...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.grey[700]!,
              width: 1.5,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
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
            title: AppLanguageKeys().strFeaturedServices.tr,
            onTapViewAll: () {},
          ),
        ),
        const SizedBox(height: 8),
        CommonHorizontalListView(
          pagingController: controller.pagingControllerServices,
          onTap: (Categories item) async {},
        ),
      ],
    );
  }

  Widget weatherForecastWidget() {
    // Dummy data for the weather forecast
    final List<Map<String, String>> weatherData = <Map<String, String>>[
      <String, String>{"day": "SUN", "icon": "🌧️", "temp": "29°C"},
      <String, String>{"day": "MON", "icon": "🌦️", "temp": "29°C"},
      <String, String>{"day": "TUE", "icon": "⛅", "temp": "29°C"},
      <String, String>{"day": "WED", "icon": "🌧️", "temp": "29°C"},
      <String, String>{"day": "THU", "icon": "⛅", "temp": "29°C"},
      <String, String>{"day": "FRI", "icon": "☀️", "temp": "29°C"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade700,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weatherData.map((Map<String, String> weather) {
            return Column(
              children: <Widget>[
                Text(
                  weather["day"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green.shade700,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Text(
                      weather["icon"]!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weather["temp"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget featuredCategoriesidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CommonHomeTitleBar(
            title: AppLanguageKeys().strProduct.tr,
            onTapViewAll: () {},
          ),
        ),
        const SizedBox(height: 8),
        CommonHorizontalListView(
          pagingController: controller.pagingControllerCategories,
          onTap: (Categories item) async {},
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
            title: AppLanguageKeys().strCattleFeed.tr,
            onTapViewAll: () async{
              // await AppNavService().pushNamed(
              //   destination: AppRoutes().productDetailScreen,
              //   arguments: <String, dynamic>{"id": item.sId ?? ""},
              // );
            },
          ),
        ),
        const SizedBox(height: 8),
        ProductListView(
          pagingController: controller.pagingControllerRecently,
          onTap: (Products item) async {
            await AppNavService().pushNamed(
              destination: AppRoutes().productDetailScreen,
              arguments: <String, dynamic>{},
            );
          },
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
            title: AppLanguageKeys().strFertilizer.tr,
            onTapViewAll: () {},
          ),
        ),
        const SizedBox(height: 8),
        ProductListView(
          pagingController: controller.pagingControllerRecently,
          onTap: (Products item) async {},
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
        ),
      ],
    );
  }
}
