import "dart:async";

import "package:customer/models/add_to_cart_response.dart";
import "package:customer/models/wish_and_cart_count_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";

final Rx<num> rxWishListCount = 0.obs;
final Rx<num> rxCartListCount = 0.obs;

Future<bool> wishListAndCartListAPICall() async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionGet(
    types: Types.order,
    endPoint: "wishlist/count",
    query: <String, dynamic>{},
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      WishAndCartCountModel model = WishAndCartCountModel();
      model = WishAndCartCountModel.fromJson(json);

      final int wishlistTotalCount = model.data?.wishlistTotalCount ?? 0;
      final int cartTotalCount = model.data?.cartTotalCount ?? 0;

      rxWishListCount(wishlistTotalCount);
      rxCartListCount(cartTotalCount);

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

Future<bool> addToWishListAPICall({
  required String productId,
}) async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionPost(
    types: Types.order,
    endPoint: "wishlist",
    body: <String, dynamic>{"productId": productId},
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      unawaited(wishListAndCartListAPICall());

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

Future<bool> removeFromWishListAPICall({
  required String productId,
}) async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionDelete(
    types: Types.order,
    endPoint: "wishlist/$productId",
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      unawaited(wishListAndCartListAPICall());

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

Future<(bool, String)> addToCartAPICall({
  required String productId,
}) async {
  final Completer<(bool, String)> completer = Completer<(bool, String)>();

  await AppAPIService().functionPost(
    types: Types.order,
    endPoint: "cart",
    body: <String, dynamic>{"productId": productId, "quantity": "1"},
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      String temp = "";

      AddToCartResponse model = AddToCartResponse();
      model = AddToCartResponse.fromJson(json);

      final List<Items> items = model.data?.items ?? <Items>[];
      if (items.isNotEmpty) {
        final Items result = items.firstWhere(
          (Items e) => (e.product ?? "") == productId,
          orElse: Items.new,
        );

        if (!mapEquals(result.toJson(), Items().toJson())) {
          temp = result.sId ?? "";
        } else {}
      } else {}

      unawaited(wishListAndCartListAPICall());

      completer.complete((true, temp));
    },
    failureCallback: (Map<String, dynamic> json) {
      AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

      const String temp = "";

      completer.complete((false, temp));
    },
    needLoader: false,
  );

  return completer.future;
}

Future<bool> updateCartAPICall({
  required String itemId,
  required String cartId,
  required num qty,
}) async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionPatch(
    types: Types.order,
    endPoint: "cart/$cartId/item/$itemId",
    body: <String, dynamic>{"quantity": qty},
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      unawaited(wishListAndCartListAPICall());

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

Future<bool> removeFromCartAPICall({
  required String itemId,
  required String cartId,
}) async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionDelete(
    types: Types.order,
    endPoint: "cart/$cartId/item/$itemId",
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      unawaited(wishListAndCartListAPICall());

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
