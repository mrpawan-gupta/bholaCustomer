import "package:customer/models/get_user_by_id.dart";
import "package:customer/models/verify_otp.dart";
import "package:customer/services/app_api_service.dart";
import "package:customer/services/app_dev_info_service.dart";
import "package:customer/services/app_nav_service.dart";
import "package:customer/services/app_pkg_info_service.dart";
import "package:customer/services/app_storage_service.dart";
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

  String initialRoute() {
    final bool value = isUserLoggedIn();
    return value
        ? AppRoutes().mainNavigationScreen
        : AppRoutes().languageSelectionScreen;
  }

  Future<void> performSignIn() async {
    final GetUserByIdData userInfo = await AppSession().getUserAPICall();
    await AppSession().setUserInfo(userInfo: userInfo);

    await AppPkgInfoService().updateInfoToFirestore();
    await AppDevInfoService().updateInfoToFirestore();

    await AppNavService().pushNamedAndRemoveUntil(
      destination: AppRoutes().mainNavigationScreen,
      arguments: <String, dynamic>{},
    );
    return Future<void>.value();
  }

  Future<void> performSignOut() async {
    await AppStorageService().erase();

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
    GetUserByIdData userInfo = GetUserByIdData();

    final String id = AppStorageService().getUserAuthModel().sId ?? "";

    if (id.isNotEmpty) {
      await AppAPIService().functionGet(
        types: Types.oauth,
        endPoint: "user/$id",
        successCallback: (Map<String, dynamic> json) {
          GetUserById getUserById = GetUserById();
          getUserById = GetUserById.fromJson(json);

          userInfo = getUserById.data ?? GetUserByIdData();
        },
        failureCallback: (Map<String, dynamic> json) {},
      );
    } else {}
    return Future<GetUserByIdData>.value(userInfo);
  }
}
