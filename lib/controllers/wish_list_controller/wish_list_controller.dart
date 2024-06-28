import "dart:async";

import "package:customer/models/featured_model.dart";
import "package:customer/models/wish_list_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class WishListController extends GetxController {
  final int pageSize = 10;

  final PagingController<int, Categories> pagingControllerCategories =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, WishListItems> pagingControllerWishList =
      PagingController<int, WishListItems>(firstPageKey: 1);

  final Rx<Categories> rxSelectedCategory = Categories().obs;

  @override
  void onInit() {
    super.onInit();

    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);
    pagingControllerWishList.addPageRequestListener(_fetchPageWishList);
  }

  @override
  void onClose() {
    pagingControllerCategories
      ..removePageRequestListener(_fetchPageCategories)
      ..dispose();

    pagingControllerWishList
      ..removePageRequestListener(_fetchPageWishList)
      ..dispose();

    super.onClose();
  }

  void updateSelectedCategory(Categories value) {
    rxSelectedCategory(value);
    return;
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

  Future<void> _fetchPageWishList(int pageKey) async {
    try {
      final List<WishListItems> newItems = await _apiCallWishList(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerWishList.appendLastPage(newItems)
          : pagingControllerWishList.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerWishList.error = error;
    } finally {}
    return Future<void>.value();
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

  Future<List<WishListItems>> _apiCallWishList(int pageKey) async {
    final Completer<List<WishListItems>> completer =
        Completer<List<WishListItems>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
    };

    final String id = rxSelectedCategory.value.sId ?? "";
    if (id.isEmpty) {
    } else {
      query.addAll(<String, dynamic>{"categoryId": id});
    }

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "wishlist",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        WishListModel model = WishListModel();
        model = WishListModel.fromJson(json);

        completer.complete(model.data?.items ?? <WishListItems>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<WishListItems>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }

  Future<bool> addToCartAPICall({required String id}) async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionPost(
      types: Types.order,
      endPoint: "cart",
      body: <String, dynamic>{"productId": id, "quantity": "1"},
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<bool> deleteProductAPICall({required String id}) async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionDelete(
      types: Types.order,
      endPoint: "wishlist/$id",
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }
}
