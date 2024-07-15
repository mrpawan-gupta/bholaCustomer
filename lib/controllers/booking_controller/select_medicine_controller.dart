import "dart:async";

import "package:customer/models/get_all_medicines_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

double defaultMinRange = 0.0;
double defaultMaxRange = 10000.0;

class SelectMedicineController extends GetxController {
  final int pageSize = 10;

  final RxString rxSelectedCropId = "".obs;

  final TextEditingController searchController = TextEditingController();
  final RxString rxSearchQuery = "".obs;

  final PagingController<int, CropMedicines> pagingControllerMedicines =
      PagingController<int, CropMedicines>(firstPageKey: 1);

  final RxDouble rxFilterMinRange = defaultMinRange.obs;
  final RxDouble rxFilterMaxRange = defaultMaxRange.obs;
  final RxString rxFilterSelectedSortBy = "".obs;

  final RxList<String> defaultSortBy = <String>[
    "Popularity",
    "Price - Low to High",
    "Price - High to Low",
    "Newest First",
  ].obs;

  final Rx<CropMedicines> rxFilterSelectedCropMedicines = CropMedicines().obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateSelectedCropId(arguments["id"]);
      } else {}
    } else {}

    pagingControllerMedicines.addPageRequestListener(_fetchPageMedicines);
  }

  @override
  void onClose() {
    pagingControllerMedicines
      ..removePageRequestListener(_fetchPageMedicines)
      ..dispose();

    super.onClose();
  }

  void updateSelectedCropId(String value) {
    rxSelectedCropId(value);
    return;
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

  void updateFilterSelectedCategory(CropMedicines value) {
    rxFilterSelectedCropMedicines(value);
    return;
  }

  Future<void> _fetchPageMedicines(int pageKey) async {
    try {
      final List<CropMedicines> newItems = await _apiCallMedicines(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerMedicines.appendLastPage(newItems)
          : pagingControllerMedicines.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerMedicines.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<CropMedicines>> _apiCallMedicines(int pageKey) async {
    final Completer<List<CropMedicines>> completer =
        Completer<List<CropMedicines>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
      "sortBy": "createdAt",
      "sortOrder": "desc",
      "status": "Approved",
      "crop": rxSelectedCropId.value,
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

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "cropmedicine",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAllMedicinesModel model = GetAllMedicinesModel();
        model = GetAllMedicinesModel.fromJson(json);

        completer.complete(model.data?.cropMedicines ?? <CropMedicines>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<CropMedicines>[]);
      },
      needLoader: false,
    );

    return completer.future;
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

  RxInt filterCount() {
    final List<bool> tempList = <bool>[
      filterIsPriceApplied().value,
      filterIsSortByApplied().value,
    ];
    return tempList.where((bool e) => e == true).toList().length.obs;
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
      default:
        break;
    }
    return;
  }
}
