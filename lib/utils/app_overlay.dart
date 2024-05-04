import "package:flutter/widgets.dart";
import "package:overlay_support/overlay_support.dart";

class AppOverlay {
  factory AppOverlay() {
    return _singleton;
  }

  AppOverlay._internal();
  static final AppOverlay _singleton = AppOverlay._internal();

  Widget globalOverlaySupport({required Widget child}) {
    return OverlaySupport.global(child: child);
  }
}
