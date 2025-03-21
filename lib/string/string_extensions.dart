extension StringExtension on String {
  String get first => this[0];

  String get last => this[length - 1];

  String insertAt(String str, int i) =>
      (i >= 0) ? substring(0, i) + str + substring(i)
          : (i == -1) ? this + str : substring(0, length + i + 1) + str + substring(length + i + 1);

  String removeFirst([int n = 1]) => substring(n, length);

  String removeLast([int n = 1]) => substring(0, length - n);

  String removeFirstAndLast([int n = 1]) => removeFirst(n).removeLast(n);

  String removeAtIndex(int i) =>
      (i >= 0) ? substring(0, i) + substring(i + 1)
          : substring(0, length + i) + substring(length + i + 1);

  String removeFirstPattern(String str) => removeFirst(str.length);

  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';

  List<String> splitEvery(int num) {
    List<String> strings = [];
    for (int i = 0; i < length; i += num) {
      if (i + num < length)
        strings.add(substring(i, i + num));
      else
        strings.add(substring(i));
    }
    return strings;
  }

  String getUntilChar(String char, {bool including = true}) {
    assert(char.length == 1, 'char length must be exactly 1');
    int index = indexOf(char);
    return index == -1 ? this : substring(0, including ? index + 1 : index);
  }
}