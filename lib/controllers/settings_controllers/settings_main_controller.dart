import "dart:async";
import "dart:io";

import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_intro_bottom_sheet.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:device_info_plus/device_info_plus.dart";
import "package:get/get.dart";
import "package:permission_handler/permission_handler.dart";

class SettingsMainController extends GetxController {
  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;

  @override
  void onInit() {
    super.onInit();

    initAndReInitFunction();
  }

  void initAndReInitFunction() {
    updateUserInfo(AppStorageService().getUserInfoModel());
    return;
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
    return email.isNotEmpty ? email : "-";
  }

  String getPhoneNumberOrPhoneNumberPlaceholder() {
    final String phoneNumber = rxUserInfo.value.phoneNumber ?? "";
    return phoneNumber.isNotEmpty ? phoneNumber : "-";
  }

  Future<void> deleteAPICall() async {
    final Completer<void> completer = Completer<void>();

    final String id = AppStorageService().getUserAuthModel().sId ?? "";

    if (id.isNotEmpty) {
      await AppAPIService().functionDelete(
        types: Types.oauth,
        endPoint: "user/0",
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

  Future<void> canGoAhead({required Function() onContinue}) async {
    final bool check1 = await checkCamFunction();
    final bool check2 = await checkCamFunction();
    final bool check3 = await checkCamFunction();

    if (check1 && check2 && check3) {
      onContinue();
    } else {
      await AppIntroBottomSheet().openCamMicStorageSheet(
        onContinue: () async {
          await requestCamFunction();
          await requestMicFunction();
          await requestPhotoOrStorageFunction();

          final bool check1 = await checkCamFunction();
          final bool check2 = await checkCamFunction();
          final bool check3 = await checkCamFunction();

          if (check1 && check2 && check3) {
            onContinue();
          } else {}
        },
      );
    }

    return Future<void>.value();
  }

  Future<bool> checkCamFunction() async {
    final PermissionStatus isGranted = await Permission.camera.status;

    final bool value = isGranted == PermissionStatus.granted;
    return Future<bool>.value(value);
  }

  Future<bool> checkMicFunction() async {
    final PermissionStatus isGranted = await Permission.microphone.status;

    final bool value = isGranted == PermissionStatus.granted;
    return Future<bool>.value(value);
  }

  Future<bool> checkPhotoOrStorageFunction() async {
    PermissionStatus isGranted = PermissionStatus.denied;

    if (Platform.isIOS) {
      isGranted = await Permission.photos.status;
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;

      isGranted = info.version.sdkInt <= 32
          ? await Permission.storage.status
          : await Permission.photos.status;
    } else {}

    final bool value = isGranted == PermissionStatus.granted;
    return Future<bool>.value(value);
  }

  Future<void> requestCamFunction() async {
    await AppPermService().permissionCam();
    return Future<void>.value();
  }

  Future<void> requestMicFunction() async {
    await AppPermService().permissionMic();
    return Future<void>.value();
  }

  Future<void> requestPhotoOrStorageFunction() async {
    await AppPermService().permissionPhotoOrStorage();
    return Future<void>.value();
  }
}
