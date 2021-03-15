import 'package:equatable/equatable.dart';

abstract class Tuple<A, B> {
  A get first;

  B get second;

  const factory Tuple(A first, B second) = _Tuple;
}

mixin TupleMixin<A, B> implements Tuple<A, B> {
  @override
  String toString() => "first[$first]; second[$second]";
}

class _Tuple<A, B> extends Equatable with TupleMixin<A, B> {
  @override
  final A first;

  @override
  final B second;

  const _Tuple(this.first, this.second);

  @override
  List<Object?> get props => [first, second];
}
