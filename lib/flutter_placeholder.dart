library flutter_placeholder;

export 'src/utility/lipsum/lipsum.dart';
export 'src/widget/placeholder_ex.dart';

// export 'src/widget/placeholder_ex.dart';

import 'dart:math';

import 'src/utility/lipsum/lipsum.dart';

// Sandboxing
void main() {
  final definibus = Definibus.defaultDefinibus;
  print(definibus.words.map((s) => '"$s"').join(', '));
}
