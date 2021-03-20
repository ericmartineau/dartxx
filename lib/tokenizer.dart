import 'package:equatable/equatable.dart';

class Tokenizer {
  final Set<String> delimiters = {' ', '\n'};
  final bool yieldTokens;

  Tokenizer({this.yieldTokens = false, Set<String>? delimiters}) {
    this.delimiters.addAll(delimiters ?? {});
  }

  Iterable<Token> tokenize(String? chunk) sync* {
    if (chunk != null) {
      String _sequence = '';

      for (int i = 0; i < chunk.length; i++) {
        final char = chunk[i];

        if (delimiters.contains(char)) {
          if (_sequence.isNotEmpty) yield Token(_sequence);
          if (yieldTokens) yield Token(char);
          _sequence = '';
        } else {
          _sequence += char;
        }
      }

      if (_sequence.isNotEmpty) yield Token(_sequence);
    }
  }
}

class Token extends Equatable {
  final String value;

  const Token(this.value);
  @override
  List<Object> get props => [value];

  @override
  String toString() => value;
}
