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
