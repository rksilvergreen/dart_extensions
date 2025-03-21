import 'dart:typed_data';

import 'package:test/test.dart';
import 'deep_values_methods.dart';

void main() {
  test("(Map deepValues) ||| ([X] deep maps [true] mapsAreDeep) ||| ([X] deep iterables [true] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': 2,
      'c': 3,
    };

    List deepValues = map.deepValues();
    expect(deepValues, [1, 2, 3]);
  });

  test("(Map deepValues) ||| ([V] deep maps [true] mapsAreDeep) ||| ([X] deep iterables [true] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': {
        5: 4,
        'w': 6,
      },
      'c': 3,
    };

    List deepValues = map.deepValues();
    expect(deepValues, [1, 4, 6, 3]);
  });

  test("(Map deepValues) ||| ([V] deep maps [false] mapsAreDeep) ||| ([X] deep iterables [true] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': {
        5: 4,
        'w': 6,
      },
      'c': 3,
    };

    List deepValues = map.deepValues(mapsAreDeep: false);
    expect(deepValues, [
      1,
      {5: 4, 'w': 6},
      3
    ]);
  });

  test("(Map deepValues) ||| ([X] deep maps [true] mapsAreDeep) ||| ([V] deep iterables [true] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': [2, 4, 5],
      'c': 3,
    };

    List deepValues = map.deepValues();
    expect(deepValues, [1, 2, 4, 5, 3]);
  });

  test("(Map deepValues) ||| ([X] deep maps [true] mapsAreDeep) ||| ([V] deep iterables [false] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': [2, 4, 5],
      'c': 3,
    };

    List deepValues = map.deepValues(IterablesAreDeep: false);
    expect(deepValues, [
      1,
      [2, 4, 5],
      3
    ]);
  });

  test("(Map deepValues) ||| ([V] deep maps [true] mapsAreDeep) ||| ([V] deep iterables [V] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': [2, 3, 4],
      'c': {
        true: 5,
        111: 6,
        'q': [
          7,
          8,
          9,
          [10, 11, 12]
        ],
        'w': {
          'g': {'h': 13, 'j': 14}
        }
      },
      'd': 15
    };

    List deepValues = map.deepValues();
    expect(deepValues, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);
  });

  test("(Map deepValuesExcludeMapType) ||| ([V] deep maps [true] mapsAreDeep) ||| ([X] deep iterables [true] iterablesAreDeep)", () {
    Map<String, int> excludedMap = {
      'a': 100,
      'b': 101,
    };

    Map map = {
      'a': 1,
      'b': excludedMap,
      'c': 3,
    };

    List deepValues = map.deepValuesExcludeMapType<Map<String, int>>();
    expect(deepValues, [1, excludedMap, 3]);
  });

  test("(Map deepValuesExcludeIterableType) ||| ([X] deep maps [true] mapsAreDeep) ||| ([V] deep iterables [true] iterablesAreDeep)", () {
    Uint8List excludedIterable = Uint8List.fromList([45, 56, 66]);

    Map map = {
      'a': 1,
      'b': excludedIterable,
      'c': 3,
    };

    List deepValues = map.deepValuesExcludeIterableType<Uint8List>();
    expect(deepValues, [1, excludedIterable, 3]);
  });

  test("(Map deepKeysExcludeIterableType) ||| ([X] deep maps [true] mapsAreDeep) ||| ([V] deep iterables [true] iterablesAreDeep)", () {
    Uint8List excludedIterable = Uint8List.fromList([45, 56, 66]);

    Map map = {
      'a': 1,
      'b': excludedIterable,
      'c': 3,
    };

    List deepValues = map.deepKeysExcludeIterableType<Uint8List>();
    expect(deepValues, [
      'a',
      'b',
      'c',
    ]);
  });

  test("(Map deepValuesMap) ||| ([V] deep maps [true] mapsAreDeep) ||| ([V] deep iterables [true] iterablesAreDeep)", () {
    Map map = {
      'a': 1,
      'b': [4, 5, 2, 6],
      'c': Uint8List.fromList([1, 2, 8]),
      'd': {
        'e': 1,
        'f': 9,
      }
    };

    Map deepValues = map.deepValuesMap((x) => (x > 2) ? x * 10 : x);
    expect(deepValues, {
      'a': 1,
      'b': [40, 50, 2, 60],
      'c': [1, 2, 80],
      'd': {
        'e': 1,
        'f': 90,
      }
    });
  });
}
