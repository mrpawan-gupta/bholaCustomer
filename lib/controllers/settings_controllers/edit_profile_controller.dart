import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_get_multipart_file.dart";
import "package:customer/utils/app_regex.dart";
import "package:customer/utils/app_session.dart";
import "package:customer/utils/app_snackbar.dart";
import "package:flutter/widgets.dart";
import "package:get/get.dart";

class EditProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();

  final RxString rxProfilePictureURLs = "".obs;
  final RxString rxProfilePicturePath = "".obs;
  final RxString rxFirstName = "".obs;
  final RxString rxLastName = "".obs;
  final RxString rxEmailAddress = "".obs;

  @override
  void onInit() {
    super.onInit();

    prefillData();
  }

  void updateFirstName(String value) {
    rxFirstName(value);
  }

  void updateLastName(String value) {
    rxLastName(value);
  }

  void updateEmailAddress(String value) {
    rxEmailAddress(value);
  }

  void updateProfilePictureURLs(String value) {
    rxProfilePictureURLs(value);
    rxProfilePicturePath("");
  }

  void updateProfilePicturePath(String value) {
    rxProfilePicturePath(value);
    rxProfilePictureURLs("");
  }

  void prefillData() {
    final GetUserByIdData data = AppStorageService().getUserInfoModel();

    updateProfilePictureURLs(data.profile?.profilePhoto ?? "");

    firstNameController.text = data.firstName ?? "";
    updateFirstName(data.firstName ?? "");

    lastNameController.text = data.lastName ?? "";
    updateLastName(data.lastName ?? "");

    emailAddressController.text = data.email ?? "";
    updateEmailAddress(data.email ?? "");

    return;
  }

  Future<void> confirmSaveProcedure({
    required Function() successCallback,
    required Function() failureCallback,
  }) async {
    int successCount = 0;

    await editProfileFieldsAPICall(
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Oops", message: json["message"]);

        successCount++;
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );
    await editProfileFilesAPICall(
      successCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarSuccess(title: "Oops", message: json["message"]);

        successCount++;
      },
      failureCallback: (Map<String, dynamic> json) {
        AppSnackbar().snackbarFailure(title: "Oops", message: json["message"]);
      },
    );

    final GetUserByIdData userInfo = await AppSession().getUserAPICall();
    await AppSession().setUserInfo(userInfo: userInfo);

    successCount >= 1 ? successCallback() : failureCallback();

    return Future<void>.value();
  }

  String validateForm() {
    String reason = "";

    final bool cond1 = rxProfilePictureURLs.value.isNotEmpty;
    final bool cond2 = rxProfilePicturePath.value.isNotEmpty;
    final bool cond3 = rxFirstName.value.isNotEmpty;
    final bool cond4 = AppRegex().isValidNameRegex(rxFirstName.value);
    final bool cond5 = rxLastName.value.isNotEmpty;
    final bool cond6 = AppRegex().isValidNameRegex(rxLastName.value);
    final bool cond7 = rxEmailAddress.value.isEmpty;
    final bool cond8 = rxEmailAddress.value.isEmail;

    if (!cond1 && !cond2) {
      reason = "Please upload your profile picture.";
    } else if (!cond3) {
      reason = "Please enter your first name.";
    } else if (!cond4) {
      reason = "Please enter your valid first name.";
    } else if (!cond5) {
      reason = "Please enter your last name.";
    } else if (!cond6) {
      reason = "Please enter your valid last name.";
    } else if (!cond7) {
      if (!cond8) {
        reason = "Please enter your valid email address.";
      } else {}
    } else {}

    return reason;
  }

  Future<void> editProfileFieldsAPICall({
    required dynamic Function(Map<String, dynamic>) successCallback,
    required dynamic Function(Map<String, dynamic>) failureCallback,
  }) async {
    final Map<String, dynamic> body = <String, dynamic>{
      "firstName": rxFirstName.value.trim(),
      "lastName": rxLastName.value.trim(),
    };

    if (rxEmailAddress.value.isNotEmpty) {
      body.addAll(<String, dynamic>{"email": rxEmailAddress.value.trim()});
    } else {}

    await AppAPIService().functionPatch(
      types: Types.oauth,
      endPoint: "user",
      body: body,
      successCallback: successCallback,
      failureCallback: failureCallback,
    );
    return Future<void>.value();
  }

  Future<void> editProfileFilesAPICall({
    required dynamic Function(Map<String, dynamic>) successCallback,
    required dynamic Function(Map<String, dynamic>) failureCallback,
  }) async {
    if (rxProfilePicturePath.value.isNotEmpty) {
      final FormData formData = FormData(<String, dynamic>{});

      formData.files.add(
        MapEntry<String, MultipartFile>(
          "profilePhoto",
          AppGetMultipartFile().getFile(
            filePath: rxProfilePicturePath.value.trim(),
          ),
        ),
      );

      await AppAPIService().functionPatch(
        types: Types.oauth,
        endPoint: "profile/photo",
        successCallback: successCallback,
        failureCallback: failureCallback,
        isForFileUpload: true,
        formData: formData,
      );
    } else {}
    return Future<void>.value();
  }
}
