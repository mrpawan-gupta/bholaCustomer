import "dart:async";

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/models/get_booking_medicine_details.dart";
import "package:customer/models/get_booking_transaction_details.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";

class BookingDetailsController extends GetxController {
  final RxString rxBookingId = "".obs;
  final Rx<Bookings> rxBookings = Bookings().obs;
  final Rx<MedicineDetailsData> rxMedicine = MedicineDetailsData().obs;
  final Rx<TransactionDetailsData> rxTransaction = TransactionDetailsData().obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateBookingId(arguments["id"]);
      } else {}
    } else {}

    unawaited(getBookingAPICall());
  }

  bool isVisibleConfirmAndCancelButton() {
    final String route1 = AppRoutes().mainNavigationScreen;
    final String route2 = AppRoutes().addedQuotesScreen;
    final bool isAllowedRoute1 = AppNavService().previousRoute == route1;
    final bool isAllowedRoute2 = AppNavService().previousRoute == route2;
    final bool isAllowedRoute = isAllowedRoute1 || isAllowedRoute2;
    final String status = rxBookings.value.status ?? "";
    final bool isStatusCorrect = status == bookingCreated;

    return isAllowedRoute && isStatusCorrect;
  }

  bool isVisibleCancelButton() {
    final String allowRoute = AppRoutes().mainNavigationScreen;
    final bool isAllowedRoute = AppNavService().previousRoute == allowRoute;
    final String status = rxBookings.value.status ?? "";
    final bool isStatusCorrect = status == bookingConfirmed;

    return isAllowedRoute && isStatusCorrect;
  }

  bool isVisibleReviewRating() {
    final String allowRoute = AppRoutes().mainNavigationScreen;
    final bool isAllowedRoute = AppNavService().previousRoute == allowRoute;
    final String status = rxBookings.value.status ?? "";
    final bool isStatusCorrect = status == bookingCompleted;

    return isAllowedRoute && isStatusCorrect;
  }

  void updateBookingId(String value) {
    rxBookingId(value);
    return;
  }

  void updateBookings(Bookings value) {
    rxBookings(value);
    return;
  }

  void updateMedicine(MedicineDetailsData value) {
    rxMedicine(value);
    return;
  }

  void updateTransaction(TransactionDetailsData value) {
    rxTransaction(value);
    return;
  }

  Future<bool> getBookingAPICall() async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "booking/${rxBookingId.value}",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        NewOrderModel model = NewOrderModel();
        model = NewOrderModel(
          success: json["success"],
          statusCode: json["statusCode"],
          message: json["message"],
          data: NewOrderModelData(
            bookings: <Bookings>[Bookings.fromJson(json["data"])],
          ),
        );

        final List<Bookings> list =
            (model.data ?? NewOrderModelData()).bookings ?? <Bookings>[];

        if (list.isEmpty) {
        } else {
          updateBookings(list.first);

          final Bookings item = rxBookings.value;
          final String displayType = item.type ?? "";
          final bool condition = displayType == displayTypeAreaWithMedicine;

          if (condition) {
            unawaited(getBookingMedicineAPICall());
          } else {}

          final bool paymentReceived = item.paymentReceived ?? false;

          if (paymentReceived) {
            unawaited(getBookingTransactionAPICall());
          } else {}
        }

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<bool> getBookingMedicineAPICall() async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "bookingmedicine",
      query: <String, dynamic>{
        "page": 1,
        "limit": 1000,
        "bookingId": rxBookingId.value,
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetBookingMedicineDetails model = GetBookingMedicineDetails();
        model = GetBookingMedicineDetails.fromJson(json);

        updateMedicine(model.data ?? MedicineDetailsData());

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<bool> getBookingTransactionAPICall() async {
    final Completer<bool> completer = Completer<bool>();

    await AppAPIService().functionGet(
      types: Types.rental,
      endPoint: "bookingtransaction/${rxBookingId.value}",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetBookingTransactionDetails model = GetBookingTransactionDetails();
        model = GetBookingTransactionDetails.fromJson(json);

        updateTransaction(model.data ?? TransactionDetailsData());

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<bool> confirmOrderAPICall({required String id}) async {
    final Completer<bool> completer = Completer<bool>();
    await AppAPIService().functionPatch(
      types: Types.rental,
      endPoint: "booking/$id/status",
      body: <String, String>{"status": bookingConfirmed},
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<bool> cancelBookingAPICall({required String id}) async {
    final Completer<bool> completer = Completer<bool>();
    await AppAPIService().functionDelete(
      types: Types.rental,
      endPoint: "booking/$id",
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
    );
    return completer.future;
  }

  Future<bool> addReviewRatingAPICall({
    required String id,
    required num rating,
    required String review,
  }) async {
    final Completer<bool> completer = Completer<bool>();

    final FormData formData = FormData(
      <String, dynamic>{
        "star": rating,
        "review": review,
      },
    );

    await AppAPIService().functionPost(
      types: Types.rental,
      endPoint: "booking/$id/review",
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
      isForFileUpload: true,
      formData: formData,
    );

    return completer.future;
  }

  bool canPayNow() {
    final Bookings item = rxBookings.value;
    final bool paymentReceived = item.paymentReceived ?? false;

    final bool status1 = item.status == bookingConfirmed;
    final bool status2 = item.status == bookingAccepted;
    final bool status3 = item.status == bookingWorkInProgress;
    final bool status4 = item.status == bookingCompleted;

    final bool cond1 = !paymentReceived && status1;
    final bool cond2 = !paymentReceived && status2;
    final bool cond3 = !paymentReceived && status3;
    final bool cond4 = !paymentReceived && status4;

    final Map<String, dynamic> emptyJson = Customer().toJson();
    final Map<String, dynamic> map1 = item.vendor?.toJson() ?? emptyJson;
    final Map<String, dynamic> map2 = emptyJson;

    final bool semifinalCondition1 = cond1 || cond2 || cond3 || cond4;
    final bool semifinalCondition2 = !mapEquals(map1, map2);

    final bool finalCondition = semifinalCondition1 && semifinalCondition2;
    return finalCondition;
  }
}
