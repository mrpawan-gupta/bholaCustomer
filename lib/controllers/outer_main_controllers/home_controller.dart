import "dart:async";

import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class HomeController extends GetxController {
  final int pageSize = 3;

  final PagingController<int, Categories> pagingControllerServices =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, Categories> pagingControllerCategories =
      PagingController<int, Categories>(firstPageKey: 1);

  ValueNotifier<PagingState<int, Categories>> valueNotifierCategories =
      ValueNotifier<PagingState<int, Categories>>(
    const PagingState<int, Categories>(),
  );

  final PagingController<int, Banners> pagingControllerBanners =
      PagingController<int, Banners>(firstPageKey: 1);

  final List<PagingController<int, Products>> pagingControllerDynamic =
      <PagingController<int, Products>>[];

  @override
  void onInit() {
    super.onInit();

    pagingControllerServices.addPageRequestListener(_fetchPageServices);
    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);
    pagingControllerBanners.addPageRequestListener(_fetchPageBanners);

    for (int i = 0; i < pagingControllerDynamic.length; i++) {
      pagingControllerDynamic[i].addPageRequestListener(
        (int pageKey) async {
          await _fetchPageDynamic(
            pageKey,
            pagingControllerDynamic[i],
            pagingControllerCategories.itemList?[i].name ?? "",
          );
        },
      );
    }
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

    for (int i = 0; i < pagingControllerDynamic.length; i++) {
      pagingControllerDynamic[i]
        ..removePageRequestListener(
          (int pageKey) async {
            await _fetchPageDynamic(
              pageKey,
              pagingControllerDynamic[i],
              pagingControllerCategories.itemList?[i].name ?? "",
            );
          },
        )
        ..dispose();
    }

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
      valueNotifierCategories.value = pagingControllerCategories.value;

      List<Categories> categoriesList = <Categories>[];
      categoriesList = pagingControllerCategories.itemList ?? <Categories>[];
      await initPagingControllerDynamic(categoriesList);
      valueNotifierCategories.value = pagingControllerCategories.value;
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerCategories.error = error;
      valueNotifierCategories.value = pagingControllerCategories.value;
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

  Future<List<Banners>> _apiCallBanners(int pageKey) async {
    final Completer<List<Banners>> completer = Completer<List<Banners>>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "banner",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "appType": "Customer",
        "isActive": true,
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

  Future<void> initPagingControllerDynamic(List<Categories> categories) async {
    final Completer<void> completer = Completer<void>();

    if (pagingControllerDynamic.isNotEmpty) {
      pagingControllerDynamic.clear();
      const Duration debounce = Duration(milliseconds: 400);
      await Future<void>.delayed(debounce);
    } else {}

    for (int i = 0; i < categories.length; i++) {
      final PagingController<int, Products> pagingController =
          PagingController<int, Products>(firstPageKey: 1);
      pagingControllerDynamic.add(pagingController);
    }

    for (int i = 0; i < pagingControllerDynamic.length; i++) {
      final PagingController<int, Products> pagingController =
          pagingControllerDynamic[i];
      pagingController.addPageRequestListener(
        (int pageKey) async {
          await _fetchPageDynamic(
            pageKey,
            pagingController,
            categories[i].sId ?? "",
          );
        },
      );
    }

    completer.complete();

    return completer.future;
  }

  Future<void> _fetchPageDynamic(
    int pageKey,
    PagingController<int, Products> pagingController,
    String categoryId,
  ) async {
    try {
      final List<Products> newItems = await _apiCallDynamic(
        pageKey,
        categoryId,
      );
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingController.appendLastPage(newItems)
          : pagingController.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingController.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Products>> _apiCallDynamic(
    int pageKey,
    String categoryId,
  ) async {
    final Completer<List<Products>> completer = Completer<List<Products>>();

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "sortBy": "createdAt",
        "sortOrder": "desc",
        "categoryId": categoryId,
        "status": "Approved",
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
