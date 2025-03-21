int xorInts(List<Object> ol) => ol.map((o) => o.hashCode).reduce((acc, curr) => acc ^ curr);

bool isNullable<T>() => null is T;