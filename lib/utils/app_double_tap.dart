import "package:customer/utils/app_snackbar.dart";

class AppDoubleTap {
  factory AppDoubleTap() {
    return _singleton;
  }

  AppDoubleTap._internal();
  static final AppDoubleTap _singleton = AppDoubleTap._internal();

  final Duration duration = const Duration(seconds: 2);
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    bool value = true;
    final DateTime now = DateTime.now();
    final bool cond1 = currentBackPressTime == null;
    final bool cond2 = now.difference(currentBackPressTime ?? now) > duration;
    if (cond1 || cond2) {
      AppSnackbar().snackbarWarning(
        title: "Leave?",
        message: "Tap back again to leave",
      );
      currentBackPressTime = now;
      value = false;
    } else {}
    return Future<bool>.value(value);
  }
}
