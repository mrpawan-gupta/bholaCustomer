import "dart:async";

import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class HomeController extends GetxController {
  final int pageSize = 3;

  final PagingController<int, Categories> pagingControllerServices =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, Categories> pagingControllerCategories =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, Banners> pagingControllerBanners =
      PagingController<int, Banners>(firstPageKey: 1);

  final PagingController<int, Products> pagingControllerCattleFeed =
      PagingController<int, Products>(firstPageKey: 1);

  final PagingController<int, Products> pagingControllerFertilizer =
      PagingController<int, Products>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();

    pagingControllerServices.addPageRequestListener(_fetchPageServices);
    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);
    pagingControllerBanners.addPageRequestListener(_fetchPageBanners);
    pagingControllerCattleFeed.addPageRequestListener(_fetchPageCattleFeed);
    pagingControllerFertilizer.addPageRequestListener(_fetchPageFertilizer);
  }

  @override
  void onClose() {
    pagingControllerServices
      ..removePageRequestListener(_fetchPageServices)
      ..dispose();

    pagingControllerCategories
      ..removePageRequestListener(_fetchPageCategories)
      ..dispose();

    pagingControllerBanners
      ..removePageRequestListener(_fetchPageBanners)
      ..dispose();

    pagingControllerCattleFeed
      ..removePageRequestListener(_fetchPageCattleFeed)
      ..dispose();

    pagingControllerFertilizer
      ..removePageRequestListener(_fetchPageFertilizer)
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

  Future<void> _fetchPageBanners(int pageKey) async {
    try {
      final List<Banners> newItems = await _apiCallBanners(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerBanners.appendLastPage(newItems)
          : pagingControllerBanners.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerBanners.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<void> _fetchPageCattleFeed(int pageKey) async {
    try {
      final List<Products> newItems = await _apiCallCattleFeed(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerCattleFeed.appendLastPage(newItems)
          : pagingControllerCattleFeed.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerCattleFeed.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<void> _fetchPageFertilizer(int pageKey) async {
    try {
      final List<Products> newItems = await _apiCallFertilizer(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerFertilizer.appendLastPage(newItems)
          : pagingControllerFertilizer.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerFertilizer.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Categories>> _apiCallServices(int pageKey) async {
    final Completer<List<Categories>> completer = Completer<List<Categories>>();
    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "vehicleCategories",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
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
      endPoint: "category",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
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

  Future<List<Banners>> _apiCallBanners(int pageKey) async {
    final Completer<List<Banners>> completer = Completer<List<Banners>>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "banners",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "appType": "Vendor",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        BannerModel model = BannerModel();
        model = BannerModel.fromJson(json);

        completer.complete(model.data?.banners ?? <Banners>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Banners>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }

  Future<List<Products>> _apiCallCattleFeed(int pageKey) async {
    final Completer<List<Products>> completer = Completer<List<Products>>();

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "sortBy": "createdAt",
        "sortOrder": "desc",
        "categoryName": "Cattle Feed",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        ProductModel model = ProductModel();
        model = ProductModel.fromJson(json);

        completer.complete(model.data?.products ?? <Products>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Products>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }

  Future<List<Products>> _apiCallFertilizer(int pageKey) async {
    final Completer<List<Products>> completer = Completer<List<Products>>();

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "sortBy": "createdAt",
        "sortOrder": "desc",
        "categoryName": "Fertilizer",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        ProductModel model = ProductModel();
        model = ProductModel.fromJson(json);

        completer.complete(model.data?.products ?? <Products>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Products>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }
}
