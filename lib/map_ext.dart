extension MapValueNullXX<K, V> on Map<K, V?> {
  Map<K, V> valuesNotNull() {
    Iterable<MapEntry<K, V>> entries = this
        .entries
        .where((element) => element.value != null)
        .map((e) => MapEntry<K, V>(e.key, e.value!));
    return Map.fromEntries(entries);
  }
}

extension MapXX<K, V> on Map<K, V> {
  Iterable<R> mapEach<R>(R map(K key, V value)) {
    return entries.map((e) => map(e.key, e.value)).toList();
  }
}
