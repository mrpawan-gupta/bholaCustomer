import "dart:async";
import "package:flutter/material.dart";

class AppDebouncer {
  factory AppDebouncer() {
    return _singleton;
  }

  AppDebouncer._internal();
  static final AppDebouncer _singleton = AppDebouncer._internal();

  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  void debounce(VoidCallback action) {
    _debouncer.run(action);
  }
}

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    } else {}

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
