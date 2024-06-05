import "dart:async";

import "package:customer/models/get_user_by_id.dart";
import "package:customer/models/verify_otp.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_dev_info_service.dart";
import "package:customer/services/app_fcm_service.dart";
import "package:customer/services/app_location_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_pkg_info_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_loader.dart";
import "package:customer/utils/app_logger.dart";
import "package:customer/utils/app_routes.dart";

class AppSession {
  factory AppSession() {
    return _singleton;
  }

  AppSession._internal();
  static final AppSession _singleton = AppSession._internal();

  bool isUserLoggedIn() {
    final bool hasUserAuth = AppStorageService().getUserAuth().isNotEmpty;
    final bool hasUserInfo = AppStorageService().getUserInfo().isNotEmpty;
    return hasUserAuth && hasUserInfo;
  }

  Future<void> performSignIn() async {
    AppLoader().showLoader();

    final GetUserByIdData userInfo = await AppSession().getUserAPICall();
    await AppSession().setUserInfo(userInfo: userInfo);

    await AppPkgInfoService().updateInfoToFirestore();
    await AppDevInfoService().updateInfoToFirestore();
    await AppLocationService().automatedFunction();

    final String id = AppStorageService().getUserAuthModel().sId ?? "";
    await AppFCMService().subscribeToTopic(id: id);

    AppLoader().hideLoader();

    await AppNavService().pushNamedAndRemoveUntil(
      destination: AppRoutes().mainNavigationScreen,
      arguments: <String, dynamic>{},
    );
    return Future<void>.value();
  }

  Future<void> performSignOut() async {
    AppLoader().showLoader();

    final String id = AppStorageService().getUserAuthModel().sId ?? "";
    await AppFCMService().unsubscribeFromTopic(id: id);

    await AppStorageService().erase();

    AppLoader().hideLoader();

    await AppNavService().pushNamedAndRemoveUntil(
      destination: AppRoutes().splashScreen,
      arguments: <String, dynamic>{},
    );
    return Future<void>.value();
  }

  Future<void> setUserAuth({required VerifyOTPModelData userAuth}) async {
    await AppStorageService().setUserAuth(userAuth);
    return Future<void>.value();
  }

  Future<void> setUserInfo({required GetUserByIdData userInfo}) async {
    await AppStorageService().setUserInfo(userInfo);
    return Future<void>.value();
  }

  Future<GetUserByIdData> getUserAPICall() async {
    final Completer<GetUserByIdData> completer = Completer<GetUserByIdData>();

    final String id = AppStorageService().getUserAuthModel().sId ?? "";

    if (id.isNotEmpty) {
      await AppAPIService().functionGet(
        types: Types.oauth,
        endPoint: "user/$id",
        successCallback: (Map<String, dynamic> json) {
          AppLogger().info(message: json["message"]);

          GetUserById getUserById = GetUserById();
          getUserById = GetUserById.fromJson(json);

          completer.complete(getUserById.data ?? GetUserByIdData());
        },
        failureCallback: (Map<String, dynamic> json) {
          AppLogger().error(message: json["message"]);

          completer.complete(GetUserByIdData());
        },
        needLoader: false,
      );
    } else {
      completer.complete(GetUserByIdData());
    }

    return completer.future;
  }
}
