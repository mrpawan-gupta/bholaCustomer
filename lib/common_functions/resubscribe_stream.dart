// ignore_for_file: cancel_subscriptions, discarded_futures, always_specify_types, always_put_control_body_on_new_line, cascade_invocations, prefer_final_locals, lines_longer_than_80_chars

import "dart:async";

/// Allows a stream to be listened to multiple times.
///
/// Returns a new stream which has the same events as [source],
/// but which can be listened to more than once.
/// Only allows one listener at a time, but when a listener
/// cancels, another can start listening and take over the stream.
///
/// If the [source] is a broadcast stream, the listener on
/// the source is cancelled while there is no listener on the
/// returned stream.
/// If the [source] is not a broadcast stream, the subscription
/// on the source stream is maintained, but paused, while there
/// is no listener on the returned stream.
///
/// Only listens on the [source] stream when the returned stream
/// is listened to.

Stream<T> resubscribeStream<T>(Stream<T> source) {
  MultiStreamController<T>? current;
  StreamSubscription<T>? sourceSubscription;
  bool isDone = false;
  void add(T value) {
    current!.addSync(value);
  }

  void addError(Object error, StackTrace stack) {
    current!.addErrorSync(error, stack);
  }

  void close() {
    isDone = true;
    current!.close();
    current = null;
    sourceSubscription = null;
  }

  return Stream<T>.multi((controller) {
    if (isDone) {
      controller.close(); // Or throw StateError("Stream has ended");
      return;
    }
    if (current != null) throw StateError("Has listener");
    current = controller;
    var subscription = sourceSubscription ??=
        source.listen(add, onError: addError, onDone: close);
    subscription.resume();
    controller
      ..onPause = subscription.pause
      ..onResume = subscription.resume
      ..onCancel = () {
        current = null;
        if (source.isBroadcast) {
          sourceSubscription = null;
          return subscription.cancel();
        }
        subscription.pause();
        return null;
      };
  });
}
