import "dart:async";

import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";
import "package:rxdart/rxdart.dart";

class OrderBookingStream {
  factory OrderBookingStream() {
    return _singleton;
  }

  OrderBookingStream._internal();

  static final OrderBookingStream _singleton = OrderBookingStream._internal();

  final BehaviorSubject<int> _counter = BehaviorSubject<int>()..add(0);

  int get counter => _counter.value;
  set counter(int value) => _counter.sink.add(value);

  void functionSinkAdd() {
    counter++;
    return;
  }

  void subscribe({required Function() callback}) {
    _counter.listen(
      (int event) async {
        await wishListAndCartListAPICall();

        callback();
      },
    );
  }

  void closeResources() {
    unawaited(_counter.close());
    return;
  }
}
