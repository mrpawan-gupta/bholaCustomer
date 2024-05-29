import "dart:async";

import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/models/product_details_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";
import "package:pod_player/pod_player.dart";

class ProductDetailController extends GetxController {

  final RxString rxProductId = "".obs;
  final RxInt rxCurrentIndex = 0.obs;
  final Rx<ProductDetailsData> rxProductDetailsData = ProductDetailsData().obs;
  final RxBool descTextShowFlag = false.obs;
  final RxString productPhoto = "".obs;
  final RxList<Ratings> ratings = <Ratings>[].obs;
  final RxDouble averageRating = 0.0.obs;
  final RxInt totalReviews = 0.obs;
  final Rx<Address> rxAddressInfo = Address().obs;
  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;


  PodPlayerController podPlayerController = PodPlayerController(
    playVideoFrom: PlayVideoFrom.network(""),
  );

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateProductId(arguments["id"]);
      } else {}
    } else {}
    unawaited(getProductDetailsAPICall());

    updateUserInfo(AppStorageService().getUserInfoModel());
    unawaited(getAddressesAPI());
  }

  void toggleDescTextShowFlag() {
    descTextShowFlag.value = !descTextShowFlag.value;
  }

  void updateProductId(String value) {
    rxProductId(value);
    return;
  }

  void updateAddressInfo(Address value) {
    rxAddressInfo(value);
    return;
  }

  void updateUserInfo(GetUserByIdData value) {
    rxUserInfo(value);
    return;
  }

  String getFullName() {
    final String firstName = rxUserInfo.value.firstName ?? "";
    final String lastName = rxUserInfo.value.lastName ?? "";
    return "$firstName $lastName";
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

    super.onClose();
  }

  void updateCurrentIndex(int value) {
    rxCurrentIndex(value);
    return;
  }

  void updateProductDetailsData(ProductDetailsData value) {
    rxProductDetailsData(value);
    productPhoto(value.photo ?? "");
    return;
  }


  Future<void> getProductDetailsAPICall() async {
    final Completer<void> completer = Completer<void>();
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "product/${rxProductId.value}",
      successCallback: (Map<String, dynamic> json) async {
        AppLogger().info(message: json["message"]);

        ProductDetails productDetails = ProductDetails();
        productDetails = ProductDetails.fromJson(json);

        updateProductDetailsData(productDetails.data ?? ProductDetailsData());

        await initPodPlayerController();

        fetchRatingsFromProductDetails(productDetails);

        completer.complete();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete();
      },
    );
    return completer.future;
  }

  void fetchRatingsFromProductDetails(ProductDetails productDetails) {
    final List<Ratings> fetchedRatings = productDetails.data?.ratings ?? [];

    if (fetchedRatings.isNotEmpty) {
      ratings.assignAll(fetchedRatings);

      final double totalStars = ratings.fold(0, (double sum, Ratings item) =>
      sum + item.star!);
      averageRating.value = totalStars / ratings.length;
      totalReviews.value = ratings.length;
    }
  }

  String getAddressOrAddressPlaceholder() {
    String value = "";
    final bool isMapEquals = mapEquals(
      rxAddressInfo.value.toJson(),
      GetAddressesData().toJson(),
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

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAddresses model = GetAddresses();
        model = GetAddresses.fromJson(json);

        print("hcbhbhfbvhf, ${model.toJson()}");

        final List<Address> list = (model.data?.address ?? <Address>[]).where(
              (Address element) {
            return (element.isPrimary ?? false) == true;
          },
        ).toList();
        print("hcbhbhfbvhf, ${list}");
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

}
