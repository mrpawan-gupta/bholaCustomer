import "dart:async";

import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_assets_images.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:get/get.dart";
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

  int getCurrentIndex() {
    return tabController.index;
  }

  void jumpToTab(int index) {
    return tabController.jumpToTab(index);
  }
}
