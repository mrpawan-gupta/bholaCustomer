import "package:flutter/widgets.dart";
import "package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart";

class AppKeyboardManager {
  factory AppKeyboardManager() {
    return _singleton;
  }

  AppKeyboardManager._internal();
  static final AppKeyboardManager _singleton = AppKeyboardManager._internal();

  Widget globalKeyboardDismisser({required Widget child}) {
    return KeyboardDismissOnTap(
      dismissOnCapturedTaps: true,
      child: child,
    );
  }
}
