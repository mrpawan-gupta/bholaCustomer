import "package:customer/controllers/outer_main_controllers/booking_controller.dart";
import "package:customer/controllers/outer_main_controllers/category_controller.dart";
import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:customer/models/get_user_by_id.dart";
import "package:customer/services/app_storage_service.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

class MainNavigationController extends GetxController {
  final PersistentTabController tabController = PersistentTabController();
  final RxInt previousIndex = 0.obs;

  final Rx<GetUserByIdData> rxUserInfo = GetUserByIdData().obs;

  @override
  void onInit() {
    super.onInit();

    Get
      ..put(HomeController())
      ..put(CategoryController())
      ..put(BookingController())
      ..put(HelpController())
      ..put(OrderHistoryController());

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
