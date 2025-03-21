import 'dart:collection';
import 'dart:math' as math;
import '../string/string_extensions.dart';

extension Flatten<E> on Iterable<Iterable<E>> {
  Iterable<E> flatten() => this.expand((e) => e);
}

extension IterableExtension<E> on Iterable<E> {
  String toCleanString([String joiner = ' ']) =>
      isEmpty ? '' : IterableBase.iterableToFullString(this).removeFirstAndLast().split(', ').join(joiner);

  Iterable<List<E>> chunked(int chunkSize) sync* {
    if (length <= 0) {
      yield [];
      return;
    }
    int skip = 0;
    while (skip < length) {
      final chunk = this.skip(skip).take(chunkSize);
      yield chunk.toList(growable: false);
      skip += chunkSize;
      if (chunk.length < chunkSize) return;
    }
  }

  Iterable<E> zipWith<T>(Iterable<E> b) sync* {
    final ita = this.iterator;
    final itb = b.iterator;
    bool hasA, hasB;
    while ((hasA = ita.moveNext()) | (hasB = itb.moveNext())) {
      if (hasA) yield ita.current;
      if (hasB) yield itb.current;
    }
  }

  bool equals(Iterable<E>? other) {
    if (other == null || this.length != other.length) return false;

    Iterator thisIterator = this.iterator;
    Iterator otherIterator = other.iterator;

    while (thisIterator.moveNext() && otherIterator.moveNext()) {
      dynamic thisElement = thisIterator.current;
      dynamic otherElement = otherIterator.current;

      if (thisElement is Iterable && otherElement is Iterable) {
        if (!thisElement.equals(otherElement)) return false;
      } else if (thisElement != otherElement) {
        return false;
      }
    }

    return true;
  }

  bool get hasItems => length > 0;

  E? firstWhereX(bool test(E element)) {
    E? e;
    try {
      e = firstWhere(test);
    } on StateError {
      return null;
    }
    return e;
  }

  T? firstWhereType<T extends E>() => firstWhereX((e) => e is T) as T?;
}

extension IterableNumExtension<T extends num> on Iterable<T> {
  T sum() => reduce((v, e) => (v + e) as T);

  double avg() => sum() / length;

  double std({double? avg}) {
    avg ??= this.avg();
    return math.sqrt(fold<num>(0, (a, b) => a + math.pow(b - avg!, 2)) / (length - 1));
  }

  double numOfStds(double x, {double? avg, double? std}) {
    avg ??= this.avg();
    std ??= this.std(avg: avg);
    return (x - avg).abs() / std;
  }

  bool isOutlier(double x, int stds, {double? avg, double? std}) {
    avg ??= this.avg();
    std ??= this.std(avg: avg);
    return numOfStds(x, avg: avg, std: std) > stds;
  }

  T get min => reduce(math.min);

  T get max => reduce(math.max);

  double? median() {
    if (isEmpty) {
      return null;
    }
    final sortedList = toList()..sort();
    final middle = length ~/ 2;
    if (length.isEven) {
      return (sortedList[middle - 1] + sortedList[middle]) / 2;
    } else {
      return sortedList[middle].toDouble();
    }
  }
}
