import "dart:async";

import "package:customer/utils/app_logger.dart";
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
    _counter.listen(
      callback,
      // ignore: always_specify_types
      onError: (error, stackTrace) {
        AppLogger().error(
          message: "Exception caught",
          error: error,
          stackTrace: stackTrace,
        );
      },
      cancelOnError: false,
      onDone: () async {
        AppLogger().info(message: "RentalBookingStream: onDone called");
      },
    );
  }

  void closeResources() {
    unawaited(_counter.close());

    return;
  }
}
