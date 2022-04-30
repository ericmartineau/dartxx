// ignore_for_file: use_to_and_as_if_applicable
import 'dart:async';
import 'dart:math';

final _random = Random();

enum IterationPosition { only, first, middle, last }

extension IterationPositionExtensions on IterationPosition {
  bool get isLast =>
      this == IterationPosition.last || this == IterationPosition.only;

  bool get isNotLast =>
      this != IterationPosition.last && this != IterationPosition.only;

  bool get isNotFirst =>
      this != IterationPosition.first && this != IterationPosition.only;

  bool get isFirst =>
      this == IterationPosition.first || this == IterationPosition.only;

  bool get hasNext => this.isNotLast && this.isNotOnly;

  bool get isOnly => this == IterationPosition.only;
  bool get isNotOnly => !isOnly;
}

extension IterObjXX<T extends Object> on Iterable<T> {}

extension IterDynXX<T> on Iterable<T> {
  Iterable<ListIndex<T>> indexed() {
    return this.mapIndexed(
        ((T item, int idx) => ListIndex<T>(idx, item, this.length)));
  }

  List<T> freeze() {
    return List.unmodifiable(this);
  }

  double sumBy(double toDouble(T t)) {
    return this.map(toDouble).sum();
  }

  int sumByInt(int toDouble(T t)) {
    return this.map(toDouble).sumInt();
  }

  T? randomOrNull() {
    if (this.isEmpty) return null;
    final randomIdx = _random.nextInt(this.length);
    return this.toList()[randomIdx];
  }

  T random() {
    final randomIdx = _random.nextInt(this.length);
    return this.toList()[randomIdx];
  }

  List<R> mapIndexed<R>(R mapper(T item, int index)) {
    int i = 0;
    return [...this.map((item) => mapper(item, i++))];
  }

  List<R> expandIndexed<R>(Iterable<R> mapper(T item, int index)) {
    int i = 0;
    return [...this.expand((item) => mapper(item, i++))];
  }

  T maxBy<R extends Comparable<R>>(R by(T item), [T? ifNull]) {
    return maxByOrNull(by, ifNull) ??
        (throw IndexError(0, this, "maxBy while empty"));
  }

  T? maxByOrNull<R extends Comparable<R>>(R by(T item), [T? ifNull]) {
    T? _max;
    for (final t in this) {
      if (_max == null || (by(t).compareTo(by(_max))) > 0) {
        _max = t;
      }
    }
    return _max ?? ifNull;
  }

  T minBy<R extends Comparable<R>>(R by(T item), [T? ifNull]) {
    return minByOrNull(by, ifNull) ??
        (throw IndexError(0, this, "minBy while empty"));
  }

  T? minByOrNull<R extends Comparable<R>>(R by(T item), [T? ifNull]) {
    T? _min;
    for (final t in this) {
      if (_min == null || (by(t).compareTo(by(_min))) < 0) {
        _min = t;
      }
    }
    return _min ?? ifNull;
  }

  List<T> sortedBy([Comparator<T>? compare]) {
    final buffer = [...this];
    buffer.sort(compare);
    return buffer;
  }

  List<T> sortedUsing(Comparable getter(T item)) {
    final ts = [...this];
    return ts.sortedBy((a, b) {
      final f1 = getter(a);
      final f2 = getter(b);
      return f1.compareTo(f2);
    }).cast();
  }

  Iterable<T> uniqueBy(dynamic uniqueProp(T item)) {
    final mapping = <dynamic, T>{};
    for (final t in this) {
      final unique = uniqueProp(t);
      mapping[unique] = t;
    }
    return mapping.values;
  }

  Stream<T> toStream() {
    return Stream.fromIterable(this);
  }

  Future forEachAsync(FutureOr onEach(T item)) async {
    for (final item in this) {
      await onEach(item);
    }
  }

  void forEachIndexed<R>(R mapper(T item, int index)) {
    int i = 0;

    for (final x in this) {
      mapper(x, i++);
    }
  }

  List<T> truncate([int? length]) {
    if (length == null) return [...this];
    return [...this.take(length)];
  }

  Iterable<R> mapPos<R>(R mapper(T item, IterationPosition pos)) {
    int i = 0;
    final length = this.length;
    final isSingle = length == 1;
    return [
      ...this.map((T item) {
        final _i = i;
        i++;
        return mapper(
            item,
            isSingle
                ? IterationPosition.only
                : _i == 0
                    ? IterationPosition.first
                    : _i == length - 1
                        ? IterationPosition.last
                        : IterationPosition.middle);
      })
    ];
  }

  Iterable<R> mapPosIndex<R>(
      R mapper(T item, int index, IterationPosition pos)) {
    int i = 0;
    final length = this.length;
    final isSingle = length == 1;
    return [
      ...this.map((T item) {
        final _i = i;
        i++;
        return mapper(
            item,
            _i,
            isSingle
                ? IterationPosition.only
                : _i == 0
                    ? IterationPosition.first
                    : _i == length - 1
                        ? IterationPosition.last
                        : IterationPosition.middle);
      })
    ];
  }

  String joinWithAnd([String? formatter(T input)?]) {
    formatter ??= (item) => item.toString();
    if (this.length < 3) {
      return this.join(" and ");
    } else {
      return mapPos((item, pos) {
        String? formatted = formatter!(item);
        switch (pos) {
          case IterationPosition.first:
          case IterationPosition.only:
            return formatted;
          case IterationPosition.middle:
            return ", $formatted";
          case IterationPosition.last:
            return ", and $formatted";
          default:
            return ", $formatted";
        }
      }).join("");
    }
  }

  T? firstOr([T? ifEmpty]) {
    if (this.isEmpty) return ifEmpty;
    return this.first;
  }

  T? lastOr([T? ifEmpty]) {
    if (this.isEmpty) return ifEmpty;
    return this.last;
  }
}

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

  V? tryGet(int index) {
    if (this == null) return null;
    if (index >= this!.length) return null;
    return this![index];
  }
}

extension NullSetXX<V> on Set<V>? {
  Set<V> orEmptySet() {
    if (this == null) return const {};
    return this!;
  }
}

extension IterOfNullableXX<V> on Iterable<V?> {
  Iterable<V> notNull() {
    return this.where((element) => element != null).cast<V>();
  }

  Set<V> notNullSet() {
    return <V>{
      for (var i in this)
        if (i != null) i
    };
  }

  List<V> notNullList() {
    return <V>[...notNull()];
  }

  List<R> mapNotNull<R extends Object>(R? mapper(V from)) {
    return [
      for (var i in this)
        if (i != null) mapper(i),
    ].notNullList();
  }
}

extension IterOfNumNullableXX on Iterable<num>? {
  double sum() {
    if (this == null) return 0;
    var i = 0.0;
    for (final x in this!) {
      i += x;
    }
    return i;
  }

  int sumInt() {
    if (this == null) return 0;
    var i = 0;
    for (final x in this!) {
      i += x.toInt();
    }
    return i;
  }

  double sumDouble() {
    if (this == null) return 0;
    var i = 0.0;
    for (final x in this!) {
      i += x;
    }
    return i;
  }
}

extension ComparableIterXX<T extends Comparable> on Iterable<T> {
  T? maxOrNull([T? ifNull]) {
    T? _max;
    for (final t in this) {
      if (_max == null || t.compareTo(_max) > 0) {
        _max = t;
      }
    }
    return _max ?? ifNull;
  }

  T max([T? ifNull]) {
    return maxOrNull(ifNull) ?? (throw IndexError(0, this));
  }

  T? minOrNull([T? ifNull]) {
    T? _min;
    for (final t in this) {
      if (_min == null || t.compareTo(_min) < 0) {
        _min = t;
      }
    }
    return _min ?? ifNull;
  }

  T min([T? ifNull]) {
    return minOrNull(ifNull) ?? (throw IndexError(0, this));
  }

  List<T> sorted() {
    final buffer = [...this];
    buffer.sort((T a, T b) => a.compareTo(b));
    return buffer;
  }
}

extension IterIterXX<V> on Iterable<Iterable<V>> {
  List<V> flatten() {
    return [...this.expand((i) => i)];
  }
}

extension IterMapEntryXX<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> toMap() {
    return Map.fromEntries(this);
  }

  Map<K, List<V>> groupByKey() {
    Map<K, List<V>> results = {};
    this.forEach((e) {
      results.putIfAbsent(e.key, () => <V>[]).add(e.value);
    });
    return results;
  }
}

class ListIndex<T> {
  final int size;
  final int index;
  final T value;

  const ListIndex(this.index, this.value, this.size);

  IterationPosition get position {
    return size == 1
        ? IterationPosition.only
        : index == 0
            ? IterationPosition.first
            : index == size - 1
                ? IterationPosition.last
                : IterationPosition.middle;
  }
}
