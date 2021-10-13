import 'lang_ext.dart';
import 'm_literal.dart';

/// Represents a json-pointer - can be used to do json-pointer operations on [MModel] instances.
///
/// [T] represents the type of data expected at this pointer
class JsonPath<T> extends MLiteral<String> {
  final List<String>? _segments;
  final String? _single;
  List<String> get segments => _segments ?? [_single!];

  String get path => value;

  const JsonPath._(this._segments, String path)
      : _single = null,
        super(path);

  const JsonPath.single(String single)
      : _segments = null,
        _single = single,
        super('/$single');

  const JsonPath.internal(this._segments, String path)
      : _single = null,
        super(path);

  static const Root = JsonPath._([], "/");

  const JsonPath.root()
      : _segments = const [],
        _single = null,
        super("/");

  JsonPath.segments(List<String> segments) : this._(List.unmodifiable(segments), _toPathName(segments));

  factory JsonPath.fromJson(json) => JsonPath<T>.parsed("$json");

  factory JsonPath.parsed(String value, {JsonPath? relativeTo}) {
    final _segments = _parsePath(value);
    final path = JsonPath<T>._(List.unmodifiable(_segments), _toPathName(_segments));
    if (relativeTo != null) {
      return path.relativize<T>(relativeTo);
    } else {
      return path;
    }
  }

  factory JsonPath.of(dynamic from, {JsonPath? relativeTo}) {
    if (from is JsonPath && relativeTo != null) {
      return from.relativize(relativeTo).cast<T>();
    } else if (from is JsonPath<T> && relativeTo == null) {
      return from.cast<T>();
    } else if (from == null) {
      return JsonPath.root();
    } else {
      return JsonPath.parsed("$from", relativeTo: relativeTo);
    }
  }

  JsonPath<TT> cast<TT>() {
    return JsonPath<TT>._(segments, path);
  }

  /// The last segment in the path
  String get last => _single ?? _segments!.last;

  /// The first segment in the path
  String get first => _single ?? _segments!.first;

  int get length => _single != null ? 1 : _segments!.length;

  /// Whether this path starts with another [JsonPath] instance.
  bool startsWith(JsonPath otherPath) {
    return path.startsWith(otherPath.path);
  }

  /// Returns an immutable copy of this path, with the last path segment removed
  JsonPath get chop => JsonPath.segments(_chopList(segments));

  JsonPath<TT> relativize<TT>(JsonPath<dynamic> other) {
    final segments = <String>[];
    final i = this.segments.iterator;
    final i2 = other.segments.iterator;
    bool matches = true;
    while (i.moveNext()) {
      if (matches && i2.moveNext()) {
        if (i.current == i2.current) {
          continue;
        } else {
          matches = false;
        }
      }

      segments.add(i.current);
    }

    return JsonPath<TT>.segments(segments);
  }

  dynamic operator [](int index) {
    return _single != null && index == 0 ? _single : segments[index];
  }

  @override
  String toString() => path;

  dynamic toJson() => path;

  String toKey() {
    return _single ?? segments.map((s) => s.capitalize()).join().uncapitalize();
  }
}

List<String> _parsePath(String? path) {
  if (path == null) return const [];
  if (path.startsWith("/")) path = path.substring(1);
  return [...path.split("/").whereNotBlank()];
}

String _toPathName(Iterable<String> segments) => "/" + segments.join("/");

extension JsonPathOperatorNullExtensions<T> on JsonPath<T>? {
  JsonPath<T> get self => this ?? const JsonPath.root();
  bool get isNullOrRoot => this == null || this!._segments?.isEmpty == true;
}

extension JsonPathOperatorExtensions<T> on JsonPath<T> {
  JsonPath operator +(path) {
    if (path is JsonPath) {
      return self.plus(path.self);
    } else {
      return self.plus(JsonPath.of(path));
    }
  }

  /// Whether this path is empty, eg "/"
  bool get isEmpty => _segments?.isEmpty == true;

  JsonPath<T> get verifyNotRoot => isNotRoot ? this : throw Exception("Expected ${this} to not be root");
  bool get isNotRoot => _single != null || self._segments?.isNotEmpty == true;

  JsonPath<TT> plus<TT>(JsonPath<TT> path) {
    final self = this.self;
    if (self.isEmpty) {
      return path;
    }
    if (path.self.isEmpty) {
      return this.cast();
    }
    return JsonPath<TT>._(this.self.segments + path.self.segments, this.self.path + path.self.path);
  }
}

List<T> _chopList<T>(List<T> items) {
  if (items.isEmpty) return items;

  return items.sublist(0, items.length - 1);
}
