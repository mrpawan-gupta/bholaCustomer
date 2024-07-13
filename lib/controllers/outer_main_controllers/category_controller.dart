import "dart:async";

import "package:customer/models/featured_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CategoryController extends GetxController {
  final int pageSize = 3;

  final PagingController<int, Categories> pagingControllerServices =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, Categories> pagingControllerCategories =
      PagingController<int, Categories>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();

    pagingControllerServices.addPageRequestListener(_fetchPageServices);
    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);
  }

  @override
  void onClose() {
    pagingControllerServices
      ..removePageRequestListener(_fetchPageServices)
      ..dispose();

    pagingControllerCategories
      ..removePageRequestListener(_fetchPageCategories)
      ..dispose();

    super.onClose();
  }

  Future<void> _fetchPageServices(int pageKey) async {
    try {
      final List<Categories> newItems = await _apiCallServices(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerServices.appendLastPage(newItems)
          : pagingControllerServices.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerServices.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<void> _fetchPageCategories(int pageKey) async {
    try {
      final List<Categories> newItems = await _apiCallCategories(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerCategories.appendLastPage(newItems)
          : pagingControllerCategories.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerCategories.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Categories>> _apiCallServices(int pageKey) async {
    final Completer<List<Categories>> completer = Completer<List<Categories>>();
    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "vehiclecategory",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "status": "Approved",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        FeaturedModel model = FeaturedModel();
        model = FeaturedModel.fromJson(json);

        completer.complete(model.data?.categories ?? <Categories>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Categories>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }

  Future<List<Categories>> _apiCallCategories(int pageKey) async {
    final Completer<List<Categories>> completer = Completer<List<Categories>>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "productcategory",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "status": "Approved",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        FeaturedModel model = FeaturedModel();
        model = FeaturedModel.fromJson(json);

        completer.complete(model.data?.categories ?? <Categories>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Categories>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }
}
