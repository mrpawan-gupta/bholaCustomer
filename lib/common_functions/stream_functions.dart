import "dart:async";

import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";
import "package:customer/common_functions/resubscribe_stream.dart";

final StreamController<void> streamController = StreamController<void>();

final Stream<void> stream = resubscribeStream(streamController.stream);

StreamSubscription<void>? streamSubscription;

void functionSinkAdd() {
  streamController.sink.add(null);
}

void subscribe({required Function() callback}) {
  streamSubscription = stream.listen(
    (void event) {
      unawaited(wishListAndCartListAPICall());
      callback();
    },
  );
}

void unsubscribe() {
  unawaited(streamController.sink.close());
  unawaited(streamSubscription?.cancel());
  return;
}
