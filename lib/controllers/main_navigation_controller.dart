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

class MainNavigationController extends GetxController {
  final PersistentTabController tabController = PersistentTabController();
  final RxInt previousIndex = 0.obs;

  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;

  late Timer _timer;
  RxList<String> list = <String>[
    AppAssetsImages().bottomNavTruck,
    AppAssetsImages().bottomNavDrone,
    AppAssetsImages().bottomNavJCB,
  ].obs;
  RxString timerCurrent = AppAssetsImages().bottomNavTruck.obs;

  @override
  void onInit() {
    super.onInit();

    Get
      ..put(HomeController())
      ..put(CategoryController())
      ..put(BookingController())
      ..put(HelpController())
      ..put(OrderHistoryController());

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

    tabController.addListener(
      () async {
        if (tabController.index != 3) {
          previousIndex(tabController.index);
        } else {
          tabController.jumpToTab(previousIndex.value);
          await AppWhatsApp().openWhatsApp();
        }
      },
    );

    initAndReInitFunction();
  }

  @override
  void onClose() {
    _timer.cancel();
    tabController.dispose();

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
}
