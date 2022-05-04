import 'package:dartxx/dartxx.dart';
import 'package:test/test.dart';
import 'package:test_api/backend.dart';
import 'package:test_api/src/backend/stack_trace_formatter.dart';
import 'package:test_api/src/expect/util/pretty_print.dart';
import 'package:test_api/src/frontend/async_matcher.dart';

void main() {
  group("list_ext_test", () {
    group("Iterable<T>", () {
      // extension NumExt on num {
      test("testFormatCurrency", () {
        final formatted = 34.234.formatCurrency();
        expect(formatted, equals("\$34.23"));
      });

      test("Iterable<T>.freeze()", () {
        final list = ["one", "two", "three"];
        final freeze = list.freeze();
        expect(() {
          freeze.add("four");
        }, throwsUnsupportedError);
        list.add("four");
        expect(list, contains("four"));
        expect(freeze, isNot(contains("four")));
      });

      test("Iterable<T>.sumBy()", () {
        final list = [
          [1.0],
          [2.0],
          [3.0],
          [4.0]
        ];
        expect(list.sumBy((t) => t.first), equals(10));
      });

      test("Iterable<T>.sumByInt()", () {
        final list = [
          [1],
          [2.5],
          [3.0],
          [4.0]
        ];
        expect(list.sumByInt((t) => t.first.toInt()), equals(10));
      });

      test("Iterable<T>.randomOrNull()", () {
        final list = <double>[];
        expect(list.randomOrNull(), isNull);
      });

      test("Iterable<T>.randomNotEmpty()", () {
        final list = <double>[1, 2, 3, 4, 5, 6, 7, 8, 9];
        expect(list.random(), isNotNull);
        expect(list, contains(list.random()));
      });

      test("Iterable<T>.randomEmpty()", () {
        final list = <double>[];
        expect(() => list.random(), throwsRangeError);
      });

      test("Iterable<T>.mapIndexed()", () {
        final list = <double>[0, 1, 2, 3, 4, 5, 6];
        list.mapIndexed((item, index) => expect(item, equals(index), reason: "Index should match value"));
      });

      test("Iterable<T>.expandIndexed()", () {
        final list = <List<int>>[
          [0, 0],
          [1, 1],
          [2, 2, 2]
        ];
        final expandedByIndex = list.expandIndexed((item, index) => item.map((element) {
              return MapEntry(element, index);
            }));
        expect(expandedByIndex, hasLength(7));
        expandedByIndex.forEach((element) {
          expect(element.key, equals(element.value), reason: "Each array item should match the original index");
        });
      });

      test("Iterable<T>.maxBy()", () {
        final list = <num>[
          34,
          22,
          111,
          -34,
          34.2,
          0.1,
          1,
        ];
        expect(list.maxBy((item) => item), equals(111));
      });

      test("Iterable<T>.maxByWithDefault()", () {
        final list = <num>[];
        expect(list.maxBy((item) => item, 12), equals(12));
      });

      test("Iterable<T>.maxByOrNull()", () {
        final list = <num>[];
        expect(list.maxByOrNull((item) => item), isNull);
      });

      test("Iterable<T>.maxByOrNullWithDefault()", () {
        final list = <num>[];
        expect(list.maxByOrNull((item) => item, 12), equals(12));
      });

      test("Iterable<T>.minBy()", () {
        final list = <num>[
          34,
          22,
          111,
          -34,
          34.2,
          0.1,
          1,
        ];
        expect(list.minBy((item) => item), equals(-34));
      });

      test("Iterable<T>.minByWithDefault()", () {
        final list = <num>[];
        expect(list.minBy((item) => item, 12), equals(12));
      });

      test("Iterable<T>.minByOrNull()", () {
        final list = <num>[];
        expect(list.minByOrNull((item) => item), isNull);
      });

      test("Iterable<T>.minByOrNullWithDefault()", () {
        final list = <num>[];
        expect(list.minByOrNull((item) => item, 12), equals(12));
      });
    });

    group("Iterable<V>?", () {
      test("orMap", () {
        var orMapped = (null).orMap((dbl) => "$dbl");
        expect(orMapped, isNotNull);
        expect(orMapped, isA<Iterable<String>>());
      });

      test("orMap(!)", () {
        var orMapped = [3, 4, 5].orMap((dbl) => "$dbl");
        expect(orMapped, isNotNull);
        expect(orMapped, containsAllInOrder(["3", "4", "5"]));
      });

      test("orWhere", () {
        var orMapped = (null).orWhere((dbl) => true);
        expect(orMapped, hasLength(0));
      });

      test("orWhere(!)", () {
        var orWhere = [1, 2, 3, 4, 5].orWhere((d) => d >= 3);
        expect(orWhere, hasLength(3));
        expect(orWhere, containsAllInOrder([3, 4, 5]));
      });

      test("orContains", () {
        expect((null).orContains(4), isFalse);
      });

      test("orContains(!)", () {
        expect([1, 2, 3, 4, 5].orContains(3), isTrue);
        expect([1, 2, 3, 4, 5].orContains(6), isFalse);
      });

      test("orLength(?)", () {
        expect(null.orLength, equals(0));
      });

      test("orLength(!)", () {
        expect([1, 2, 3, 4].orLength, equals(4));
      });

      test("orEmptyIter(!)", () {
        expect(null.orEmptyIter(), isNotNull);
      });

      test("tryFirst(?)", () {
        expect(null.tryFirst, isNull);
      });

      test("tryFirst(!)", () {
        expect([].tryFirst, isNull);
      });

      test("tryFirst(!)", () {
        expect([1, 4, 5].tryFirst, equals(1));
      });
    });

    group("List<V>?", () {
      test("orEmptyList(?)", () {
        // ignore: unnecessary_cast
        final empty = (null as List<String>?).orEmptyList();
        expect(null.orEmptyList(), isEmpty);
        expect(() => empty.add("Bob"), throwsWithMessage("Never"));
      });
      test("orEmptyList(!)", () {
        final empty = [1, 2, 3];
        expect(empty.orEmptyList(), same(empty));
      });
    });

    group("Set<V>?", () {
      test("orEmptySet(?)", () {
        // ignore: unnecessary_cast
        final empty = (null as Set<String>?).orEmptySet();
        expect(null.orEmptySet(), isEmpty);
        expect(() => empty.add("Bob"), throwsWithMessage("Never"));
      });
      test("orEmptySet(!)", () {
        final empty = {1, 2, 3};
        expect(empty.orEmptySet(), same(empty));
      });
    });

    group("Iterable<V?>", () {
      test("notNull()", () {
        expect([1, null, 2, 3, 3, null].notNull(), containsAllInOrder([1, 2, 3, 3]));
      });
      test("notNullSet()", () {
        expect([1, null, 2, 3, 3, null].notNullSet(), containsAllInOrder([1, 2, 3]));
        expect([1, null, 2, 3, 3, null].notNullSet(), isA<Set<Object>>());
      });
      test("notNullList()", () {
        expect([1, null, 2, 3, 3, null].notNullList(), containsAllInOrder([1, 2, 3, 3]));
        expect([1, null, 2, 3, 3, null].notNullList(), isA<List<Object>>());
      });
      test("mapNotNull()", () {
        expect([1, null, 2, 3, 3, null].mapNotNull((from) => "$from"), containsAllInOrder(["1", "2", "3", "3"]));
      });
    });
    group("Iterable<num>?", () {
      test("sum()", () {
        expect(null.sum(), equals(0));
        expect(null.sumInt(), equals(0));
        expect(null.sumDouble(), equals(0));
        expect([1, 2, 3].sumDouble(), equals(6.0));
        expect([1, 2, 3].sumInt(), equals(6));
      });
    });
    group("ComparableIterXX", () {
      test("max()", () {
        expect([-4, 3, 12, 100, 2].max(110), equals(100));
      });

      test("maxOrNull()", () => expect(<double>[].maxOrNull(), isNull));
      test("maxOrNull()", () => expect(<double>[].maxOrNull(12), equals(12)));
      test("max()", () => expect(<double>[].maxOrNull(12), equals(12)));
      test("max()", () => expect(() => <double>[].max(), throwsRangeError));
      test("sorted()", () {
        final list = [3, 2, 4, 1, 5];
        final sort = list.sorted();
        expect(sort, containsAllInOrder([1, 2, 3, 4, 5]));
        expect(list, containsAllInOrder([3, 2, 4, 1, 5]), reason: "Original list should remain untouched");
      });
    });
  });

  group("Iterable<V>", () {
    test("sortedUsing", () {
      final names = ["banana", "apple", "zebra", "cauliflower"];
      final idx = [1, 2, 3, 4];
      expect(idx.sortedUsing((item) => names[item - 1]), containsAllInOrder([2, 1, 4, 3]));
    });
    test("sortedBy", () {
      final names = ["banana", "apple", "zebra", "cauliflower"];
      final idx = [1, 2, 3, 4];
      expect(idx.sortedBy((a, b) => names[a - 1].compareTo(names[b - 1])), containsAllInOrder([2, 1, 4, 3]));
    });

    test("uniqueBy", () {
      final names = ["banana", "apple", "zebra", "apple"];
      final idx = [1, 2, 3, 4];
      expect(idx.uniqueBy((a) => names[a - 1]), containsAll([1, 4, 3]));
    });

    test("toStream", () async {
      final idx = [1, 2, 3, 4];
      var streamOf = idx.toStream();
      final awaited = await streamOf.toList();
      expect(awaited, containsAllInOrder(idx));
    });

    test("forEachAsync", () async {
      final idx = [1, 2, 3, 4];
      final result = <String>[];
      await idx.forEachAsync((item) => result.add("$item"));

      expect(result, containsAllInOrder(["1", "2", "3", "4"]));
    });

    test("truncate(index oob)", () async {
      final idx = [1, 2, 3, 4];
      expect(idx.truncate(6), equals(idx));
    });

    test("truncate(null)", () async {
      final idx = [1, 2, 3, 4];
      expect(idx.truncate(null), equals(idx));
    });

    test("truncate(index oob too low)", () async {
      final idx = [1, 2, 3, 4];
      expect(() => idx.truncate(-1), throwsRangeError);
    });

    test("truncate(index oob too low)", () async {
      final idx = [1, 2, 3, 4];
      expect(idx.truncate(0), equals([]));
    });

    test("truncate()", () async {
      final idx = [1, 2, 3, 4];
      expect(idx.truncate(2), equals([1, 2]));
    });

    test("joinWithAnd()", () async {
      final idx = [1, 2, 3];
      expect(idx.joinWithAnd(), equals("1, 2, and 3"));
    });

    test("joinWithAnd()", () async {
      final idx = [1, 2, 3, 4, 5];
      expect(idx.joinWithAnd(), equals("1, 2, 3, 4, and 5"));
    });

    test("joinWithAnd()", () async {
      final idx = [1, 2];
      expect(idx.joinWithAnd(), equals("1 and 2"));
    });

    test("joinWithAnd(formatter)", () async {
      final names = ["one", "two", "three", "four", "five"];

      final idx = [1, 2, 3, 4, 5];
      expect(idx.joinWithAnd((idx) => names[idx - 1]), equals("one, two, three, four, and five"));
    });

    test("mapPos()", () {
      final idx = [1, 2, 3];
      final result = idx.mapPos((idx, pos) {
        return MapEntry(idx, [
          pos.isFirst,
          pos.isLast,
          pos.isNotFirst,
          pos.isNotLast,
        ]);
      }).toMap();
      expect(result[1], equals([true, false, false, true]));
      expect(result[2], equals([false, false, true, true]));
      expect(result[3], equals([false, true, true, false]));
    });

    test("firstOr()", () async {
      expect(<String>[].firstOr(), isNull);
    });

    test("firstOr(default)", () async {
      expect(<String>[].firstOr("3"), equals("3"));
    });

    test("firstOr(default)", () async {
      expect(<String>["2", "4"].firstOr("3"), equals("2"));
    });

    // T? firstOr([T? ifEmpty]) {
    //   if (this.isEmpty) return ifEmpty;
    //   return this.first;
    // }
  });
  group("IterIter", () {
    test(
        "flatten()",
        () => expect(
            [
              [1, 2],
              [3, 4],
              [5, 6]
            ].flatten(),
            equals([1, 2, 3, 4, 5, 6])));
  });
}

Matcher throwsWithMessage(Object message) => _ExceptionMessage(message);

class _ExceptionMessage extends AsyncMatcher {
  final Object? _matcher;

  const _ExceptionMessage(this._matcher);

  @override
  Description describe(Description description) => description.add('error contains ').addDescriptionOf(_matcher);

  // Avoid async/await so we synchronously fail if we match a synchronous
  // function.
  @override
  dynamic /*FutureOr<String>*/ matchAsync(item) {
    if (item is! Function && item is! Future) {
      return 'was not a Function or Future';
    }

    if (item is Future) {
      return _matchFuture(item, 'emitted ');
    }

    try {
      var value = item();
      if (value is Future) {
        return _matchFuture(value, 'returned a Future that emitted ');
      }

      return indent(prettyPrint(value), first: 'returned ');
    } catch (error, trace) {
      return _check(error, trace);
    }
  }

  String formatFailure(Matcher expected, actual, String which, {String? reason}) {
    var buffer = StringBuffer();
    buffer.writeln(indent(prettyPrint(expected), first: 'Expected: '));
    buffer.writeln(indent(prettyPrint(actual), first: '  Actual: '));
    if (which.isNotEmpty) buffer.writeln(indent(which, first: '   Which: '));
    if (reason != null) buffer.writeln(reason);
    return buffer.toString();
  }

  /// Matches [future], using try/catch since `onError` doesn't seem to work
  /// properly in nnbd.
  Future<String?> _matchFuture(Future<dynamic> future, String messagePrefix) async {
    try {
      var value = await future;
      return indent(prettyPrint(value), first: messagePrefix);
    } catch (error, trace) {
      return _check(error, trace);
    }
  }

  /// Verifies that [error] matches [_matcher] and returns a [String]
  /// description of the failure if it doesn't.
  String? _check(error, StackTrace? trace) {
    if (_matcher == null) return null;

    var buffer = StringBuffer();
    var matchState = {};
    final _m = _matcher;
    if (_m is Matcher) {
      if (_m.matches(error, matchState)) return null;
      var result = _m.describeMismatch(error, StringDescription(), matchState, false).toString();
      buffer.writeln(indent(prettyPrint(error), first: 'threw '));
      if (trace != null) {
        buffer.writeln(indent(StackTraceFormatter.current!.formatStackTrace(trace).toString(), first: 'stack '));
      }
      if (result.isNotEmpty) buffer.writeln(indent(result, first: 'which '));
    } else {
      var expected = _matcher;

      final message = error?.toString();

      if (message == null) {
        buffer.writeln("is null, should have a value");
      } else if (!message.contains(expected.toString())) {
        buffer.writeln("should contain: '$_matcher' but was '$message'");
      } else {
        return null;
      }
    }

    return buffer.toString().trimRight();
  }
}
