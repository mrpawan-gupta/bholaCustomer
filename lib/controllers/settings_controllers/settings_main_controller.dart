import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:get/get.dart";

class SettingsMainController extends GetxController {
  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;

  @override
  void onInit() {
    super.onInit();

    updateUserInfo(AppStorageService().getUserInfoModel());
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

  String getEmailOrEmailPlaceholder() {
    final String email = rxUserInfo.value.email ?? "";
    return email.isNotEmpty ? email : "Email not available";
  }

  Future<void> signoutAPICall() async {
    await AppAPIService().functionDelete(
      types: Types.oauth,
      endPoint: "user/signout",
      successCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarSuccess(title: "Yay!", message: json["message"]);
      },
      failureCallback: (Map<String, dynamic> json) async {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );

    await AppSession().performSignOut();
    return Future<void>.value();
  }
}
