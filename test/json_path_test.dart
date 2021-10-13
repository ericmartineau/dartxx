import 'package:dartxx/dartxx.dart';
import 'package:test/test.dart';

void main() {
  test('test.jsonPath.single', () {
    const path = JsonPath.single('firstName');
    expect(path.toString(), equals('/firstName'));
    expect(path.first, equals('firstName'));
    expect(path.last, equals('firstName'));
    expect(path[0], equals('firstName'));
    expect(path.length, equals(1));
    expect(() => path[1], throwsRangeError);
    expect(path.segments, equals(['firstName']));
  });

  test('test.jsonPath.normal', () {
    final path = JsonPath.parsed('/path/to/firstName');
    expect(path.toString(), equals('/path/to/firstName'));
    expect(path.first, equals('path'));
    expect(path.last, equals('firstName'));
    expect(path[0], equals('path'));
    expect(path[1], equals('to'));
    expect(path.segments, equals(['path', 'to', 'firstName']));
  });

  test('test.jsonPath.root', () {
    final path = JsonPath.parsed('/');
    expect(path.toString(), equals('/'));
    expect(path.length, equals(0));
    expect(() => path.first, throwsStateError);
    expect(() => path.last, throwsStateError);
    expect(() => path[0], throwsRangeError);
    expect(() => path[1], throwsRangeError);
    expect(path.segments, equals([]));
  });

  test('test.jsonPath.noPreceding', () {
    final path = JsonPath.parsed('path/to/');
    expect(path.toString(), equals('/path/to'));
    expect(path.length, equals(2));
    expect(path.first, equals('path'));
    expect(path.last, equals('to'));
    expect(path[0], equals('path'));
    expect(path[1], equals('to'));
    expect(path.segments, equals(['path', 'to']));
  });
}
