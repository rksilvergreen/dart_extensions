import 'dart:async';

extension MapIndexed<E> on List<E> {
  List<T> mapIndexed<T>(T fn(E v, int i, List a)) => this.asMap().map((i, v) => MapEntry(i, fn(v, i, this))).values.toList();
}

extension WhereIndexed<E> on List<E> {
  List<E?> whereIndexed(bool fn(E v, int i, List a)) =>
      asMap().map<int,E?>((i, v) => fn(v, i, this) ? MapEntry(i, v) : MapEntry(i, null)).values.where((e) => e != null).toList();
}

extension ForEachIndexed<T> on List<T> {
  void forEachIndexed(Function(T v, int i, List a) fn) {
    this.asMap().forEach((i, v) {
      fn(v, i, this);
    });
  }
}

extension ExpandIndexed<E> on List<E> {
  List<T> expandIndexed<T>(List<T> fn(E v, int i, List a)) =>
      this.asMap().map((i, v) => MapEntry(i, fn(v, i, this))).values.expand((e) => e).toList();
}

extension RemoveFirst<E> on List<E> {
  E removeFirst() => this.removeAt(0);
}

extension ListExtensions<T> on List<T> {
  T? getNext(T element, {bool cyclical = true}) {
    int indexOfElement = this.indexOf(element);
    return (indexOfElement + 1 == this.length) ? (cyclical ? this[0] : null) : this[indexOfElement + 1];
  }

  List<T> without(T t) => notIn([t]);

  List<T> withoutFirst([int n = 1]) => sublist(n);

  List<T> withoutLast([int n = 1]) => sublist(0, this.length - n);

  void addFirst(T element) => insert(0, element);

  void addIfNotNull(T? value) {
    if (value != null) {
      add(value);
    }
  }

  List<T> notIn(Iterable iterable) => where((element) => !iterable.contains(element)).toList();

  List<T> notInWhere<E>(Iterable<E> iterable, bool Function(T a, E b) fn) => where((m) => iterable.every((n) => !fn(m, n))).toList();

  Future<List<E>> mapAsync<E>(FutureOr<E> f(T element)) async {
    List<E> list = [];
    await Future.forEach(this, (T t) async => list.add(await f(t)));
    return list;
  }

  Future<List<E>> expandAsync<E>(FutureOr<Iterable<E>> f(T element)) async {
    List<E> list = [];
    await Future.forEach(this, (T t) async => list.addAll(await f(t)));
    return list;
  }

  List<T> removeWhile(bool Function(T v) fn, {bool fromEnd = false}) {
    if (!fromEnd) {
      for (int i = 0; i < length; i++) {
        if (!fn(this[i])) return sublist(i);
      }
    } else {
      for (int i = length - 1; i >= 0; i--) {
        if (!fn(this[i])) return sublist(0, i + 1);
      }
    }
    return [];
  }

  void replaceAt(int index, T value) => replaceRange(index, index + 1, [value]);

  void replaceFirstWhere(bool Function(T t) fn, T value) => replaceAt(indexWhere(fn), value);

// Iterable<T> insertEvery( T Function(int) fn, int numOfElements, [bool includeFirst = false, bool includeLast = false]) {
//   Iterable<List<T>> chunks = chunked(numOfElements);
//   int tsToZip = includeLast ? chunks.length : chunks.length - 1;
//   List<T> tList = List.generate(tsToZip, (i) => t)
//
// }
}
