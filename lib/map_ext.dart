extension MapXX<K, V> on Map<K, V?> {
  Map<K, V> valuesNotNull() {
    Iterable<MapEntry<K, V>> entries = this
        .entries
        .where((element) => element.value != null)
        .map((e) => MapEntry<K, V>(e.key, e.value!));
    return Map.fromEntries(entries);
  }
}
