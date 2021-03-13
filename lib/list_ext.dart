extension IterXX<V> on Iterable<V?> {
  List<V> notNull() {
    return <V>[
      for (var i in this)
        if (i != null) i
    ];
  }
}
