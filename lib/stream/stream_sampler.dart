import 'dart:async';
import 'dart:collection';
import 'package:dart_extensions/list/fixed_length_queue.dart';

abstract class StreamSampler<S, T> extends StreamTransformerBase<S, T> {
  StreamController<T>? _controller;

  StreamSubscription? _subscription;

  bool cancelOnError;

  Stream<S>? _stream;

  final int sampleEvery;
  final int? numOfMaxSamples;
  final bool storeSamples;
  final bool measureSampleIntervals;

  List<S>? _samples;
  List<int>? _sampleIntervals; // microseconds
  int _counter = 0;
  DateTime? _prevDateTime;
  DateTime? _currDateTime;

  StreamSampler(
    bool broadcast,
    bool sync,
    this.cancelOnError,
    int sampleEvery,
    this.numOfMaxSamples,
    bool storeSamples,
    bool measureSampleIntervals,
  )   : assert(numOfMaxSamples != 0),
        sampleEvery = sampleEvery,
        storeSamples = storeSamples,
        measureSampleIntervals = measureSampleIntervals{
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

    if (numOfMaxSamples != null) {
      _samples = FixedLengthQueue(numOfMaxSamples!);
      _sampleIntervals = FixedLengthQueue(numOfMaxSamples!);
    } else {
      _samples = [];
      _sampleIntervals = [];
    }
  }

  void _onListen() {
    _subscription = _stream?.listen(_onData, onError: _controller?.addError, onDone: _controller?.close, cancelOnError: cancelOnError);
  }

  void _onCancel() {
    _subscription?.cancel();
    _subscription = null;
  }

  bool get sample {
    _counter++;
    if (_counter == sampleEvery) {
      _counter = 0;
      return true;
    }
    return false;
  }

  void _onData(S data) {
    int? interval;
    if (sample) {
      if (storeSamples) _samples?.add(data);
      if (measureSampleIntervals) {
        if (_currDateTime != null) {
          _prevDateTime = _currDateTime;
          _currDateTime = DateTime.now();
          interval = (_currDateTime?.microsecondsSinceEpoch)! - (_prevDateTime?.microsecondsSinceEpoch)!;
        } else {
          _currDateTime = DateTime.now();
          interval = 0;
        }
        _sampleIntervals?.add(interval);
      }
    }
    onData(data, interval, UnmodifiableListView(_samples!), UnmodifiableListView(_sampleIntervals!));
  }

  void onData(
    S data,
    int? lastInterval,
    List<S> samples,
    List<int> sampleIntervals,
  );

  void add(T transformedData) => _controller?.add(transformedData);

  Stream<T> bind(Stream<S> stream) {
    this._stream = stream;
    return (_controller?.stream)!;
  }
}
