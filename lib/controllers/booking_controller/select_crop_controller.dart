import "dart:async";

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/models/crop_categories_model.dart";
import "package:customer/models/get_all_crops_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class SelectCropController extends GetxController {
  final int pageSize = 10;

  final RxBool rxHadCrop = false.obs;

  final RxString rxTempCropId = "".obs;

  final TextEditingController searchController = TextEditingController();
  final RxString rxSearchQuery = "".obs;

  final PagingController<int, CropCategories> pagingControllerCategories =
      PagingController<int, CropCategories>(firstPageKey: 1);

  final PagingController<int, Crops> pagingControllerCrops =
      PagingController<int, Crops>(firstPageKey: 1);

  final Rx<CropCategories> rxSelectedCategory = CropCategories().obs;

  final Rx<Crops> rxSelectedCrop = Crops().obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;

      if (arguments.containsKey("id")) {
        updateHadCoupon(value: true);
        updateTempCropId(arguments["id"]);
      } else {}
    } else {}

    pagingControllerCategories.addPageRequestListener(_fetchPageCategories);
    pagingControllerCrops.addPageRequestListener(_fetchPageCrops);
  }

  @override
  void onClose() {
    pagingControllerCategories
      ..removePageRequestListener(_fetchPageCategories)
      ..dispose();

    pagingControllerCrops
      ..removePageRequestListener(_fetchPageCrops)
      ..dispose();

    super.onClose();
  }

  void updateHadCoupon({required bool value}) {
    rxHadCrop(value);
    return;
  }

  void updateTempCropId(String value) {
    rxTempCropId(value);
    return;
  }

  void updateSearchQuery(String value) {
    rxSearchQuery(value);
    return;
  }

  void updateSelectedCategory(CropCategories value) {
    rxSelectedCategory(value);
    return;
  }

  void updateSelectedCrop(Crops value) {
    rxSelectedCrop(value);
    return;
  }

  Future<void> _fetchPageCategories(int pageKey) async {
    try {
      final List<CropCategories> newItems = await _apiCallCategories(pageKey);
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

  Future<void> _fetchPageCrops(int pageKey) async {
    try {
      final List<Crops> newItems = await _apiCallCrops(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerCrops.appendLastPage(newItems)
          : pagingControllerCrops.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerCrops.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<CropCategories>> _apiCallCategories(int pageKey) async {
    final Completer<List<CropCategories>> completer =
        Completer<List<CropCategories>>();
    if (pageKey > 1) {
      completer.complete(<CropCategories>[]);
    } else {
      await AppAPIService().functionGet(
        types: Types.rental,
        endPoint: "cropcategory",
        query: <String, dynamic>{
          "page": 1,
          "limit": 1000,
          "sortBy": "createdAt",
          "sortOrder": "desc",
          "status": "Approved",
        },
        successCallback: (Map<String, dynamic> json) {
          AppLogger().info(message: json["message"]);

          CropCategoriesModel model = CropCategoriesModel();
          model = CropCategoriesModel.fromJson(json);

          final (bool, CropCategories) result = checkAndGetCropCategoryObject(
            list: pagingControllerCategories.itemList ?? <CropCategories>[],
          );
          final bool hasAlreadyAdded = result.$1;
          final CropCategories allCategory = result.$2;

          if (hasAlreadyAdded) {
          } else {
            model.data?.cropCategories?.insert(0, allCategory);
            updateSelectedCategory(allCategory);
          }

          completer.complete(model.data?.cropCategories ?? <CropCategories>[]);
        },
        failureCallback: (Map<String, dynamic> json) {
          AppSnackbar().snackbarFailure(
            title: "Oops",
            message: json["message"],
          );

          completer.complete(<CropCategories>[]);
        },
        needLoader: false,
      );
    }

    return completer.future;
  }

  Future<List<Crops>> _apiCallCrops(int pageKey) async {
    final Completer<List<Crops>> completer = Completer<List<Crops>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
      "sortBy": "createdAt",
      "sortOrder": "desc",
      "status": "Approved",
    };

    if (rxSearchQuery.isNotEmpty) {
      query.addAll(<String, dynamic>{"search": rxSearchQuery.value});
    } else {}

    final String id = rxSelectedCategory.value.sId ?? "";
    if (id.isEmpty) {
    } else {
      query.addAll(<String, dynamic>{"categroy": id});
    }

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "crop",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAllCropsModel model = GetAllCropsModel();
        model = GetAllCropsModel.fromJson(json);

        final Crops result = (model.data?.crops ?? <Crops>[]).firstWhere(
          (Crops e) {
            final String id = e.sId ?? "";
            final bool cond1 = id == rxTempCropId.value;
            final bool cond2 = id == (rxSelectedCrop.value.sId ?? "");

            return cond1 || cond2;
          },
          orElse: Crops.new,
        );

        updateSelectedCrop(result);

        updateTempCropId("");

        completer.complete(model.data?.crops ?? <Crops>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Crops>[]);
      },
      needLoader: false,
    );

    return completer.future;
  }
}
