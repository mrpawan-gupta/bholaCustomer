import "dart:async";

import "package:customer/models/review_rating_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
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

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
      "sortBy": "createdAt",
      "sortOrder": "desc",
    };

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product/${rxProductId.value}/reviews",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        ReviewRatingModel model = ReviewRatingModel();
        model = ReviewRatingModel.fromJson(json);

        completer.complete(model.data?.reviews ?? <Reviews>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Reviews>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }
}
