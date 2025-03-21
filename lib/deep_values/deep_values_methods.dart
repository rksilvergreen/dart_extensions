extension MapDeepValues on Map {
  List<B> deepValues<B>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List<B> values = [];
    this.forEach((key, value) {
      // print('key: $key, value: $value, value is Iterable<B>: ${value is Iterable<B>}');
      if (value is Map && mapsAreDeep) {
        values.addAll(value.deepValues(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable<B> && IterablesAreDeep) {
        values.addAll(value.deepValues(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is B) {
        values.add(value);
      }
    });
    return values;
  }

  List deepValuesExcludeMapType<A extends Map>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List values = [];
    this.forEach((key, value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep && value is! A) {
        values.addAll(value.deepValuesExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep) {
        values.addAll(value.deepValuesExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        values.add(value);
      }
    });
    return values;
  }

  List deepValuesExcludeIterableType<A extends Iterable>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List values = [];
    this.forEach((key, value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep) {
        values.addAll(value.deepValuesExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep && value is! A) {
        values.addAll(value.deepValuesExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        values.add(value);
      }
    });
    return values;
  }

  List deepKeys<B>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List keys = [];
    this.forEach((key, value) {
      // print('key: $key, value: $value, value is Iterable<B>: ${value is Iterable<B>}');
      if (value is Map && mapsAreDeep) {
        keys.addAll(value.deepKeys(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable<B> && IterablesAreDeep) {
        keys.addAll(value.deepKeys(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is B) {
        keys.add(key);
      }
    });
    return keys;
  }

  List deepKeysExcludeMapType<A extends Map>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List keys = [];
    this.forEach((key, value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep && value is! A) {
        keys.addAll(value.deepKeysExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep) {
        keys.addAll(value.deepKeysExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        keys.add(key);
      }
    });
    return keys;
  }

  List deepKeysExcludeIterableType<A extends Iterable>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List keys = [];
    this.forEach((key, value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep) {
        keys.addAll(value.deepKeysExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep && value is! A) {
        keys.addAll(value.deepKeysExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        keys.add(key);
      }
    });
    return keys;
  }

  Map deepValuesMap(dynamic Function(dynamic) fn, {bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    Map map = {};
    this.forEach((key, value) {
      if (value is Map && mapsAreDeep) {
        map[key] = value.deepValuesMap(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep);
      } else if (value is Iterable && IterablesAreDeep) {
        map[key] = value.deepValuesMap(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep);
      } else {
        map[key] = fn(value);
      }
    });
    return map;
  }

  Map deepValuesMapExcludeIterableType<T extends Iterable>(dynamic Function(dynamic) fn, {bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    Map map = {};
    this.forEach((key, value) {
      if (value is Map && mapsAreDeep) {
        map[key] = value.deepValuesMapExcludeIterableType<T>(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep);
      } else if (value is Iterable && IterablesAreDeep && value is! T) {
        map[key] = value.deepValuesMapExcludeIterableType<T>(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep);
      } else {
        map[key] = fn(value);
      }
    });
    return map;
  }
}

/// #################################

extension IterableDeepValues<T> on Iterable<T> {
  List<T> deepValues<T>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List<T> values = [];
    this.forEach((value) {
      // print('$value, value is T: ${value is T}');
      if (value is Map && mapsAreDeep) {
        values.addAll(value.deepValues(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable<T> && IterablesAreDeep) {
        values.addAll(value.deepValues(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is T) {
        values.add(value);
      }
    });
    return values;
  }

  List deepValuesExcludeMapType<A extends Map>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List values = [];
    this.forEach((value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep && value is! A) {
        values.addAll(value.deepValuesExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep) {
        values.addAll(value.deepValuesExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        values.add(value);
      }
    });
    return values;
  }

  List deepValuesExcludeIterableType<A extends Iterable>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List values = [];
    this.forEach((value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep) {
        values.addAll(value.deepValuesExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep && value is! A) {
        values.addAll(value.deepValuesExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        values.add(value);
      }
    });
    return values;
  }

  List deepKeys<B>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List keys = [];
    this.forEach((value) {
      // print('key: $key, value: $value, value is Iterable<B>: ${value is Iterable<B>}');
      if (value is Map && mapsAreDeep) {
        keys.addAll(value.deepKeys(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable<B> && IterablesAreDeep) {
        keys.addAll(value.deepKeys(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is B) {
        keys.add(null);
      }
    });
    return keys;
  }

  List deepKeysExcludeMapType<A extends Map>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List keys = [];
    this.forEach((value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep && value is! A) {
        keys.addAll(value.deepKeysExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep) {
        keys.addAll(value.deepKeysExcludeMapType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        keys.add(null);
      }
    });
    return keys;
  }

  List deepKeysExcludeIterableType<A extends Iterable>({bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List keys = [];
    this.forEach((value) {
      // print('key: $key, value: $value, value.runtimeType: ${value.runtimeType} value is! A: ${value is! A}');
      if (value is Map && mapsAreDeep) {
        keys.addAll(value.deepKeysExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep && value is! A) {
        keys.addAll(value.deepKeysExcludeIterableType<A>(mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        keys.add(null);
      }
    });
    return keys;
  }

  List deepValuesMap(dynamic Function(dynamic) fn, {bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List values = [];
    this.forEach((value) {
      if (value is Map && mapsAreDeep) {
        values.add(value.deepValuesMap(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep) {
        values.addAll(value.deepValuesMap(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        values.add(fn(value));
      }
    });
    return values;
  }

  List deepValuesMapExcludeIterableType<T extends Iterable>(dynamic Function(dynamic) fn, {bool mapsAreDeep = true, bool IterablesAreDeep = true}) {
    List values = [];
    this.forEach((value) {
      if (value is Map && mapsAreDeep) {
        values.add(value.deepValuesMapExcludeIterableType<T>(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else if (value is Iterable && IterablesAreDeep && value is! T) {
        values.addAll(value.deepValuesMapExcludeIterableType<T>(fn, mapsAreDeep: mapsAreDeep, IterablesAreDeep: IterablesAreDeep));
      } else {
        values.add(fn(value));
      }
    });
    return values;
  }
}