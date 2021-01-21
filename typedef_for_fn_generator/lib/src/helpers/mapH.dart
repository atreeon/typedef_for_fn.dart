///Converts a map to a list
Iterable<T> map<T, TK, TV>(Map<TK, TV> source, T Function(TK, TV) f) =>
    source.keys.map((x) => f(x, source[x]));
