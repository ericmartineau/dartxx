import 'package:dartxx/dartxx.dart';
import 'package:test/test.dart';

void main() {
  group("TupleTest", () {
    test("Tuple toString", () {
      expect(Tuple(1, 2).toString(), equals("first[1]; second[2]"));
    });
    test("hashcode", () {
      final t = Tuple(1, 2);
      final t2 = Tuple(1, 2);
      expect(t.hashCode, equals(t2.hashCode));
    });

    test("equals", () {
      final t = Tuple(1, 2);
      final t2 = Tuple(1, 2);
      expect(t, equals(t2));
    });
    test("notEquals", () {
      final t = Tuple(1, 2);
      final t2 = Tuple(2, 1);
      expect(t, isNot(equals(t2)));
    });
  });
  group("Tokenizer", () {
    test("hashcode", () {
      final t = Token("Bob");
      final t2 = Token("Bob");
      expect(t.hashCode, equals(t2.hashCode));
    });

    test("equals", () {
      final t = Token("Bob");
      final t2 = Token("Bob");
      expect(t, equals(t2));
    });
    test("notEquals", () {
      final t = Token("Bob");
      final t2 = Token("bob");
      expect(t, isNot(equals(t2)));
    });
  });
}
