import "dart:async";

import "package:customer/common_functions/cart_list_and_wish_list_functions.dart";

final StreamController<void> broadcast = StreamController<void>.broadcast();
final StreamController<void> wishStrCont = broadcast;
final StreamController<void> cartStrCont = broadcast;

final Stream<void> wishStream = wishStrCont.stream;
final Stream<void> cartStream = cartStrCont.stream;

StreamSubscription<void>? wishStreamSubscription;
StreamSubscription<void>? cartStreamSubscription;

void functionWishSinkAdd() {
  wishStrCont.sink.add(null);
}

void functionCartSinkAdd() {
  cartStrCont.sink.add(null);
}

void subscribeWish({required Function() callback}) {
  wishStreamSubscription = wishStream.listen(
    (void event) async {
      await wishListAndCartListAPICall();

      callback();
    },
  );
}

void subscribeCart({required Function() callback}) {
  cartStreamSubscription = cartStream.listen(
    (void event) async {
      await wishListAndCartListAPICall();

      callback();
    },
  );
}

void unsubscribeWish() {
  unawaited(wishStreamSubscription?.cancel());
}

void unsubscribeCart() {
  unawaited(cartStreamSubscription?.cancel());
}
