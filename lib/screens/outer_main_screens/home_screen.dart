import "package:customer/common_widgets/common_home_title_bar.dart";
import "package:customer/common_widgets/common_horizontal_list_view.dart";
import "package:customer/common_widgets/common_horizontal_list_view_banner.dart";
import "package:customer/common_widgets/product_list_view.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/utils/app_colors.dart";
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
                        helloWidget(),
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

  Widget helloWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "${AppLanguageKeys().strHello.tr}, ${controller.firstName()}",
            style: const TextStyle(
              fontSize: 16 + 4,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
            title: AppLanguageKeys().strFeaturedServices.tr,
            onTapViewAll: () {},
          ),
        ),
        Divider(
          color: AppColors().appGrey_,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
        CommonHorizontalListView(
          pagingController: controller.pagingControllerServices,
          onTap: (Categories item) async {
          },
        ),
      ],
    );
  }

  Widget weatherForecastWidget() {
    // Dummy data for the weather forecast
    final List<Map<String, String>> weatherData = [
      {'day': 'SAT', 'icon': '☀️', 'temp': '29°C'},
      {'day': 'SUN', 'icon': '🌧️', 'temp': '29°C'},
      {'day': 'MON', 'icon': '🌦️', 'temp': '29°C'},
      {'day': 'TUE', 'icon': '⛅', 'temp': '29°C'},
      {'day': 'WED', 'icon': '🌧️', 'temp': '29°C'},
      {'day': 'THU', 'icon': '⛅', 'temp': '29°C'},
      {'day': 'FRI', 'icon': '☀️', 'temp': '29°C'},
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
          children: weatherData.map((weather) {
            return Column(
              children: <Widget>[
                Text(
                  weather['day']!,
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
                      weather['icon']!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  weather['temp']!,
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
        Divider(
          color: AppColors().appGrey_,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
        CommonHorizontalListView(
          pagingController: controller.pagingControllerCategories,
          onTap: (Categories item) async {
          },
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
            onTapViewAll: () {},
          ),
        ),
        Divider(
          color: AppColors().appGrey_,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
        ProductListView(
          pagingController: controller.pagingControllerRecently,
          onTap: (Products item) async {

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
        Divider(
          color: AppColors().appGrey_,
          indent: 16,
          endIndent: 16,
        ),
        const SizedBox(height: 8),
        ProductListView(
          pagingController: controller.pagingControllerRecently,
          onTap: (Products item) async {

          },
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
