import 'package:equatable/equatable.dart';

class Tuple<A, B> extends Equatable {
  final A a;
  final B b;

  const Tuple(this.a, this.b);

  @override
  List<Object?> get props => [a, b];
}
