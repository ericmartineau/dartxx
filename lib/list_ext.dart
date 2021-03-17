extension NullIterXX<V> on Iterable<V>? {
  Iterable<R> orMap<R>(R mapper(V)) {
    if (this == null) return const [];
    return this!.map(mapper);
  }

  Iterable<V> orWhere(bool predicate(V v)) {
    if (this == null) return const [];
    return this!.where(predicate);
  }

  bool orContains(V other) {
    if (this == null) return false;
    return this!.contains(other);
  }

  int get orLength {
    if (this == null) return 0;
    return this!.length;
  }

  Iterable<V> orEmptyIter() {
    if (this == null) return const [];
    return this!;
  }

  V? get tryFirst {
    return (this == null)
        ? null
        : this!.isEmpty
            ? null
            : this!.first;
  }
}

extension NullListXX<V> on List<V>? {
  List<V> orEmptyList() {
    if (this == null) return const [];
    return this!;
  }
}

extension NullSetXX<V> on Set<V>? {
  Set<V> orEmptySet() {
    if (this == null) return const {};
    return this!;
  }
}

extension IterXX<V> on Iterable<V?> {
  List<V> notNull() {
    return <V>[
      for (var i in this)
        if (i != null) i
    ];
  }

  Set<V> notNullSet() {
    return <V>{
      for (var i in this)
        if (i != null) i
    };
  }

  List<R> mapNotNull<R extends Object>(R mapper(V from)) {
    return <R>[
      for (var i in this)
        if (i != null) mapper(i),
    ];
  }
}
