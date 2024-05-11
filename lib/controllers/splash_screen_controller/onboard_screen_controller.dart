import "dart:async";

import "package:get/get_state_manager/src/simple/get_controllers.dart";
// import "package:telephony/telephony.dart";

class OnBoardScreenController extends GetxController {
  int _currentPage = 0;
  late Timer _timer;
  // final Telephony telephony = Telephony.instance;

  int get currentPage => _currentPage;

  @override
  void onInit() {
    super.onInit();
    // telephony.listenIncomingSms(
    //   onNewMessage: (SmsMessage message) {
    //   },
    //   listenInBackground: false,
    // );
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      update();
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

}
