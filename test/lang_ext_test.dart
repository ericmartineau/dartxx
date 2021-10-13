import 'package:dartxx/dartxx.dart';
import 'package:dartxx/lang_ext.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

void main() {
  // extension NumExt on num {
  test("testFormatCurrency", () {
    final formatted = 34.234.formatCurrency();
    expect(formatted, equals("\$34.23"));
  });

  test("tokenizeString(null)", () {
    expect(tokenizeString(null), equals([]));
  });

  test("tokenizeString()", () {
    expect(tokenizeString("Eric.Martineau", splitAll: true).toLowerCase(), equals(["eric", "martineau"]));
    expect(tokenizeString("1, 2, 3, 4", splitAll: true), equals(["1", '2', '3', '4']));
  });

  test("num.FormatCompact", () {
    final formatted = 12345543134.234.formatCompact();
    expect(formatted, equals("12.3 billion"));
  });

  test("String.isBlank", () {
    expect(" ".isBlank, isTrue);
    expect("\t".isBlank, isTrue);
    expect("\t\n".isBlank, isTrue);
    expect("\tt\n".isBlank, isFalse);
  });

  test("String.removeNewlines()", () {
    expect("Eric\n Martineau\n Jones".removeNewlines(), equals("Eric Martineau Jones"));
  });

  test("Type.simpleName()", () {
    final list = <String>[];
    expect(list.runtimeType.simpleName, equals("list"));
  });

  test("Type.simpleName()", () {
    final list = <String, num>{};
    expect(list.runtimeType.simpleName, equals("internalLinkedHashMap"));
  });

  test("num.repeat", () {
    var count = 0;

    3.5.repeat(() {
      count++;
    });
    expect(count, equals(4));
  });

  test("num.repeatx", () {
    var count = 0;

    3.repeat(() {
      count++;
    });
    expect(count, equals(3));
  });

  test("num.toIntSafe", () {
    expect(() {
      3.5.toIntSafe();
    }, throwsArgumentError);
  });

  test("num.toIntSafe with empty double", () {
    final safe = 3.0.toIntSafe();
    expect(safe, equals(3));
  });

  test("num.toIntSafe int", () {
    final safe = 3.toIntSafe();
    expect(safe, equals(3));
  });

  test("num.between already in", () {
    final coerced = 3.45.between(1, 10);
    expect(coerced, equals(3.45));
  });

  test("num.between isLow", () {
    final coerced = 3.45.between(10, 11);
    expect(coerced, equals(10));
  });

  test("num.between isHigh", () {
    final coerced = (3.45).between(1, 2.5);
    expect(coerced, equals(2.5));
  });

  test("num.normalize", () {
    final coerced = (4.2).normalize(10);
    expect(coerced, equals(0.42));
  });

  test("num.normalize", () {
    final coerced = (7.5).normalize(5, 10);
    expect(coerced, equals(0.5));
  });

  test("num.normalize low", () {
    final coerced = (-4.2).normalize(10);
    expect(coerced, equals(0));
  });

  test("num.normalize high", () {
    final coerced = 12.normalize(10);
    expect(coerced, equals(1));
  });

  test("num.normalize alt start", () {
    final coerced = 12.normalize(20, 10);
    expect(coerced, equals(.2));
  });

  test("num.sorted", () {
    final coerced = 12.sort(11.0);

    expect(coerced.first, equals(11.0));
    expect(coerced.second, equals(12));
  });

  test("num.sorted rev", () {
    final coerced = 11.sort(12.4);

    expect(coerced.first, equals(11.0));
    expect(coerced.second, equals(12.4));
  });

  test("num.notZero", () {
    expect(.00000004.notZero(), equals(.00000004));
    expect(0.notZero(1), equals(1));
    expect((0.000).notZero(), equals(0.00001));
    expect((-0.000).notZero(12.0), equals(12.0));
    expect((-0).notZero(10), equals(10.0));
    expect((10).notZero(), equals(10));
  });

  test("num.formatBytes", () {
    expect(123456.formatBytes(), equals("121 KB"));
  });

  test("num.formatBytes custom", () {
    expect(12345678910.formatBytes(formatBytes: (v, p) => "${v.roundTo(2)}^$p"), equals("11.5^3"));
  });
  test("num.isIntegral null", () {
    expect(null.isIntegral, isFalse);
  });

  test("num.isIntegral int", () {
    expect(3.isIntegral, isTrue);
  });

  test("num.isIntegral double .0", () {
    expect((3.0).isIntegral, isTrue);
  });

  test("num.isIntegral double .0", () {
    expect((3.3).isIntegral, isFalse);
  });

  test("num.atLeast", () {
    expect((3.3).atLeast(5), equals(5));
  });

  test("num.atLeast", () {
    expect(null.atLeast(3), equals(3));
  });

  test("num.isZero", () {
    expect(null.isZero, isFalse);
    expect(.00000004.isZero, isFalse);
    expect(0.isZero, isTrue);
    expect((0.000).isZero, isTrue);
    expect((-0.000).isZero, isTrue);
    expect((-0).isZero, isTrue);
    expect((10).isZero, isFalse);
    expect((-10).isZero, isFalse);
  });

  test("num.isNotZero", () {
    expect(null.isNotZero, isFalse);
    expect(.00000004.isNotZero, isNot(isFalse));
    expect(0.isNotZero, isNot(isTrue));
    expect((0.000).isNotZero, isNot(isTrue));
    expect((-0.000).isNotZero, isNot(isTrue));
    expect((-0).isNotZero, isNot(isTrue));
    expect((10).isNotZero, isNot(isFalse));
    expect((-10).isNotZero, isNot(isFalse));
  });

  test("num.formatNumber null", () {
    expect(null.formatNumber(), isNull);
  });

  test("num.formatNumber int", () {
    expect(3.formatNumber(), equals("3"));
  });

  test("num.formatNumber double", () {
    expect((3.455524321).formatNumber(), equals("3.456"));
  });

  test("num.formatNumber double", () {
    expect((-3.455524321).formatNumber(), equals("-3.456"));
  });

  test("num.formatNumber double", () {
    expect((34543123.455524321).formatNumber(using: NumberFormat.decimalPattern()), equals("34,543,123.456"));
  });

  test("num.times null", () {
    expect(null.times(10), equals(null));
  });

  test("num.times double/int", () {
    expect(3.times(2.5), equals(7.5));
  });

  test("num.times int/double", () {
    expect((2.5).times(3), equals(7.5));
  });

  test("num.isGreaterThan0 -1", () {
    expect(null.isGreaterThan0, isFalse);
    expect((-0).isGreaterThan0, isFalse);
    expect((0).isGreaterThan0, isFalse);
    expect((0.00000001).isGreaterThan0, isTrue);
    expect((10).isGreaterThan0, isTrue);
    expect((-10).isGreaterThan0, isFalse);
  });

  test("list<String>.whereNotBlank", () {
    expect(["Bob", "   ", "\t", "  the ", "\n\t", "Builder"].whereNotBlank(), containsAllInOrder(["Bob", "  the ", "Builder"]));
  });

  test("string.isNumeric", () {
    expect("abc".isNumeric, isFalse);
  });

  test("string.isNumeric", () {
    expect("12.34".isNumeric, isTrue);
  });

  test("string.isNumeric", () {
    expect("-12.34".isNumeric, isTrue);
  });

  test("string.isNumeric", () {
    expect("-123,332.34".isNumeric, isFalse);
  });

  test("string.isNumeric", () {
    expect("-\$123,332.34".isNumeric, isFalse);
  });

  test("string.isNumeric", () {
    expect("USD123,332.34".isNumeric, isFalse);
  });

  test("string.toSnakeCase", () {
    expect("bobTheBuilder".toSnakeCase(), equals("bob_the_builder"));
  });

  test("string.toSnakeCase", () {
    expect("Bob the Builder".toSnakeCase(), equals("bob_the_builder"));
  });

  test("string.toSnakeCase", () {
    expect("Bob_the_Builder".toSnakeCase(), equals("bob_the_builder"));
  });

  test("string.toCamelCase", () {
    expect("BobTheBuilder".toCamelCase(), equals("bobTheBuilder"));
  });

  test("string.toCamelCase", () {
    expect("Bob the Builder".toCamelCase(), equals("bobTheBuilder"));
  });

  test("string.toCamelCase", () {
    expect("Bob_the_Builder".toCamelCase(), equals("bobTheBuilder"));
  });

  test("string.first", () {
    expect("Retrovirus".first, equals("R"));
  });

  test("string.first", () {
    expect(" Retrovirus".first, equals(" "));
  });

  test("string.first", () {
    expect("".first, isNull);
  });

  test("string.pluralize", () {
    expect("duck".pluralizeIf(true), equals("ducks"));
  });

  test("string.pluralize true", () {
    expect("duck".pluralizeIf(false), equals("duck"));
  });

  test("string.pluralize true", () {
    expect("person".pluralizeIf(true), equals("people"));
  });

  test("string.pluralize true", () {
    expect("box".pluralizeIf(true), equals("boxes"));
  });

  test("string.truncate true", () {
    expect("The big brown dog jumped over".truncate(10), equals("The big br"));
  });

  test("string.pluralize", () {
    expect("dog".pluralize(0), equals("dogs"));
  });

  test("string.pluralize", () => expect("dog".pluralize(1), equals("dog")));
  test("string.pluralize", () => expect("dog".pluralize(2), equals("dogs")));
  test("string.uncapitalize", () => expect("Dog".uncapitalize(), equals("dog")));
  test("string.capitalize", () => expect("dog".capitalize(), equals("Dog")));
  test("string.trimAround", () => expect("--dog--".trimAround("-"), equals("dog")));
  test("string.trimAround array", () => expect("-=dog=-".trimAround(["-", "="]), equals("dog")));

  final parsedDate = DateTime.parse("2010-12-23T13:45:14.1234Z");

  test("dateTime.withoutTime", () => expect(parsedDate.withoutTime().toIso8601String(), equals("2010-12-23T00:00:00.000")));

  final oneYearAgo = DateTime.now().subtract(Duration(days: 368));
  test("dateTime.sinceNow()", () => expect(DateTime.now().sinceNow().inMilliseconds, lessThan(2000)));

  test("dateTime.yearsAgo", () => expect(oneYearAgo.yearsAgo, equals(1)));
  test("dateTime.monthsAgo", () => expect(oneYearAgo.monthsAgo, equals(12)));
  test("dateTime.daysAgo", () => expect(oneYearAgo.daysAgo, equals(368)));
  test("dateTime.hoursAgo", () => expect(oneYearAgo.hoursAgo, equals(8832)));
  test("dateTime.hasTime", () => expect(oneYearAgo.hasTime, isTrue));
  test("dateTime.hasTime", () => expect(oneYearAgo.withoutTime().hasTime, isFalse));

  test("dateTime.atTime", () => expect(parsedDate.atTime(8, 3, 30).toIso8601String(), equals("2010-12-23T08:03:30.000")));

  test("dateTime.atStartOfDay", () => expect(parsedDate.atStartOfDay().toIso8601String(), equals("2010-12-23T00:00:00.000")));

  test("dateTime.isPast null", () => expect(null.isPast, isFalse));
  test("dateTime.isFuture null", () => expect(null.isFuture, isFalse));

  test("dateTime.isFuture null", () => expect(null.isFuture, isFalse));
  test("dateTime.isFuture null", () => expect(null.isFuture, isFalse));

  test("dateTime.atStartOfDay null", () => expect(null.atStartOfDay(), isNull));
  test("dateTime.isPast null", () => expect(parsedDate.atStartOfDay().toIso8601String(), equals("2010-12-23T00:00:00.000")));
}
