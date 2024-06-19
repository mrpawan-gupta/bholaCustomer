import "dart:async";

import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_location_service.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_intro_bottom_sheet.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:get/get.dart";
import "package:location/location.dart" as loc;
import "package:permission_handler/permission_handler.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

Future<void> tabControllerFunction(int value) async {
  final MainNavigationController find = Get.find<MainNavigationController>();
  final PersistentTabController tabController = find.tabController;

  if (value != 3) {
    tabController.jumpToTab(value);
  } else {
    await AppWhatsApp().openWhatsApp();
    tabController.jumpToPreviousTab();
  }
  return Future<void>.value();
}

class MainNavigationController extends GetxController {
  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;

  final RxBool rxHasReviewed = false.obs;

  late Timer _timer;

  RxList<String> list = <String>[
    AppAssetsImages().bottomNavTruck,
    AppAssetsImages().bottomNavDrone,
    AppAssetsImages().bottomNavJCB,
  ].obs;

  RxString timerCurrent = AppAssetsImages().bottomNavTruck.obs;

  final PersistentTabController tabController = PersistentTabController();

  @override
  void onInit() {
    super.onInit();

    Get
      ..put(HomeController())
      ..put(CategoryController())
      ..put(BookingController())
      ..put(HelpController())
      ..put(OrderHistoryController());

    initAndReInitFunction();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) async {
        if (rxHasReviewed.value) {
        } else {
          await reviewPermissionStatus();
        }

        if (timerCurrent.value == list[0]) {
          timerCurrent(list[1]);
        } else if (timerCurrent.value == list[1]) {
          timerCurrent(list[2]);
        } else if (timerCurrent.value == list[2]) {
          timerCurrent(list[0]);
        } else {}
      },
    );
  }

  @override
  void onClose() {
    _timer.cancel();

    super.onClose();
  }

  void initAndReInitFunction() {
    updateUserInfo(AppStorageService().getUserInfoModel());
    return;
  }

  void updateUserInfo(GetUserByIdData value) {
    rxUserInfo(value);
    return;
  }

  void updateHasReviewed({required bool value}) {
    rxHasReviewed(value);
    return;
  }

  int getCurrentIndex() {
    return tabController.index;
  }

  void jumpToTab(int index) {
    return tabController.jumpToTab(index);
  }

  Future<void> reviewPermissionStatus() async {
    updateHasReviewed(value: true);

    await reviewNotificationPermissionStatus();
    await reviewLocationPermissionStatus();

    return Future<void>.value();
  }

  Future<void> reviewNotificationPermissionStatus() async {
    final bool try0 = await checkNotificationFunction();
    if (try0 == true) {
    } else {
      await AppIntroBottomSheet().openNotificationSheet(
        onContinue: () async {
          await requestNotificationFunction();
        },
      );
    }

    return Future<void>.value();
  }

  Future<void> reviewLocationPermissionStatus() async {
    final bool try0 = await checkLocationFunction();
    if (try0 == true) {
      await AppLocationService().automatedFunction();
    } else {
      await AppIntroBottomSheet().openLocationSheet(
        onContinue: () async {
          await requestLocationFunction();

          final bool try1 = await checkLocationFunction();
          if (try1 == true) {
            await AppLocationService().automatedFunction();
          } else {}
        },
      );
    }

    return Future<void>.value();
  }

  Future<bool> checkNotificationFunction() async {
    final PermissionStatus isGranted = await Permission.notification.status;

    final bool value = isGranted == PermissionStatus.granted;
    return Future<bool>.value(value);
  }

  Future<void> requestNotificationFunction() async {
    await AppPermService().permissionNotification();
    return Future<void>.value();
  }

  Future<bool> checkLocationFunction() async {
    final loc.PermissionStatus status = await loc.Location().hasPermission();
    final bool isGranted = status == loc.PermissionStatus.granted;
    final bool isGrantedLimited = status == loc.PermissionStatus.grantedLimited;

    final bool hasPermission = isGranted || isGrantedLimited;
    final bool serviceEnable = await loc.Location().serviceEnabled();

    final bool value = hasPermission && serviceEnable;
    return Future<bool>.value(value);
  }

  Future<void> requestLocationFunction() async {
    await AppPermService().permissionLocation();
    await AppPermService().serviceLocation();
    return Future<void>.value();
  }
}
