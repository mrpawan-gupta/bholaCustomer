import "dart:async";

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

class BookingDetailsController extends GetxController {
  final RxString rxBookingId = "".obs;
  final Rx<Bookings> rxBookings = Bookings().obs;

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
}
