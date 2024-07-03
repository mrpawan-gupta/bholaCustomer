import "package:customer/common_functions/date_time_functions.dart";
import "package:customer/common_widgets/app_no_item_found.dart";
import "package:customer/common_widgets/common_image_widget.dart";
import "package:customer/models/review_rating_model.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:read_more_text/read_more_text.dart";

class CommonListView extends StatelessWidget {
  const CommonListView({
    required this.pagingController,
    super.key,
  });

  final PagingController<int, Reviews> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Reviews>.separated(
      shrinkWrap: true,
      pagingController: pagingController,
      physics: const ScrollPhysics(),
      padding: EdgeInsets.zero,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(indent: 16, endIndent: 16);
      },
      builderDelegate: PagedChildBuilderDelegate<Reviews>(
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return AppNoItemFoundWidget(
            title: "No items found",
            message: "The review rating list is currently empty.",
            onTryAgain: pagingController.refresh,
          );
        },
        itemBuilder: (BuildContext context, Reviews item, int index) {
          return reviewsListAdapter(item: item);
        },
      ),
    );
  }
}

Widget reviewsListAdapter({required Reviews item}) {
  final String customerFirstName = item.customerFirstName ?? "";
  final String customerLastName = item.customerLastName ?? "";

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        leading: SizedBox(
          height: 32,
          width: 32,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CommonImageWidget(
              imageUrl: item.customerProfilePhoto ?? "",
              fit: BoxFit.cover,
              imageType: ImageType.user,
            ),
          ),
        ),
        title: Text(
          "$customerFirstName $customerLastName",
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: <Widget>[
            RatingBar.builder(
              ignoreGestures: true,
              allowHalfRating: true,
              initialRating: (item.star ?? 0.0).toDouble(),
              itemSize: 16,
              unratedColor: AppColors().appGrey,
              itemBuilder: (BuildContext context, int index) {
                return Icon(Icons.star, color: AppColors().appOrangeColor);
              },
              onRatingUpdate: (double value) {},
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                formattedDateTime(dateTimeString: item.date ?? ""),
                style: TextStyle(fontSize: 12, color: AppColors().appGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ReadMoreText(
          item.review ?? "",
          numLines: 2,
          readMoreText: "Read more",
          readLessText: "Read less",
          readMoreAlign: Alignment.bottomLeft,
          readMoreIconColor: AppColors().appPrimaryColor,
          readMoreTextStyle: TextStyle(color: AppColors().appPrimaryColor),
        ),
      ),
    ],
  );
}
