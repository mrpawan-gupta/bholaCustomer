import "dart:ui";

import "package:customer/common_widgets/common_horizontal_list_view_banner.dart";
import "package:customer/controllers/listing_controllers/listing_controllers.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/simple/get_view.dart";

class ListingScreen extends GetView<ListingScreenController>  {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listing"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchBarWidget(),
            chipFilterRow(),
            banners(),
            productGrid(),
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
          fillColor: Colors.white,
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
          children: [
            FilterChip(
              label: Text('2'),
              onSelected: (_) {},
              selectedColor: Colors.green,
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
              avatar: Icon(Icons.filter_list, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: Colors.transparent),
            ),
            SizedBox(width: 8),
            FilterChip(
              label: Text('On Sale'),
              onSelected: (_) {},
              backgroundColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: Colors.transparent),
            ),
            SizedBox(width: 8),
            FilterChip(
              label: Text('Price'),
              onSelected: (_) {},
              avatar: Icon(Icons.arrow_drop_down, color: Colors.white),
              selectedColor: Colors.green,
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: Colors.transparent),
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
              side: BorderSide(color: Colors.transparent),
            ),
            SizedBox(width: 8),
            FilterChip(
              label: Text('Brand'),
              onSelected: (_) {},
              selectedColor: Colors.green,
              backgroundColor: Colors.green,
              labelStyle: TextStyle(color: Colors.white),
              avatar: Icon(Icons.arrow_drop_down, color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              side: BorderSide(color: Colors.transparent),
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

  Widget productGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return productCard();
      },
    );
  }

  Widget productCard() {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              AppAssetsImages.product,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Amul Cattle feed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lorem ipsum dolor sit amet consectetur',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$16,00',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '\$20,00',
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}