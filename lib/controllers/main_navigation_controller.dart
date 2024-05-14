import "package:customer/controllers/outer_main_controllers/help_controller.dart";
import "package:customer/controllers/outer_main_controllers/home_controller.dart";
import "package:customer/controllers/outer_main_controllers/new_order_controller.dart";
import "package:customer/controllers/outer_main_controllers/order_history_controller.dart";
import "package:customer/controllers/outer_main_controllers/portfolio_controller.dart";
import "package:customer/utils/app_whatsapp.dart";
import "package:get/get.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";


class MainNavigationController extends GetxController {
  final PersistentTabController tabController = PersistentTabController();
  final RxInt previousIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    Get
      ..put(HomeController())
      ..put(PortfolioController())
      ..put(NewOrderController())
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
  }

  @override
  void onClose() {
    tabController.dispose();

    super.onClose();
  }
}
