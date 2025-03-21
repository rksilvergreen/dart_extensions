import 'dart:math';

extension intListExtension on List<int> {
  int rand() {
    if (length != 2) throw ('rand() should only be called on lists of length 2');
    int min = first;
    int max = last;
    int delta = max - min;
    return min + Random().nextInt(delta + 1);
  }
}