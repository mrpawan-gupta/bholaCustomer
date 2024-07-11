// ignore_for_file: lines_longer_than_80_chars

import "dart:async";

import "package:customer/models/get_addresses_model.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";
import "package:place_picker/place_picker.dart";

class AddressesListController extends GetxController {
  final RxList<Address> rxAddressList = <Address>[].obs;

  @override
  void onInit() {
    super.onInit();

    unawaited(getAddressesAPI());
  }

  void updateAddressInfo(List<Address> value) {
    rxAddressList(value);
    return;
  }

  Future<void> getAddressesAPI() async {
    await AppAPIService().functionGet(
      types: Types.oauth,
      endPoint: "address/0",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        GetAddresses model = GetAddresses();
        model = GetAddresses.fromJson(json);

        rxAddressList
          ..clear()
          ..addAll(model.data?.address ?? <Address>[])
          ..refresh();
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    return Future<void>.value();
  }

  String validateLocationResult({required LocationResult result}) {
    String reason = "";

    final bool cond1 = (result.postalCode ?? "").isNotEmpty;
    final bool cond2 = (result.formattedAddress ?? "").isNotEmpty;
    final bool cond3 = (result.city?.name ?? "").isNotEmpty;
    final bool cond4 = (result.country?.name ?? "").isNotEmpty;
    final bool cond5 = (result.latLng?.latitude ?? 0.0) != 0.0;
    final bool cond6 = (result.latLng?.longitude ?? 0.0) != 0.0;

    if (!cond1) {
      reason = "postalCode is missing, please select nearby location.";
    } else if (!cond2) {
      reason = "formattedAddress is missing, please select nearby location.";
    } else if (!cond3) {
      reason = "city name is missing, please select nearby location.";
    } else if (!cond4) {
      reason = "country name is missing, please select nearby location.";
    } else if (!cond5) {
      reason = "latitude is missing, please select nearby location.";
    } else if (!cond6) {
      reason = "longitude is missing, please select nearby location.";
    } else {}
    return reason;
  }

  Future<void> setAddressesAPI({required LocationResult result}) async {
    await AppAPIService().functionPost(
      types: Types.oauth,
      endPoint: "address",
      body: <String, dynamic>{
        "pinCode": result.postalCode ?? "",
        "street": result.formattedAddress ?? "",
        "city": result.city?.name ?? "",
        "country": result.country?.name ?? "",
        "latitude": result.latLng?.latitude ?? "",
        "longitude": result.latLng?.longitude ?? "",
      },
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        unawaited(getAddressesAPI());
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    return Future<void>.value();
  }

  Future<void> updateAddressesAPI({required String id}) async {
    await AppAPIService().functionPatch(
      types: Types.oauth,
      endPoint: "address/$id",
      body: <String, dynamic>{"isPrimary": true},
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        unawaited(getAddressesAPI());
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    return Future<void>.value();
  }

  Future<void> deleteAddressesAPI({required String id}) async {
    await AppAPIService().functionDelete(
      types: Types.oauth,
      endPoint: "address/$id",
      successCallback: (Map<String, dynamic> json) {
        AppLogger().info(message: json["message"]);

        unawaited(getAddressesAPI());
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    return Future<void>.value();
  }
}
