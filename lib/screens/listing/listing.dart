import "package:customer/common_widgets/common_horizontal_list_view_banner.dart";
import "package:customer/common_widgets/list_card.dart";
import "package:customer/controllers/listing_controllers/listing_controllers.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/models/list_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";

class ListingScreen extends GetView<ListingScreenController>  {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listing"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            searchBarWidget(),
            chipFilterRow(),
            banners(),
            productCards(),
          ],
        ),
      ),
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
          fillColor:AppColors().appWhiteColor,
        ),
      ),
    );
  }

  Widget chipFilterRow() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            FilterChip(
              label: const Text('2'),
              onSelected: (_) {},
              selectedColor: AppColors().appPrimaryColor,
              backgroundColor: AppColors().appPrimaryColor,
              labelStyle:  TextStyle(color: AppColors().appWhiteColor,),
              avatar: Icon(Icons.filter_list, color: AppColors().appWhiteColor,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side:  BorderSide(color: AppColors().appTransparentColor,),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('On Sale'),
              onSelected: (_) {},
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side:  BorderSide(color: AppColors().appTransparentColor,),
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: Text('Price'),
              onSelected: (_) {},
              avatar:  Icon(Icons.arrow_drop_down,
                color: AppColors().appWhiteColor,),
              selectedColor: AppColors().appPrimaryColor,
              backgroundColor:AppColors().appPrimaryColor,
              labelStyle:  TextStyle(color: AppColors().appWhiteColor,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: AppColors().appTransparentColor,),
            ),
            SizedBox(width: 8),
            FilterChip(
              label: Text('Sort by'),
              onSelected: (_) {},
              avatar: Icon(Icons.arrow_drop_down),
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: AppColors().appTransparentColor,),
            ),
            SizedBox(width: 8),
            FilterChip(
              label: Text('Brand'),
              onSelected: (_) {},
              selectedColor: AppColors().appPrimaryColor,
              backgroundColor: AppColors().appPrimaryColor,
              labelStyle: TextStyle(color: AppColors().appWhiteColor,),
              avatar: Icon(Icons.arrow_drop_down, color: AppColors().appWhiteColor,),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: AppColors().appTransparentColor,),
            ),
          ],
        ),
      ),
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


  Widget productCards() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListCardView(
          pagingController: controller.pagingControllerProducts,
          onTap: (Lists item) async {
          },
        ),
      ],
    );
  }

}
