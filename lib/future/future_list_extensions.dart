import 'dart:async';

extension FutureListsExtension on List<Future> {
  Future waitForFirst() async => Stream.fromFutures(this).first;
  Future waitForLast() async => Future.wait(this);
}
