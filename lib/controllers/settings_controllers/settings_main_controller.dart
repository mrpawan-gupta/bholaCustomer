import "dart:async";

import "package:customer/models/get_addresses_model.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/foundation.dart";
import "package:get/get.dart";

class SettingsMainController extends GetxController {
  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;
  final Rx<Address> rxAddressInfo = Address().obs;

  @override
  void onInit() {
    super.onInit();

    initAndReInitFunction();
  }

  void initAndReInitFunction() {
    updateUserInfo(AppStorageService().getUserInfoModel());

    unawaited(getAddressesAPI());
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

  String getFullName() {
    final String firstName = rxUserInfo.value.firstName ?? "";
    final String lastName = rxUserInfo.value.lastName ?? "";
    return "$firstName $lastName";
  }

  String getEmailOrEmailPlaceholder() {
    final String email = rxUserInfo.value.email ?? "";
    return email.isNotEmpty ? email : "-";
  }

  String getPhoneNumberOrPhoneNumberPlaceholder() {
    final String phoneNumber = rxUserInfo.value.phoneNumber ?? "";
    return phoneNumber.isNotEmpty ? phoneNumber : "-";
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

        final List<Address> list = (model.data?.address ?? <Address>[]).where(
          (Address element) {
            return (element.primary ?? false) == true;
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

  Future<void> deleteAPICall() async {
    final Completer<void> completer = Completer<void>();

    final String id = AppStorageService().getUserAuthModel().sId ?? "";

    if (id.isNotEmpty) {
      await AppAPIService().functionDelete(
        types: Types.oauth,
        endPoint: "user/$id",
        successCallback: (Map<String, dynamic> json) async {
          AppSnackbar().snackbarSuccess(
            title: "Yay!",
            message: json["message"],
          );

          completer.complete();
        },
        failureCallback: (Map<String, dynamic> json) async {
          AppSnackbar().snackbarFailure(
            title: "Oops",
            message: json["message"],
          );

          completer.complete();
        },
        needLoader: false,
      );
    } else {
      completer.complete();
    }

    await AppSession().performSignOut();

    return completer.future;
  }

  Future<void> signoutAPICall() async {
    final Completer<void> completer = Completer<void>();

    await AppAPIService().functionDelete(
      types: Types.oauth,
      endPoint: "user/signout",
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(
          title: "Yay!",
          message: json["message"],
        );

        completer.complete();
      },
      failureCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarFailure(
          title: "Oops",
          message: json["message"],
        );

        completer.complete();
      },
      needLoader: false,
    );

    await AppSession().performSignOut();

    return completer.future;
  }
}
