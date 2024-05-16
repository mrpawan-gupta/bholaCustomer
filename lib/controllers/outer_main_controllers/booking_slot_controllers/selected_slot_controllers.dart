import "package:get/get.dart";

class SelectedSlotController extends GetxController {
  RxInt selectedOption = 1.obs;

  void setSelectedOption(int value) {
    selectedOption(value);
  }

}
