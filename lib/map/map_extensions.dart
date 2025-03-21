
extension MapCopy<K, V> on Map<K, V> {
  Map<K, V> copy() {
    Map<K, V> newMap = <K, V>{};
    this.forEach((key, value) {
      newMap[key] = ((value is Map<K, V>) ? value.copy() : value) as V;
    });
    return newMap;
  }
}

extension FlattenObject<K, V> on Map<K, V> {
  Map<K, V>? _flattenMapValueOneLevel(K key) {
    Map<K, V>? flattenedMap;
    if (this[key] is Map<K, V>) {
      Map<K, V> mapCopy = copy();
      int index = mapCopy.entries.toList().indexWhere((entry) => entry.key == key);
      Map<K, V> objectMap = (mapCopy[key] as Map<K, V>);
      mapCopy.remove(key);
      Iterable<MapEntry<K, V>> objectMapEntries = objectMap.entries;
      List<MapEntry<K, V>> flattenedMapEntries = mapCopy.entries.toList()
        ..insertAll(index, objectMapEntries);
      flattenedMap = Map.fromEntries(flattenedMapEntries);
    }
    return flattenedMap ?? this;
  }

  Map<K, V> flatten([levels]) {
    Map<K, V> newMap = {};
    this.entries.forEach((entry) {
      if (entry.value is Map<K, V> && levels != 0) {
        Map<K, V> flattenedEntryMap = (entry.value as Map<K, V>);
        if (levels == null)
          flattenedEntryMap = (entry.value as Map<K, V>).flatten();
        else
          flattenedEntryMap = (entry.value as Map<K, V>).flatten(levels - 1);

        newMap[entry.key] = (flattenedEntryMap as V);
        newMap = newMap._flattenMapValueOneLevel(entry.key)!;
      }
      else
        newMap[entry.key] = entry.value;
    });
    return newMap;
  }

  Map<K, V> flattenEntry([K? key, levels]) {
    Map<K, V> newMap = {};
    this.entries.forEach((entry) {
      if (entry.value is Map<K, V> && (key == null || key == entry.key) && levels != 0) {
        Map<K, V> flattenedEntryMap = (entry.value as Map<K, V>);
        if (levels == null)
          flattenedEntryMap = (entry.value as Map<K, V>).flattenEntry();
        else
          flattenedEntryMap = (entry.value as Map<K, V>).flattenEntry(null, levels - 1);

        newMap[entry.key] = (flattenedEntryMap as V);
        newMap = newMap._flattenMapValueOneLevel(entry.key)!;
      }
      else
        newMap[entry.key] = entry.value;
    });
    return newMap;
  }
}

extension MapContainsEntry<K, V> on Map<K, V> {
  bool containsEntry({K? key, V? value}) => containsKey(key) && this[key] == value;
}

extension MapInsert<K, V> on Map<K, V> {
  Map<K, V> insertAt(int index, MapEntry<K, V> mapEntry) =>
      Map.fromEntries(entries.toList()
        ..insert(index, mapEntry));

  Map<K, V> insertFirst(MapEntry<K, V> mapEntry) => insertAt(0, mapEntry);

  Map<K, V> insertLast(MapEntry<K, V> mapEntry) => insertAt(length, mapEntry);

  Map<K, V> insertBefore(K key, MapEntry<K, V> mapEntry) =>
      insertAt(entries.toList().indexWhere((mapEntry) => mapEntry.key == key), mapEntry);

  Map<K, V> insertAfter(K key, MapEntry<K, V> mapEntry) =>
      insertAt(entries.toList().indexWhere((mapEntry) => mapEntry.key == key) + 1, mapEntry);
}
