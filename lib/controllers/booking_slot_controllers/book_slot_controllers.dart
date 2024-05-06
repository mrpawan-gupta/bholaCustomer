import "package:get/get.dart";

class BookSlotController extends GetxController {

  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  RxString dropDownValue = RxString("");
  RxInt value = RxInt(-1);
  RxDouble sliderSel = RxDouble(10.0);

  // Method to update the selected date
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateDropDownValue(String val) {
    dropDownValue.value = val;
  }

  // Method to update the selected value
  void updateValue(int? val) {
    value.value = val ?? -1;
  }

  // Method to update the selected slider value
  void updateSliderValue(double value) {
    sliderSel.value = value;
  }

}
