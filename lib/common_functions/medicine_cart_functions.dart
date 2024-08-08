import "dart:async";

import "package:customer/models/add_medicine_to_booking_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";

Future<(bool, String)> addMedicineToBookingAPICall({
  required String bookingId,
  required String medicineId,
}) async {
  final Completer<(bool, String)> completer = Completer<(bool, String)>();

  await AppAPIService().functionPost(
    types: Types.rental,
    endPoint: "bookingmedicine/$bookingId",
    body: <String, dynamic>{"medicine": medicineId, "quantity": "1"},
    successCallback: (Map<String, dynamic> json) {
      AppLogger().info(message: json["message"]);

      String temp = "";

      AddMedicineToBookingModel model = AddMedicineToBookingModel();
      model = AddMedicineToBookingModel.fromJson(json);

      final List<Medicines> items = model.data?.medicines ?? <Medicines>[];
      if (items.isNotEmpty) {
        final Medicines result = items.firstWhere(
          (Medicines e) => (e.medicine ?? "") == medicineId,
          orElse: Medicines.new,
        );

        if (!mapEquals(result.toJson(), Medicines().toJson())) {
          temp = result.sId ?? "";
        } else {}
      } else {}

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

Future<bool> updateMedicineInBookingAPICall({
  required String bookingId,
  required String itemId,
  required num qty,
}) async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionPatch(
    types: Types.rental,
    endPoint: "bookingmedicine/$bookingId/$itemId",
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

Future<bool> removeMedicineFromBookingAPICall({
  required String bookingId,
  required String itemId,
}) async {
  final Completer<bool> completer = Completer<bool>();

  await AppAPIService().functionDelete(
    types: Types.rental,
    endPoint: "bookingmedicine/$bookingId/$itemId",
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
