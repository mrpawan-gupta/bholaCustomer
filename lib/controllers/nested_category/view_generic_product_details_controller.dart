import "dart:async";

import "package:customer/models/generic_product_details_model.dart";
import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/models/rating_summary.dart";
import "package:customer/models/related_suggested.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";
import "package:pod_player/pod_player.dart";

class ViewGenericProductDetailsController extends GetxController {
  final int pageSize = 3;

  final RxString rxProductId = "".obs;
  final RxInt rxCurrentIndex = 0.obs;

  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;
  final Rx<GenericProductData> rxProductDetailsData = GenericProductData().obs;
  final Rx<Address> rxAddressInfo = Address().obs;
  final Rx<RatingSummaryData> rxRatingSummary = RatingSummaryData().obs;

  PodPlayerController podPlayerController = PodPlayerController(
    playVideoFrom: PlayVideoFrom.network(""),
  );

  final PagingController<int, Products> pagingControllerProducts =
      PagingController<int, Products>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateProductId(arguments["id"]);
      } else {}
    } else {}

    updateUserInfo(AppStorageService().getUserInfoModel());
    unawaited(getProductDetailsAPICall());
    unawaited(getAddressesAPI());
    unawaited(getRatingSummaryAPI());

    pagingControllerProducts.addPageRequestListener(_fetchPageProducts);
  }

  Future<void> initPodPlayerController() async {
    final String videoURL = rxProductDetailsData.value.video ?? "";
    if (videoURL.isNotEmpty) {
      podPlayerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(videoURL),
      );

      await podPlayerController.initialise();
    } else {}
  }

  @override
  void onClose() {
    podPlayerController.dispose();

    pagingControllerProducts
      ..removePageRequestListener(_fetchPageProducts)
      ..dispose();

    super.onClose();
  }

  void updateProductId(String value) {
    rxProductId(value);
    return;
  }

  void updateCurrentIndex(int value) {
    rxCurrentIndex(value);
    return;
  }

  void updateUserInfo(GetUserByIdData value) {
    rxUserInfo(value);
    return;
  }

  void updateProductDetailsData(GenericProductData value) {
    rxProductDetailsData(value);
    return;
  }

  void updateAddressInfo(Address value) {
    rxAddressInfo(value);
    return;
  }

  void updateRatingSummary(RatingSummaryData value) {
    rxRatingSummary(value);
    return;
  }

  String getFullName() {
    final String firstName = rxUserInfo.value.firstName ?? "";
    final String lastName = rxUserInfo.value.lastName ?? "";
    return "$firstName $lastName";
  }

  String getAddressOrAddressPlaceholder() {
    String value = "";
    final bool isMapEquals = mapEquals(
      rxAddressInfo.value.toJson(),
      Address().toJson(),
    );
    if (isMapEquals) {
      value = "-";
    } else {
      final String street = rxAddressInfo.value.street ?? "";
      final String city = rxAddressInfo.value.city ?? "";
      final String country = rxAddressInfo.value.country ?? "";
      final String pinCode = rxAddressInfo.value.pinCode ?? "";
      value = "$street $city $country $pinCode";
    }
    return value;
  }

  Future<void> getProductDetailsAPICall() async {
    final Completer<void> completer = Completer<void>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product/${rxProductId.value}",
      successCallback: (Map<String, dynamic> json) async {
        AppLogger().info(message: json["message"]);

        GenericProduct productDetails = GenericProduct();
        productDetails = GenericProduct.fromJson(json);

        updateProductDetailsData(productDetails.data ?? GenericProductData());

        await initPodPlayerController();

        pagingControllerProducts.refresh();

        completer.complete();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete();
      },
    );
    return completer.future;
  }

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAddresses model = GetAddresses();
        model = GetAddresses.fromJson(json);

        final List<Address> list = (model.data?.address ?? <Address>[]).where(
          (Address element) {
            return (element.isPrimary ?? false) == true;
          },
        ).toList();

        if (list.isEmpty) {
        } else {
          updateAddressInfo(list.first);
        }
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );
    return Future<void>.value();
  }

  Future<void> getRatingSummaryAPI() async {
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product/${rxProductId.value}/ratingSummary",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        RatingSummary model = RatingSummary();
        model = RatingSummary.fromJson(json);

        updateRatingSummary(model.data ?? RatingSummaryData());
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: false,
    );
    return Future<void>.value();
  }

  Future<void> _fetchPageProducts(int pageKey) async {
    try {
      final List<Products> newItems = await _apiCallProducts(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerProducts.appendLastPage(newItems)
          : pagingControllerProducts.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerProducts.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Products>> _apiCallProducts(int pageKey) async {
    final Completer<List<Products>> completer = Completer<List<Products>>();

    final Map<String, dynamic> map1 = rxProductDetailsData.value.toJson();
    final Map<String, dynamic> map2 = GenericProductData().toJson();

    final String category = rxProductDetailsData.value.category ?? "";

    final bool condition1 = mapEquals(map1, map2);
    final bool condition2 = category.isEmpty;
    final bool finalCondition = condition1 || condition2;

    if (finalCondition) {
      completer.complete(<Products>[]);
    } else {
      await AppAPIService().functionGet(
        types: Types.order,
        endPoint: "${rxProductId.value}/product/$category",
        query: <String, dynamic>{
          "page": pageKey,
          "limit": pageSize,
        },
        successCallback: (Map<String, dynamic> json) {
          AppLogger().info(message: json["message"]);

          RelatedSuggested model = RelatedSuggested();
          model = RelatedSuggested.fromJson(json);

          completer.complete(model.data?.products ?? <Products>[]);
        },
        failureCallback: (Map<String, dynamic> json) {
          AppSnackbar().snackbarFailure(
            title: "Oops",
            message: json["message"],
          );

          completer.complete(<Products>[]);
        },
        needLoader: false,
      );
    }

    return completer.future;
  }
}
