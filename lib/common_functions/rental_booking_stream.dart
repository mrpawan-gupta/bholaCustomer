import "dart:async";

import "package:rxdart/rxdart.dart";

class RentalBookingStream {
  factory RentalBookingStream() {
    return _singleton;
  }

  RentalBookingStream._internal();

  static final RentalBookingStream _singleton = RentalBookingStream._internal();

  final BehaviorSubject<String> _counter = BehaviorSubject<String>()..add("");

  String get counter => _counter.value;
  set counter(String value) => _counter.sink.add(value);

  void functionSinkAdd({required String id}) {
    counter = id;
    return;
  }

  void subscribe({required Function(String id) callback}) {
    _counter.listen(callback);
  }

  void closeResources() {
    unawaited(_counter.close());
    return;
  }
}
