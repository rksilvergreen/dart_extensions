import 'dart:async';

abstract class BasicStreamTransformer<S,T> extends StreamTransformerBase<S, T> {
  StreamController<T>? _controller;

  StreamSubscription? _subscription;

  bool cancelOnError;

  Stream<S>? _stream;

  BasicStreamTransformer(
    bool broadcast,
    bool sync,
    this.cancelOnError,
  ) {
    _controller = broadcast
        ? StreamController<T>.broadcast(onListen: _onListen, onCancel: _onCancel, sync: sync)
        : StreamController<T>(
        onListen: _onListen,
        onCancel: _onCancel,
        onPause: () {
          _subscription?.pause();
        },
        onResume: () {
          _subscription?.resume();
        },
        sync: sync);
  }

  void _onListen() {
    _subscription = _stream?.listen(onData, onError: _controller?.addError, onDone: _controller?.close, cancelOnError: cancelOnError);
  }

  void _onCancel() {
    _subscription?.cancel();
    _subscription = null;
  }

  void onData(S data);

  void add(T transformedData) => _controller?.add(transformedData);

  Stream<T> bind(Stream<S> stream) {
    this._stream = stream;
    return (_controller?.stream)!;
  }
}
