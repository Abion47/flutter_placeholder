import 'dart:math';

import 'package:flutter/widgets.dart';

import '../../utility/lipsum/lipsum.dart';
import '../placeholder_ex.dart';

enum LipsumTextMode {
  words,
  lines,
  paragraphs,
}

class LipsumText extends PlaceholderEx {
  final Definibus definibus;
  final LipsumTextMode mode;
  final int? seed;
  final bool startWithLorem;

  final int? _wordCount;

  final int? _lineCount;

  final int? _paragraphCount;
  final int? _paragraphMinSentencesPer;
  final int? _paragraphMaxSentencesPer;

  const LipsumText._({
    super.key,
    this.definibus = Definibus.defaultDefinibus,
    this.mode = LipsumTextMode.words,
    this.seed,
    required this.startWithLorem,
    int? wordCount,
    int? lineCount,
    int? paragraphCount,
    int? paragraphMinSentencesPer,
    int? paragraphMaxSentencesPer,
  })  : _wordCount = wordCount,
        _lineCount = lineCount,
        _paragraphCount = paragraphCount,
        _paragraphMinSentencesPer = paragraphMinSentencesPer,
        _paragraphMaxSentencesPer = paragraphMaxSentencesPer;

  const LipsumText.words(
    int words, {
    Key? key,
    int? seed,
    bool startWithLorem = false,
  }) : this._(
          key: key,
          mode: LipsumTextMode.words,
          seed: seed,
          startWithLorem: startWithLorem,
          wordCount: words,
        );

  const LipsumText.lines(
    int lines, {
    Key? key,
    int? seed,
    bool startWithLorem = false,
  }) : this._(
          key: key,
          mode: LipsumTextMode.lines,
          seed: seed,
          startWithLorem: startWithLorem,
          lineCount: lines,
        );

  const LipsumText.paragraphs(
    int paragraphs, {
    Key? key,
    int? seed,
    bool startWithLorem = false,
    int minSentencesPerParagraph = 3,
    int maxSentencesPerParagraph = 6,
  }) : this._(
          key: key,
          mode: LipsumTextMode.paragraphs,
          seed: seed,
          startWithLorem: startWithLorem,
          paragraphCount: paragraphs,
          paragraphMinSentencesPer: minSentencesPerParagraph,
          paragraphMaxSentencesPer: maxSentencesPerParagraph,
        );

  @override
  Widget build(BuildContext context) {
    final random = Random(seed);
    final lipsum = Lipsum(definibus: definibus);

    return switch (mode) {
      LipsumTextMode.words => Text(
          lipsum
              .words(
                _wordCount!,
                random: random,
                startWithLorem: startWithLorem,
              )
              .join(' '),
        ),
      LipsumTextMode.lines => Text(lipsum
          .lines(
            _lineCount!,
            random: random,
            startWithLorem: startWithLorem,
          )
          .join(' ')),
      LipsumTextMode.paragraphs => Text(lipsum
          .paragraphs(
            _paragraphCount!,
            random: random,
            startWithLorem: startWithLorem,
            minSentencesPer: _paragraphMinSentencesPer!,
            maxSentencesPer: _paragraphMaxSentencesPer!,
          )
          .join('\n\n')),
    };
  }
}
