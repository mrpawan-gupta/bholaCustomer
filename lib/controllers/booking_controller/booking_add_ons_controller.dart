import "dart:async";

import "package:customer/common_functions/booking_functions.dart";
import "package:customer/models/get_booking_medicine_details.dart";
import "package:customer/models/new_order_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

class BookingAddOnsController extends GetxController {
  final RxString rxBookingId = "".obs;
  final Rx<Bookings> rxBookings = Bookings().obs;
  final Rx<MedicineDetailsData> rxMedicine = MedicineDetailsData().obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final Map<String, dynamic> arguments = Get.arguments;
      if (arguments.containsKey("id")) {
        updateBookingId(arguments["id"]);
      } else {}
    } else {}

    unawaited(getBookingAPICall(needLoader: true));
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

  Future<bool> getBookingAPICall({required bool needLoader}) async {
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
        }

        completer.complete(true);
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);

        completer.complete(false);
      },
      needLoader: needLoader,
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
}
