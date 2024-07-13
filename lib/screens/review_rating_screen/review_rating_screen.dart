import "package:customer/controllers/review_rating_controller/review_rating_controller.dart";
import "package:customer/models/review_rating_model.dart";
import "package:customer/screens/review_rating_screen/my_utils/common_list_view.dart";
import "package:customer/utils/app_colors.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class ReviewRatingScreen extends GetView<ReviewRatingController> {
  const ReviewRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Review Rating"),
        surfaceTintColor: AppColors().appTransparentColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: reviewsWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewsWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonListView(
          pagingController: controller.pagingControllerReviews,
          onTap: (Reviews item) {},
          onPressedEdit: (Reviews item) async {},
          onPressedDelete: (Reviews item) async {},
          type: "reviews list",
          needMoreOptionsButton: false,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
