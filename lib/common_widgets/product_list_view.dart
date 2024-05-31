import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/product_model.dart";
import "package:flutter/material.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class ProductListView extends StatelessWidget {
  const ProductListView({
    required this.pagingController,
    required this.onTap,
    required this.type,
    super.key,
  });

  final PagingController<int, Products> pagingController;
  final Function(Products item) onTap;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: PagedListView<int, Products>(
        shrinkWrap: true,
        pagingController: pagingController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        builderDelegate: PagedChildBuilderDelegate<Products>(
          noItemsFoundIndicatorBuilder: (BuildContext context) {
            return AppNoItemFoundWidget(
              title: "No items found",
              message: "The $type is currently empty.",
              onTryAgain: pagingController.refresh,
            );
          },
          itemBuilder: (BuildContext context, Products item, int i) {
            final int length = pagingController.itemList?.length ?? 0;
            final bool isLast = i == length - 1;
            return Padding(
              padding: EdgeInsets.only(right: isLast ? 0.0 : 16.0),
              child: SizedBox(
                height: 250,
                width: 150,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () async {
                      onTap(item);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: CommonImageWidget(
                            imageUrl: item.photo ?? "",
                            fit: BoxFit.cover,
                            imageType: ImageType.image,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: cardDetails(item),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget cardDetails(Products item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.name ?? "",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "\$${item.price}",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
