import 'dart:math';

import 'package:inflection3/inflection3.dart' as inflection;
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import 'tokenizer.dart';
import 'tuple.dart';

const _pluralStopWords = {"info", "information"};
final wordSeparator = RegExp('[\.\;\, ]');
final nameSeparator = RegExp('[@\.\; ]');
final isLetters = RegExp(r"^[A-Za-z]*$");

const digits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

class _Numbers {
  static const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

  static String _defaultFormatBytes(num v, int power) {
    return "${v.formatCompact()} ${suffixes[power]}";
  }
}

extension TypeLangExtensions on Type {
  String get name => "$this"
      .trimAround("_")
      .replaceAllMapped(
          typeParameters, (match) => "[${match.group(1)!.uncapitalize()}]")
      .uncapitalize();

  String get simpleName => simpleNameOfType(this);
}

String simpleNameOfType(Type type) {
  return "$type".replaceAll(typeParameters, '').trimStart("_").uncapitalize();
}

extension NumXX on num {
  String formatCurrency() => currencyFormat.format(this);

  String formatCompact() => compactFormat.format(this);

  void repeat(void forEach()) {
    assert(this > -1);
    for (int i = 0; i < this; i++) {
      forEach();
    }
  }

  int toIntSafe() {
    final i = this;
    if (i is int) {
      return i;
    } else if (i.isIntegral) {
      return i.toInt();
    } else {
      throw ArgumentError("Number $i could not be safely truncated to an int");
    }
  }

  double between(num low, num upper) {
    return min(upper.toDouble(), max(low.toDouble(), this.toDouble()));
  }

  Tuple<num, num> sort(num other) {
    return (this > other) ? Tuple(other, this) : Tuple(this, other);
  }

  double normalize(double end, [double start = 0, int roundTo = 6]) {
    final tuple = start.sort(end);

    start = tuple.first.toDouble();
    end = tuple.second.toDouble();
    if (this <= start) return 0;
    if (this >= end) return 1;

    final div = (this - start) / (end - start);
    return div.roundTo(roundTo);
  }

  double roundTo([int places = 4]) {
    final mult = pow(10, places);
    return ((this * mult).roundToDouble()) / mult;
  }

  double notZero([double alt = 0.00001]) {
    if (this == 0) {
      return alt;
    } else {
      return this.toDouble();
    }
  }

  String formatBytes(
      {String formatBytes(num v, int power) = _Numbers._defaultFormatBytes}) {
    var bytes = this;
    if (bytes <= 0) return formatBytes(0, 0);
    var i = (log(bytes) / log(1024)).floor();
    var b = ((bytes / pow(1024, i)));
    return formatBytes(b, i);
  }
}

extension NumXXNullable on num? {
  bool get isIntegral {
    if (this == null) return false;
    return this is int || this?.roundToDouble() == this;
  }

  num atLeast(num atLeast) {
    if (this == null) {
      return atLeast;
    } else {
      if (this! < atLeast) return atLeast;
      return this!;
    }
  }

  bool get isZero => this == 0.0;

  bool get isNotZero {
    if (this == null) return false;
    return this != 0.0;
  }

  String? formatNumber({int fixed = 3, NumberFormat? using}) {
    if (this == null) return null;
    if (using != null) return using.format(this);
    return isIntegral ? "${this?.toInt()}" : this!.toStringAsFixed(fixed);
  }

  static const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

  //
  // static String _defaultFormatBytes(num v, int power) {
  //   return "${v.formatCompact()} ${suffixes[power]}";
  // }

  // String formatCurrency() => currencyFormat.format(this);
  //
  // String formatCompact() => compactFormat.format(this);

  double? times(num? other) {
    if (this == null) return null;
    if (other == null) return this!.toDouble();
    return (this! * other).toDouble();
  }

  num orZero() {
    return this == null ? 0.0 : this!;
  }

  bool get isGreaterThan0 {
    return this != null && this! > 0;
  }
}

final currencyFormat = NumberFormat.simpleCurrency();
final compactFormat = NumberFormat.compactLong();

List<String> tokenizeString(String? input,
    {bool splitAll = false, Tokenizer? tokenizer}) {
  if (input == null) return [];
  tokenizer ??= (splitAll == true) ? aggresiveTokenizer : spaceTokenizer;
  return tokenizer
      .tokenize(input)
      .map((t) => t.toString())
      .toList()
      .whereNotBlank();
}

final upToLastDot = RegExp('.*\\.');
final aggresiveTokenizer =
    Tokenizer(delimiters: {",", "/", "_", '.', '-', ' ', '\t', '\n'});

final spaceTokenizer = Tokenizer();

extension ListStringXX on Iterable<String> {
  List<String> whereNotBlank() {
    return [
      for (final str in this)
        if (str.isNotBlank) str,
    ];
  }

  Iterable<String> toLowerCase() {
    return map((s) => s.toLowerCase());
  }
}

final typeParameters = RegExp("<(.*)>");
final newLinesPattern = RegExp("\\n");

extension StringXX on String {
  String removeNewlines() => removeAll(newLinesPattern);

  String removeAll(Pattern pattern) => this.replaceAll(pattern, "");

  bool get isNotBlank {
    return this.trim().isNotEmpty;
  }

  bool get isBlank {
    return this.trim().isEmpty;
  }

  bool get isNumeric => (num.tryParse(this) != null);

  String toSnakeCase() => ReCase(this).snakeCase.toLowerCase();

  String toCamelCase() => ReCase(this).camelCase.uncapitalize();

  String? get first {
    if (this.isNotEmpty) return this[0];
    return null;
  }

  String pluralizeIf(bool condition) {
    if (_pluralStopWords.any((s) => this.toLowerCase().endsWith(s) == true)) {
      return this;
    }
    return condition ? inflection.pluralize(this) : this;
  }

  String truncate(int length) {
    if (this.length <= length) {
      return this;
    } else {
      return this.substring(0, length);
    }
  }

  String pluralize([int count = 2]) {
    return pluralizeIf(count != 1);
  }

  String uncapitalize() {
    final source = this;
    if (source.isEmpty) {
      return source;
    } else {
      return source[0].toLowerCase() + source.substring(1);
    }
  }

  String capitalize() {
    final source = this;
    if (source.isEmpty) {
      return source;
    } else {
      return source[0].toUpperCase() + source.substring(1);
    }
  }

  String trimAround(dynamic characters,
      {bool trimStart = true,
      bool trimEnd = true,
      bool trimWhitespace = true}) {
    final target = this;
    var manipulated = target;
    if (trimWhitespace) {
      manipulated = manipulated.trim();
    }

    final chars = characters is List<String> ? characters : ["$characters"];
    int i = 0;
    while (true && i++ < 30) {
      bool done = true;
      for (final c in chars) {
        if (trimEnd && manipulated.endsWith(c)) {
          manipulated = manipulated.substring(0, manipulated.length - c.length);
          done = false;
        }
        if (trimStart && manipulated.startsWith(c)) {
          manipulated = manipulated.substring(1);
          done = false;
        }
      }

      if (done) break;
    }
    return manipulated;
  }

  String trimEnd(dynamic characters, {bool trimWhitespace = true}) =>
      trimAround(characters, trimWhitespace: trimWhitespace, trimStart: false);

  String trimStart(dynamic characters, {bool trimWhitespace = true}) =>
      trimAround(characters, trimWhitespace: trimWhitespace, trimEnd: false);
}

extension StringNullableXX on String? {
  List<String> get words {
    if (this == null) return const [];
    return [
      for (final word in this!.split(wordSeparator))
        if (word.trim().isNotNullOrBlank) word,
    ];
  }

  String ifBlank(String other) {
    return this.isNullOrBlank ? other : this!;
  }

  bool get isNotNullOrBlank {
    return this != null && this!.isNotBlank;
  }

  bool get isNullOrBlank {
    return this == null || this!.isBlank;
  }

  /// Whether the string contains only letters
  bool get isLettersOnly {
    if (this.isNullOrBlank) return false;
    return isLetters.hasMatch(this!);
  }

  String orEmpty() {
    return this ?? "";
  }

  String? get first {
    if (this?.isNotEmpty == true) return this![0];
    return null;
  }

  int toInt() => int.parse(this!);

  int? toIntOrNull() => this == null ? null : int.tryParse(this!);

  double toDouble() => double.parse(this!);

  double? toDoubleOrNull() => this == null ? null : double.tryParse(this!);

  List<String> dotSplit() => this?.split("\.") ?? const [];

  List<String> tokenize({bool splitAll = false, Tokenizer? tokenizer}) {
    return tokenizeString(this ?? '', splitAll: splitAll, tokenizer: tokenizer);
  }

  String? get extension {
    if (this == null) return null;
    return "$this".replaceAll(upToLastDot, '');
  }

  String? charAt(int c) {
    if (this == null) return null;
    if (this!.length > c) return this![c];
    return null;
  }

  String? toPathName() {
    if (this == null) return null;
    if (!this!.startsWith("/")) {
      return "/$this";
    } else {
      return this;
    }
  }

  List<String> toStringList() {
    if (this.isNotNullOrBlank) {
      return [this!];
    } else {
      return const [];
    }
  }

  String ifThen(String ifString, String thenString) {
    if (this == null || this == ifString) return thenString;
    return this!;
  }

  String plus(String after) {
    if (this.isNullOrBlank) return '';
    return "${this}$after";
  }

  Uri? toUri() => this == null ? null : Uri.parse(this!);

  String? nullIfBlank() {
    if (isNullOrBlank) return null;
    return this;
  }

  String? join(String? other, [String separator = " "]) {
    if (this == null && other == null) return null;
    if (this == null || other == null) return this ?? other;
    return "${this}$separator$other";
  }

  String article() {
    if (this.isNullOrBlank) return "";
    return this.first!.isVowel ? "an $this" : "a $this";
  }

  bool get isVowel {
    switch (this) {
      case "a":
      case "e":
      case "i":
      case "o":
      case "u":
        return true;
      default:
        return false;
    }
  }
}

extension DateTimeXX on DateTime {
  DateTime withoutTime() =>
      DateTime(this.year, this.month, this.day, 0, 0, 0, 0, 0);

  Duration sinceNow() => -(this.difference(DateTime.now()));

  int get yearsAgo => daysAgo ~/ 365;

  int get monthsAgo => daysAgo ~/ 30.3;

  int get daysAgo => max(sinceNow().inDays, 0);

  int get hoursAgo => max(sinceNow().inHours, 0);

  int get yearsApart => daysApart ~/ 365;

  int get monthsApart => daysApart ~/ 30.3;

  int get daysApart => sinceNow().inDays;

  bool get hasTime =>
      this.second != 0 ||
      this.minute != 0 ||
      this.hour != 0 ||
      this.millisecond != 0;

  DateTime atStartOfDay() {
    final t = this;
    return DateTime(t.year, t.month, t.day);
  }

  DateTime atTime([int hour = 0, int minute = 0, int second = 0]) {
    final t = this;
    return DateTime(t.year, t.month, t.day, hour, minute, second);
  }
}

extension DateTimeNullableXX on DateTime? {
  /// Returns how much time has elapsed since this date.  If the date is null
  /// or in the future, then [Duration.zero] will be returned
  Duration get elapsed {
    if (this == null) return Duration.zero;
    if (this.isFuture) return Duration.zero;
    return this!.sinceNow();
  }

  bool get isFuture => this != null && this!.isAfter(DateTime.now());

  bool get isPast => this != null && this!.isBefore(DateTime.now());

  DateTime? atStartOfDay() {
    final t = this;
    if (t == null) return null;
    return DateTime(t.year, t.month, t.day);
  }

  DateTime? atTime([int hour = 0, int minute = 0, int second = 0]) {
    final t = this;
    if (t == null) return null;
    return DateTime(t.year, t.month, t.day, hour, minute, second);
  }
}
