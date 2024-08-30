import "dart:async";

import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";
import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_perm_service.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_constants.dart";
import "package:customer/utils/app_feature_overlay.dart";
import "package:customer/utils/app_intro_bottom_sheet.dart";
import "package:feature_discovery/feature_discovery.dart";
import "package:get/get.dart";
import "package:permission_handler/permission_handler.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

Future<void> tabControllerFunction(int value) async {
  final MainNavigationController find = Get.find<MainNavigationController>();
  final PersistentTabController tabController = find.tabController;

  // ignore: cascade_invocations
  tabController.jumpToTab(value);

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
  void onReady() {
    super.onReady();

    FeatureDiscovery.discoverFeatures(
      Get.key.currentState!.context,
      <String>{
        featureTopProfile,
        featureTopWishList,
        featureTopCartList,
        featurBottomHome,
        featurBottomCategory,
        featurBottomBooking,
        featurBottomLive,
        featurBottomOrderHistory,
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
    unawaited(wishListAndCartListAPICall());
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

    final bool cond1 = AppConstants().isEnabledReviewNotificationPermInHome;

    if (cond1) {
      await reviewNotificationPermissionStatus();
    } else {}

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

  Future<bool> checkNotificationFunction() async {
    final PermissionStatus isGranted = await Permission.notification.status;

    final bool value = isGranted == PermissionStatus.granted;
    return Future<bool>.value(value);
  }

  Future<void> requestNotificationFunction() async {
    await AppPermService().permissionNotification();
    return Future<void>.value();
  }

  String greet() {
    // final int timeNow = DateTime.now().hour;
    // if (timeNow <= 12) {
    //   return "Good morning!";
    // } else if ((timeNow > 12) && (timeNow <= 16)) {
    //   return "Good afternoon!";
    // } else if ((timeNow > 16) && (timeNow < 20)) {
    //   return "Good evening!";
    // } else {
    //   return "Good evening!";
    // }
    return "Welcome!";
  }
}
