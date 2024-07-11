import "dart:async";

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/models/featured_model.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class OrderHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxList<DashboardClass> items = <DashboardClass>[
    DashboardClass(
      name: "Rentals",
      iconData: Icons.agriculture,
    ),
    DashboardClass(
      name: "Products",
      iconData: Icons.shopping_bag,
    ),
  ].obs;

  late TabController tabController;

  RxInt rxCurrentIndex = 0.obs;

  final int pageSize = 10;

  final PagingController<int, Categories> pagingControllerServices =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, Categories> pagingControllerCategories =
      PagingController<int, Categories>(firstPageKey: 1);

  final PagingController<int, Bookings> pagingControllerServicesHistory =
      PagingController<int, Bookings>(firstPageKey: 1);

  final PagingController<int, Bookings> pagingControllerCategoriesHistory =
      PagingController<int, Bookings>(firstPageKey: 1);

  final Rx<Categories> rxSelectedServices = Categories().obs;

  final Rx<Categories> rxSelectedCategory = Categories().obs;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(vsync: this, length: 2);

    tabController.addListener(onTabChange);

    pagingControllerServices.addPageRequestListener(_fetchPageServices);

    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);

    pagingControllerServicesHistory
        .addPageRequestListener(_fetchPageServicesHistory);

    pagingControllerCategoriesHistory
        .addPageRequestListener(_fetchPageCategoriesHistory);
  }

  @override
  void onClose() {
    pagingControllerServices
      ..removePageRequestListener(_fetchPageServices)
      ..dispose();

    pagingControllerCategories
      ..removePageRequestListener(_fetchPageCategories)
      ..dispose();

    pagingControllerServicesHistory
      ..removePageRequestListener(_fetchPageServicesHistory)
      ..dispose();

    pagingControllerCategoriesHistory
      ..removePageRequestListener(_fetchPageCategoriesHistory)
      ..dispose();

    tabController
      ..removeListener(onTabChange)
      ..dispose();

    super.onClose();
  }

  void updateCurrentIndex(int value) {
    rxCurrentIndex(value);
    return;
  }

  void onTabChange() {
    updateCurrentIndex(tabController.index);

    tabController.index == 0
        ? pagingControllerServicesHistory.refresh()
        : pagingControllerCategoriesHistory.refresh();

    return;
  }

  void updateSelectedServices(Categories value) {
    rxSelectedServices(value);
    return;
  }

  void updateSelectedCategory(Categories value) {
    rxSelectedCategory(value);
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

  Future<void> _fetchPageServicesHistory(int pageKey) async {
    try {
      final List<Bookings> newItems = await _apiCallServicesHistory(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerServicesHistory.appendLastPage(newItems)
          : pagingControllerServicesHistory.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerServicesHistory.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<void> _fetchPageCategoriesHistory(int pageKey) async {
    try {
      final List<Bookings> newItems = await _apiCallCategoriesHistory(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerCategoriesHistory.appendLastPage(newItems)
          : pagingControllerCategoriesHistory.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerCategoriesHistory.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Categories>> _apiCallServices(int pageKey) async {
    final Completer<List<Categories>> completer = Completer<List<Categories>>();

    if (pageKey > 1) {
      completer.complete(<Categories>[]);
    } else {
      await AppAPIService().functionGet(
        types: Types.rental,
        endPoint: "vehiclecategory",
        query: <String, dynamic>{
          "page": 1,
          "limit": 1000,
          "status": "Approved",
        },
        successCallback: (Map<String, dynamic> json) {
          AppLogger().info(message: json["message"]);

          FeaturedModel model = FeaturedModel();
          model = FeaturedModel.fromJson(json);

          final (bool, Categories) result = checkAndGetCategoryObject(
            list: pagingControllerServices.itemList ?? <Categories>[],
          );
          final bool hasAlreadyAdded = result.$1;
          final Categories allCategory = result.$2;

          if (hasAlreadyAdded) {
          } else {
            model.data?.categories?.insert(0, allCategory);
            updateSelectedServices(allCategory);
          }

          completer.complete(model.data?.categories ?? <Categories>[]);
        },
        failureCallback: (Map<String, dynamic> json) {
          AppSnackbar()
              .snackbarFailure(title: "Oops", message: json["message"]);

          completer.complete(<Categories>[]);
        },
        needLoader: false,
      );
    }

    return completer.future;
  }

  Future<List<Categories>> _apiCallCategories(int pageKey) async {
    final Completer<List<Categories>> completer = Completer<List<Categories>>();
    if (pageKey > 1) {
      completer.complete(<Categories>[]);
    } else {
      await AppAPIService().functionGet(
        types: Types.rental,
        endPoint: "vehiclecategory",
        query: <String, dynamic>{
          "page": 1,
          "limit": 1000,
          "status": "Approved",
        },
        successCallback: (Map<String, dynamic> json) {
          AppLogger().info(message: json["message"]);

          FeaturedModel model = FeaturedModel();
          model = FeaturedModel.fromJson(json);

          final (bool, Categories) result = checkAndGetCategoryObject(
            list: pagingControllerCategories.itemList ?? <Categories>[],
          );
          final bool hasAlreadyAdded = result.$1;
          final Categories allCategory = result.$2;

          if (hasAlreadyAdded) {
          } else {
            model.data?.categories?.insert(0, allCategory);
            updateSelectedCategory(allCategory);
          }

          completer.complete(model.data?.categories ?? <Categories>[]);
        },
        failureCallback: (Map<String, dynamic> json) {
          AppSnackbar()
              .snackbarFailure(title: "Oops", message: json["message"]);

          completer.complete(<Categories>[]);
        },
        needLoader: false,
      );
    }
    return completer.future;
  }

  Future<List<Bookings>> _apiCallServicesHistory(int pageKey) async {
    final Completer<List<Bookings>> completer = Completer<List<Bookings>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
      "status": "Completed,Cancelled",
      "sortBy": "createdAt",
      "sortOrder": "desc",
    };

    final String id = rxSelectedServices.value.sId ?? "";
    if (id.isEmpty) {
    } else {
      query.addAll(
        <String, dynamic>{"categoryId": id},
      );
    }

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "booking/history/Customer",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        NewOrderModel model = NewOrderModel();
        model = NewOrderModel.fromJson(json);

        completer.complete(model.data?.bookings ?? <Bookings>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Bookings>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }

  Future<List<Bookings>> _apiCallCategoriesHistory(int pageKey) async {
    final Completer<List<Bookings>> completer = Completer<List<Bookings>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
      "status": "Completed,Cancelled",
      "sortBy": "createdAt",
      "sortOrder": "desc",
    };

    final String id = rxSelectedCategory.value.sId ?? "";
    if (id.isEmpty) {
    } else {
      query.addAll(
        <String, dynamic>{"categoryId": id},
      );
    }

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "booking/history/Customer",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        NewOrderModel model = NewOrderModel();
        model = NewOrderModel.fromJson(json);

        completer.complete(model.data?.bookings ?? <Bookings>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Bookings>[]);
      },
      needLoader: false,
    );
    return completer.future;
  }
}

class DashboardClass {
  DashboardClass({
    required this.name,
    required this.iconData,
  });

  final String name;
  final IconData iconData;
}
