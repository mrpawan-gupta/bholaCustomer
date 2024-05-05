import "package:get/get_state_manager/src/simple/get_controllers.dart";

class ProductDetailPageController extends GetxController {
  bool descTextShowFlag = false;

  void toggleDescTextShowFlag() {
    descTextShowFlag = !descTextShowFlag;
    update();
  }

}
