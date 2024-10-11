library flutter_placeholder;

import 'package:flutter/widgets.dart';

import 'text/lipsum.dart';
// import 'text/shadow.dart';

export 'text/lipsum.dart';

abstract class PlaceholderEx extends StatelessWidget {
  const PlaceholderEx({super.key});

  const factory PlaceholderEx.words(
    int lines, {
    Key? key,
    int? seed,
    bool startWithLorem,
  }) = LipsumText.words;

  const factory PlaceholderEx.linesOfText(
    int lines, {
    Key? key,
    int? seed,
    bool startWithLorem,
  }) = LipsumText.lines;

  const factory PlaceholderEx.paragraphs(
    int lines, {
    Key? key,
    int? seed,
    bool startWithLorem,
    int minSentencesPerParagraph,
    int maxSentencesPerParagraph,
  }) = LipsumText.paragraphs;

  // const factory PlaceholderEx.shadowText({Key? key}) = ShadowText.$;
}
