import "package:get/get.dart";
import "package:get/get_state_manager/src/simple/get_controllers.dart";

class SelectedSlotController extends GetxController {
  RxInt selectedOption = 1.obs;

  void setSelectedOption(int value) {
    selectedOption(value);
  }

}
