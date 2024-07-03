import "dart:async";

import "package:customer/models/coupon_list_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:infinite_scroll_pagination/infinite_scroll_pagination.dart";

class CouponController extends GetxController {
  final int pageSize = 10;

  final TextEditingController searchController = TextEditingController();
  final RxString rxSearchQuery = "".obs;

  final RxString rxTempCouponId = "".obs;
  final Rx<Coupons> rxSelectedCoupon = Coupons().obs;

  final PagingController<int, Coupons> pagingControllerPromo =
      PagingController<int, Coupons>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateTempCouponId(arguments["id"]);
      } else {}
    } else {}

    pagingControllerPromo.addPageRequestListener(_fetchPagePromo);
  }

  @override
  void onClose() {
    pagingControllerPromo
      ..removePageRequestListener(_fetchPagePromo)
      ..dispose();

    super.onClose();
  }

  void updateSearchQuery(String value) {
    rxSearchQuery(value);
    return;
  }

  void updateTempCouponId(String value) {
    rxTempCouponId(value);
    return;
  }

  void updateSelectedCoupon(Coupons value) {
    rxSelectedCoupon(value);
    return;
  }

  String validate() {
    String reason = "";
    final bool cond = !mapEquals(rxSelectedCoupon.toJson(), Coupons().toJson());
    if (!cond) {
      reason = "Please select one coupon first.";
    } else {}
    return reason;
  }

  Future<void> _fetchPagePromo(int pageKey) async {
    try {
      final List<Coupons> newItems = await _apiCallPromo(pageKey);
      final bool isLastPage = newItems.length < pageSize;
      isLastPage
          ? pagingControllerPromo.appendLastPage(newItems)
          : pagingControllerPromo.appendPage(newItems, pageKey + 1);
    } on Exception catch (error, stackTrace) {
      AppLogger().error(
        message: "Exception caught",
        error: error,
        stackTrace: stackTrace,
      );
      pagingControllerPromo.error = error;
    } finally {}
    return Future<void>.value();
  }

  Future<List<Coupons>> _apiCallPromo(int pageKey) async {
    final Completer<List<Coupons>> completer = Completer<List<Coupons>>();

    final Map<String, dynamic> query = <String, dynamic>{
      "page": pageKey,
      "limit": pageSize,
      "couponType": "promo",
      "isActive": true,
    };

    if (rxSearchQuery.isNotEmpty) {
      query.addAll(<String, dynamic>{"search": rxSearchQuery.value});
    } else {}

    await AppAPIService().functionGet(
      types: Types.order,
      endPoint: "coupon",
      query: query,
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        CouponListModel model = CouponListModel();
        model = CouponListModel.fromJson(json);

        final Coupons result = (model.data?.coupons ?? <Coupons>[]).firstWhere(
          (Coupons e) {
            final String id = e.sId ?? "";
            final bool cond1 = id == rxTempCouponId.value;
            final bool cond2 = id == (rxSelectedCoupon.value.sId ?? "");

            return cond1 || cond2;
          },
          orElse: Coupons.new,
        );

        updateSelectedCoupon(result);

        updateTempCouponId("");

        completer.complete(model.data?.coupons ?? <Coupons>[]);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(<Coupons>[]);
      },
    );

    return completer.future;
  }
}
