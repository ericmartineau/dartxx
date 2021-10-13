import 'package:dartxx/dartxx.dart';
import 'package:test/test.dart';

void main() {
  group("map_ext", testMapExt);
  group("list_ext", testListExt);
}

void testListExt() {
  test('test.notNull', () {
    final list = [
      1,
      2,
      null,
      null,
      3,
      null,
      [null]
    ];
    final filtered = list.notNull();
    expect(filtered.length, equals(4));
    expect(
        filtered,
        containsAllInOrder([
          1,
          2,
          3,
          [null]
        ]));
  });
}

void testMapExt() {
  test('test.whereValuesNotNull', () {
    final map = {
      'empty': '',
      'null': null,
      'blank': '    ',
      'With stuff': 'Hey, George',
      'not-string': ["1", "2", "3"],
    };
    final filtered = map.valuesNotNull();
    expect(filtered.length, equals(4));
    expect(filtered.keys, containsAll(map.keys.where((element) => element != 'null')));
  });

  test('test.whereValuesNotNull non-nullable', () {
    Map<String, Object> map = {
      'empty': '',
      'date': DateTime.now(),
      'blank': '    ',
      'With stuff': 'Hey, George',
      'not-string': ["1", "2", "3"],
    };

    final filtered = map.valuesNotNull();
    expect(filtered.length, equals(5));
  });

  test('test.whereValuesNotNull doesnt remove nullable casts', () {
    String? nullString;
    if (true == true) {
      nullString = '1';
    }
    Map<String, dynamic> map = {
      'empty': null,
      'null': nullString,
      'blank': '    ',
      'With stuff': 'Hey, George',
      'not-string': ["1", "2", "3"],
    };
    final filtered = map.valuesNotNull();
    expect(filtered.length, equals(4));
    expect(filtered.keys, containsAll(map.keys.where((k) => k != 'empty')));
  });
}
