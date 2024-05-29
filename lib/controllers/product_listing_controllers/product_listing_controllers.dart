import "dart:async";
import "package:customer/models/banner_model.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/product_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get_rx/src/rx_types/rx_types.dart";
import "package:get/get_state_manager/src/simple/get_controllers.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

double defaultMinRange = 0.0;
double defaultMaxRange = 10000.0;

class ProductListingScreenController extends GetxController {
  final int pageSize = 3;

  final PagingController<int, Banners> pagingControllerBanners =
      PagingController<int, Banners>(firstPageKey: 1);

  final PagingController<int, Products> pagingControllerRecently =
      PagingController<int, Products>(firstPageKey: 1);

  final TextEditingController searchController = TextEditingController();
  final RxString rxSearchQuery = "".obs;

  final RxDouble rxFilterMinRange = defaultMinRange.obs;
  final RxDouble rxFilterMaxRange = defaultMaxRange.obs;
  final RxString rxFilterSelectedSortBy = "".obs;
  final Rx<Categories> rxFilterSelectedCategory = Categories().obs;

  final RxList<String> defaultSortBy = <String>[
    "Popularity",
    "Price - Low to High",
    "Price - High to Low",
    "Newest First",
  ].obs;
  final RxList<Categories> categoriesList = <Categories>[].obs;

  @override
  void onInit() {
    super.onInit();

    pagingControllerBanners.addPageRequestListener(_fetchPageBanners);
    pagingControllerRecently.addPageRequestListener(_fetchPageRecently);

    unawaited(getCategoriesAPI());
  }

  @override
  void onClose() {
    pagingControllerBanners
      ..removePageRequestListener(_fetchPageBanners)
      ..dispose();

    pagingControllerRecently
      ..removePageRequestListener(_fetchPageRecently)
      ..dispose();

    super.onClose();
  }

  void updateSearchQuery(String value) {
    rxSearchQuery(value);
    return;
  }

  void updateFilterMinRange(double value) {
    rxFilterMinRange(value);
    return;
  }

  void updateFilterMaxRange(double value) {
    rxFilterMaxRange(value);
    return;
  }

  void updateFilterSelectedSortBy(String value) {
    rxFilterSelectedSortBy(value);
    return;
  }

  void updateFilterSelectedCategory(Categories value) {
    rxFilterSelectedCategory(value);
    return;
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

  Future<void> _fetchPageRecently(int pageKey) async {
    try {
      final List<Products> newItems = await _apiCallRecently(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerRecently.appendLastPage(newItems)
          : pagingControllerRecently.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerRecently.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Banners>> _apiCallBanners(int pageKey) async {
    final Completer<List<Banners>> completer = Completer<List<Banners>>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "banners",
      query: <String, dynamic>{
        "page": pageKey,
        "limit": pageSize,
        "appType": "Customer",
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

  Future<List<Products>> _apiCallRecently(int pageKey) async {
    final Completer<List<Products>> completer = Completer<List<Products>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
    };

    if (rxSearchQuery.isNotEmpty) {
      query.addAll(
        <String, dynamic>{"search": rxSearchQuery.value},
      );
    } else {}

    if (filterIsPriceApplied().value) {
      query.addAll(
        <String, dynamic>{
          "minPrice": rxFilterMinRange.value.toInt(),
          "maxPrice": rxFilterMaxRange.value.toInt(),
        },
      );
    } else {}

    if (filterIsSortByApplied().value) {
      if (rxFilterSelectedSortBy.value == defaultSortBy[0]) {
        query.addAll(
          <String, dynamic>{"sortBy": "cumulativeRating", "sortOrder": "desc"},
        );
      } else {}
      if (rxFilterSelectedSortBy.value == defaultSortBy[1]) {
        query.addAll(
          <String, dynamic>{"sortBy": "price", "sortOrder": "asc"},
        );
      } else {}
      if (rxFilterSelectedSortBy.value == defaultSortBy[2]) {
        query.addAll(
          <String, dynamic>{"sortBy": "price", "sortOrder": "desc"},
        );
      } else {}
      if (rxFilterSelectedSortBy.value == defaultSortBy[3]) {
        query.addAll(
          <String, dynamic>{"sortBy": "createdAt", "sortOrder": "desc"},
        );
      } else {}
    } else {}

    if (filterIsCategoryApplied().value) {
      query.addAll(
        <String, dynamic>{
          "categoryId": rxFilterSelectedCategory.value.sId ?? "",
          "categoryName": rxFilterSelectedCategory.value.name ?? "",
        },
      );
    } else {}

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product",
      query: query,
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

  Future<void> getCategoriesAPI() async {
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "category",
      query: <String, dynamic>{
        "page": 1,
        "limit": 1000,
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        FeaturedModel model = FeaturedModel();
        model = FeaturedModel.fromJson(json);

        categoriesList
          ..clear()
          ..addAll(model.data?.categories ?? <Categories>[])
          ..refresh();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );
    return Future<void>.value();
  }

  RxBool filterIsPriceApplied() {
    final bool condition1 = rxFilterMinRange.value != defaultMinRange;
    final bool condition2 = rxFilterMaxRange.value != defaultMaxRange;

    return (condition1 || condition2).obs;
  }

  RxBool filterIsSortByApplied() {
    final bool condition1 = rxFilterSelectedSortBy.value.isNotEmpty;

    return condition1.obs;
  }

  RxBool filterIsCategoryApplied() {
    final bool condition1 = !mapEquals(
      rxFilterSelectedCategory.value.toJson(),
      Categories().toJson(),
    );

    return condition1.obs;
  }

  RxInt filterCount() {
    final List<bool> tempList = <bool>[
      filterIsPriceApplied().value,
      filterIsSortByApplied().value,
      filterIsCategoryApplied().value,
    ];

    final int count = tempList.where((bool e) => e == true).toList().length;

    return count.obs;
  }

  RxMap<int, String> filterList() {
    final Map<int, String> tempList = <int, String>{};

    if (filterIsPriceApplied().value) {
      tempList.addAll(
        <int, String>{
          0: "${rxFilterMinRange.value} - ${rxFilterMaxRange.value}",
        },
      );
    }
    if (filterIsSortByApplied().value) {
      tempList.addAll(
        <int, String>{
          1: rxFilterSelectedSortBy.value,
        },
      );
    }
    if (filterIsCategoryApplied().value) {
      tempList.addAll(
        <int, String>{
          2: rxFilterSelectedCategory.value.name ?? "",
        },
      );
    }

    return tempList.obs;
  }

  void onDeleteFilter(int key) {
    switch (key) {
      case 0:
        updateFilterMinRange(defaultMinRange);
        updateFilterMaxRange(defaultMaxRange);
        break;
      case 1:
        updateFilterSelectedSortBy("");
        break;
      case 2:
        updateFilterSelectedCategory(Categories());
        break;
      default:
        break;
    }

    return;
  }
}
