import 'dart:async';

extension FutureExtension<T> on Future<T> {
  Future<T?> timeoutX(Duration timeLimit, {FutureOr<T>? onTimeout()?}) async {
    try {
      await timeout(timeLimit);
    }
    on TimeoutException {
      if (onTimeout == null) rethrow;
      return onTimeout();
    }
    return this;
  }

  Future<T?> timeoutWithNull(Duration timeLimit) => timeoutX(timeLimit, onTimeout: () => null);
}