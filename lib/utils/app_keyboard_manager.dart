import "package:flutter/widgets.dart";
import "package:keyboard_dismisser/keyboard_dismisser.dart";

class AppKeyboardManager {
  factory AppKeyboardManager() {
    return _singleton;
  }

  AppKeyboardManager._internal();
  static final AppKeyboardManager _singleton = AppKeyboardManager._internal();

  Widget globalKeyboardDismisser({required Widget child}) {
    return KeyboardDismisser(child: child);
  }
}
