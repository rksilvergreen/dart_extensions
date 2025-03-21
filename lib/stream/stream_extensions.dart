import 'dart:async';

extension StreamExtension<T> on Stream<T> {
  Stream<E> contract<E>(E convert(T t)) => asyncExpand<E>((t) {
        E e = convert(t);
        return Stream.fromIterable((e == null) ? [] : [e]);
      });

  FutureOr<T?>? firstWhereX(bool test(T element)) async {
    T? t;
    try {
      t = await firstWhere(test);
    } on StateError {
      return null;
    }
    return t;
  }

  Stream<E> whereType<E extends T>() => where((e) => e is E).cast<E>();
}

extension StackMethod<T> on Stream<T> {
  StreamStack<T> stack() => StreamStack._(this);
}

/// Should be queue
class StreamStack<T> {
  StreamController<T> _streamController = StreamController<T>.broadcast();
  StreamSubscription? _streamSubscription;
  final List<T> stack = [];
  bool _flushing = false;

  StreamController<bool> _waitingForPushController = StreamController<bool>.broadcast();
  bool _waitingForPush = false;

  StreamStack._(Stream<T> stream) {
    _streamSubscription = stream.listen((x) {
      stack.add(x);
      _streamController.add(x);
    }, onDone: () {
      _streamController.close();
    });
  }

  Future<T?> push({Duration timeOutDuration = const Duration(seconds: 1)}) async {
    if (stack.isEmpty) {
      _waitingForPush = true;
      _waitingForPushController.add(true);
      Future<T> future = _streamController.stream.first.catchError((_) => null);
      T x = await future;
      _waitingForPush = false;
      _waitingForPushController.add(false);
      if (x == null) return null;
    }
    return stack.removeAt(0);
  }

  Future<void> flush(FutureOr<void> Function(T) callback,
      {Duration timeOutDuration = const Duration(seconds: 1)}) async {
    _flushing = true;
    while (_flushing) {
      T? x = await push(timeOutDuration: timeOutDuration);
      if (x != null)
        await callback(x);
      else
        _flushing = false;
    }
  }

  void stopFlush() => _flushing = false;

  void close() async {
    stopFlush();
    if (_waitingForPush) await _waitingForPushController.stream.firstWhere((e) => !e);
    _streamController.close();
    _streamSubscription?.cancel();
    _waitingForPushController.close();
  }
}

extension HistogramMethod<T> on Stream<T> {
  StreamHistogram<T> histogram({void Function(StreamHistogram<T>)? onFeedStop}) => StreamHistogram._(this, onFeedStop);
}

class StreamHistogram<T> {
  Map<T, int> map = {};
  List<StreamController<T>> _streamControllers = [];
  List<StreamSubscription<T>> _streamSubscriptions = [];
  final FutureOr<void> Function(StreamHistogram<T>)? onFeedStop;

  StreamHistogram._(Stream<T> stream, this.onFeedStop) {
    feedFromStream(stream);
  }

  void _add(T key) => map[key] = map.containsKey(key) ? map[key]! + 1 : 1;

  void feedFromStream(Stream<T> keyStream) {
    StreamController<T> streamController = StreamController<T>();
    _streamControllers.add(streamController);
    StreamSubscription<T> streamSubscription = keyStream.listen((e) => streamController.add(e));
    _streamSubscriptions.add(streamSubscription);
    streamController.stream.listen((key) => _add(key));
  }

  Future<void> stopFeed() async {
    _streamControllers.forEach((streamController) => streamController.close());
    _streamSubscriptions.forEach((streamSubscription) => streamSubscription.cancel());
    await onFeedStop?.call(this);
  }
}

extension StreamExtensions<T> on Stream<T> {
  Stream<T> whereValues(List<T> values) => this.where((v) => values.contains(v));
}
