import "dart:async";

import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_all_carts_model.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";

class CartController extends GetxController {
  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;
  final Rx<Address> rxAddressInfo = Address().obs;

  final Rx<Carts> rxCart = Carts().obs;
  final RxList<Items> rxItemsList = <Items>[].obs;

  @override
  void onInit() {
    super.onInit();

    initReinit();
  }

  void initReinit() {
    updateUserInfo(AppStorageService().getUserInfoModel());

    unawaited(getAddressesAPI());

    unawaited(getAllCartsItemsAPICall(needLoader: true));
    return;
  }

  void updateUserInfo(GetUserByIdData value) {
    rxUserInfo(value);
    return;
  }

  void updateAddressInfo(Address value) {
    rxAddressInfo(value);
    return;
  }

  void updateCart(Carts value) {
    rxCart(value);
    return;
  }

  void updateItemsList(List<Items> value) {
    rxItemsList(value);
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

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address/0",
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

  Future<void> getAllCartsItemsAPICall({required bool needLoader}) async {
    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "cart",
      query: <String, dynamic>{"page": 1, "limit": 1000},
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAllCartsModel model = GetAllCartsModel();
        model = GetAllCartsModel.fromJson(json);

        final List<Carts> tempList = model.data?.carts ?? <Carts>[];

        if (tempList.isNotEmpty) {
          updateCart(tempList.first);

          rxItemsList
            ..clear()
            ..addAll(tempList.first.items ?? <Items>[])
            ..refresh();
        } else {}
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
      needLoader: needLoader,
    );
    return Future<void>.value();
  }

  Future<bool> updateCartAPICall({required String id, required num qty}) async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionPatch(
      types: Types.order,
      endPoint: "cart/${rxCart.value.sId ?? ""}/item/$id",
      body: <String, dynamic>{"quantity": qty},
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
      needLoader: false,
    );

    return completer.future;
  }

  Future<bool> removeItemFromCartAPICall({required String id}) async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionDelete(
      types: Types.order,
      endPoint: "cart/${rxCart.value.sId ?? ""}/item/$id",
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
      needLoader: false,
    );

    return completer.future;
  }

  Future<bool> applyCouponAPICall({required String code}) async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionPost(
      types: Types.order,
      endPoint: "coupon/apply",
      body: <String, dynamic>{"code": code},
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
      needLoader: false,
    );

    return completer.future;
  }

  Future<bool> removeCouponAPICall({required String code}) async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionPost(
      types: Types.order,
      endPoint: "coupon/remove",
      body: <String, dynamic>{"code": code},
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
      needLoader: false,
    );

    return completer.future;
  }
}
