import "dart:async";

import "package:customer/common_functions/order_booking_stream.dart";
import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
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

  final RxList<Categories> rxProductCategoriesList = <Categories>[].obs;

  final RxList<PagingController<int, Products>> rxPagingControllerDynamic =
      <PagingController<int, Products>>[].obs;

  @override
  void onInit() {
    super.onInit();

    pagingControllerServices.addPageRequestListener(_fetchPageServices);
    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);
    pagingControllerBanners.addPageRequestListener(_fetchPageBanners);

    for (int i = 0; i < rxPagingControllerDynamic.length; i++) {
      rxPagingControllerDynamic[i].addPageRequestListener(
        (int pageKey) async {
          await _fetchPageDynamic(
            pageKey,
            rxPagingControllerDynamic[i],
            pagingControllerCategories.itemList?[i].name ?? "",
          );
        },
      );
    }

    unawaited(apiCallCategoriesWithoutPagination());

    OrderBookingStream().subscribe(
      callback: AppNavService().currentRoute == AppRoutes().mainNavigationScreen
          ? apiCallCategoriesWithoutPagination
          : () {},
    );
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

    for (int i = 0; i < rxPagingControllerDynamic.length; i++) {
      rxPagingControllerDynamic[i]
        ..removePageRequestListener(
          (int pageKey) async {
            await _fetchPageDynamic(
              pageKey,
              rxPagingControllerDynamic[i],
              pagingControllerCategories.itemList?[i].name ?? "",
            );
          },
        )
        ..dispose();
    }

    super.onClose();
  }

  void updateProductCategoriesList(List<Categories> value) {
    rxProductCategoriesList(value);
    return;
  }

  void updatePagingControllerDynamic(
    List<PagingController<int, Products>> value,
  ) {
    rxPagingControllerDynamic(value);
    return;
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

  Future<void> apiCallCategoriesWithoutPagination() async {
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "productcategory",
      query: <String, dynamic>{
        "page": 1,
        "limit": 3,
        "status": "Approved",
      },
      successCallback: (Map<String, dynamic> json) async {
        AppLogger().info(message: json["message"]);

        FeaturedModel model = FeaturedModel();
        model = FeaturedModel.fromJson(json);

        rxProductCategoriesList.clear();
        rxPagingControllerDynamic.clear();

        updateProductCategoriesList(model.data?.categories ?? <Categories>[]);
        await initPagingControllerDynamic();

        rxProductCategoriesList.refresh();
        rxPagingControllerDynamic.refresh();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );

    return Future<void>.value();
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

  Future<void> initPagingControllerDynamic() async {
    const Duration debounce = Duration(milliseconds: 400);
    await Future<void>.delayed(debounce);

    for (int i = 0; i < rxProductCategoriesList.length; i++) {
      final PagingController<int, Products> pagingController =
          PagingController<int, Products>(firstPageKey: 1);
      rxPagingControllerDynamic.add(pagingController);
    }

    for (int i = 0; i < rxPagingControllerDynamic.length; i++) {
      final PagingController<int, Products> pagingController =
          rxPagingControllerDynamic[i];
      pagingController.addPageRequestListener(
        (int pageKey) async {
          final String id = rxProductCategoriesList[i].sId ?? "";
          await _fetchPageDynamic(pageKey, pagingController, id);
        },
      );
    }
    return Future<void>.value();
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
