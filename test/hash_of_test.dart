import 'package:dartxx/dartxx.dart';
import 'package:test/test.dart';

void main() {
  test('test.hashOfAll20', () {
    final hash1 = hashOf(
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        CustomerHasher("Bob", 10),
        CustomerHasher("Bob", 20),
        CustomerHasher("Bob", 30),
        CustomerHasher("Bob", 40),
        CustomerHasher("Bob", 50),
        CustomerHasher("Bob", 60),
        CustomerHasher("Bob", 70),
        CustomerHasher("Bob", 80),
        CustomerHasher("Bob", 90),
        CustomerHasher("Bob", 100));

    final hash2 = hashOf(
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
        CustomerHasher("Bob", 10),
        CustomerHasher("Bob", 20),
        CustomerHasher("Bob", 30),
        CustomerHasher("Bob", 40),
        CustomerHasher("Bob", 50),
        CustomerHasher("Bob", 60),
        CustomerHasher("Bob", 70),
        CustomerHasher("Bob", 80),
        CustomerHasher("Bob", 90),
        CustomerHasher("Bob", 100));

    expect(hash1, equals(hash2));
  });

  test('test.hashOf Fallbacks', () {
    final hash1 = hashOf(
      FallbackHasher("bob", 10),
      FallbackHasher("joe", 20),
      FallbackHasher("rich", 30),
    );

    final hash2 = hashOf(
      FallbackHasher("bob", 10),
      FallbackHasher("joe", 20),
      FallbackHasher("rich", 30),
    );

    expect(hash1, isNot(equals(hash2)));
  });
}

class CustomerHasher {
  final String name;
  final int age;

  CustomerHasher(this.name, this.age);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerHasher && runtimeType == other.runtimeType && name == other.name && age == other.age;

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}

class FallbackHasher {
  final String name;
  final int age;

  FallbackHasher(this.name, this.age);
}
