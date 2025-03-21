extension NumExtensionMethods on num {
  num map(num fromStart, num fromEnd, num toStart, num toEnd, {bool truncate = false}) {
    double scale = (toEnd - toStart) / (fromEnd - fromStart);
    double value = (this - fromStart) * scale + toStart;
    return truncate ? value.trunc(toStart, toEnd) : value;
  }

  num trunc(num floor, num ceil) {
    if (this < floor) return floor;
    if (ceil < this) return ceil;
    return this;
  }
}