import "package:get/get.dart";

class BookSlotController extends GetxController {

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  RxString dropDownValue = "".obs;
  RxInt value = RxInt(-1);
  RxDouble sliderSel = 10.0.obs;

  void updateSelectedDate(DateTime date) {
    selectedDate(date);
  }

  void updateDropDownValue(String val) {
    dropDownValue(val);
  }


  void updateValue(val) {
    if (val is bool && !val) {
      value(-1);
    } else {
      value(val ?? -1);
    }
  }


  void updateSliderValue(double value) {
    sliderSel(value);
  }

}
