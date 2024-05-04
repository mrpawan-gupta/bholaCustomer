import "package:get/get.dart";

class AccountController extends GetxController {
  RxInt counter = 0.obs;

  void increment() {
    final int currentValue = counter.value;
    final int newValue = currentValue + 1;
    counter(newValue);
    return;
  }

  void decrement() {
    final int currentValue = counter.value;
    final int newValue = currentValue - 1;
    counter(newValue);
    return;
  }
}
