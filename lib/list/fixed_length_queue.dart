import 'dart:collection';

class FixedLengthQueue<T> extends ListBase<T> {
  final List<T> _list = [];
  final int maxLength;

  void set length(int newLength) {
    _list.length = newLength;
  }

  int get length => _list.length;

  T operator [](int index) => _list[index];

  void operator []=(int index, T value) {
    _list[index] = value;
  }

  @override
  void add(T value) {
    if (length < maxLength)
      _list.add(value);
    else
      _list..removeAt(0)..add(value);
  }

  FixedLengthQueue(this.maxLength);
}