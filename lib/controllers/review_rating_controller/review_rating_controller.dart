// ignore_for_file: lines_longer_than_80_chars

import "dart:async";

import "package:customer/models/generic_product_details_model.dart";
import "package:customer/utils/app_logger.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class ReviewRatingController extends GetxController {
  final int pageSize = 10;

  final RxString rxProductId = "".obs;

  final PagingController<int, Reviews> pagingControllerReviews =
      PagingController<int, Reviews>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateProductId(arguments["id"]);
      } else {}
    } else {}

    pagingControllerReviews.addPageRequestListener(_fetchPageReviews);
  }

  @override
  void onClose() {
    pagingControllerReviews
      ..removePageRequestListener(_fetchPageReviews)
      ..dispose();

    super.onClose();
  }

  void updateProductId(String value) {
    rxProductId(value);
    return;
  }

  Future<void> _fetchPageReviews(int pageKey) async {
    try {
      final List<Reviews> newItems = await _apiCallReviews(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerReviews.appendLastPage(newItems)
          : pagingControllerReviews.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerReviews.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Reviews>> _apiCallReviews(int pageKey) async {
    final Completer<List<Reviews>> completer = Completer<List<Reviews>>();

    final List<Reviews> tempList = <Reviews>[];
    if (pageKey == 1) {
      tempList.addAll(
        <Reviews>[
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
          Reviews(
            customerProfilePhoto:
                "https://randomuser.me/api/portraits/thumb/men/75.jpg",
            customerFirstName: "Dharam",
            customerLastName: "Budh",
            date: DateTime.now().toString(),
            star: 1,
            review:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          ),
        ],
      );
    } else {}

    completer.complete(tempList);

    return completer.future;
  }
}
