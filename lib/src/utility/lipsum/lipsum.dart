import 'dart:math';

import './definibus.dart';

export './definibus.dart';

final class Lipsum {
  final Definibus _definibus;

  Lipsum({Definibus? definibus})
      : _definibus = definibus ?? Definibus.defaultDefinibus;

  static const _loremWords = ['lorem', 'ipsum', 'dolor', 'sit', 'amet'];
  static const _loremLine =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

  List<String> words(
    int wordCount, {
    Random? random,
    bool startWithLorem = false,
  }) {
    if (wordCount == 0) return [];
    if (wordCount <= 5 && startWithLorem) {
      return _loremWords.take(wordCount).toList();
    }

    return wordGenerator(random: random, startWithLorem: startWithLorem)
        .take(wordCount)
        .toList();
  }

  Iterable<String> wordGenerator({
    Random? random,
    bool startWithLorem = false,
  }) sync* {
    if (startWithLorem) yield* _loremWords;

    var r = random ?? Random();
    var words = List<String>.from(_definibus.words)..shuffle(r);

    while (true) {
      for (final word in words) {
        yield word;
      }

      r = Random(r.nextInt(0xFFFFFFFF));
      words.shuffle(r);
    }
  }

  List<String> lines(
    int lineCount, {
    Random? random,
    bool startWithLorem = false,
  }) {
    if (lineCount == 0) return [];
    if (lineCount == 1 && startWithLorem) return [_loremLine];

    return lineGenerator(random: random, startWithLorem: startWithLorem)
        .take(lineCount)
        .toList();
  }

  Iterable<String> lineGenerator({
    Random? random,
    bool startWithLorem = false,
  }) sync* {
    if (startWithLorem) yield _loremLine;

    var r = random ?? Random();
    var lines = List<String>.from(_definibus.lines)..shuffle(r);

    while (true) {
      for (final line in lines) {
        yield line;
      }

      r = Random(r.nextInt(0xFFFFFFFF));
      lines.shuffle(r);
    }
  }

  List<String> paragraphs(
    int paragraphCount, {
    Random? random,
    bool startWithLorem = false,
    int minSentencesPer = 3,
    int maxSentencesPer = 6,
  }) {
    if (paragraphCount == 0) return [];

    return paragraphGenerator(
      random: random,
      startWithLorem: startWithLorem,
      minSentencesPer: minSentencesPer,
      maxSentencesPer: maxSentencesPer,
    ).take(paragraphCount).toList();
  }

  Iterable<String> paragraphGenerator({
    Random? random,
    bool startWithLorem = false,
    int minSentencesPer = 3,
    int maxSentencesPer = 6,
  }) sync* {
    bool isFirst = true;

    var r = random ?? Random();
    int range = maxSentencesPer - minSentencesPer + 1;
    int lineCount = r.nextInt(range) + minSentencesPer;

    while (true) {
      yield lineGenerator(
        random: Random(r.nextInt(0xFFFFFFFF)),
        startWithLorem: isFirst ? startWithLorem : false,
      ).take(lineCount).join(' ');

      lineCount = r.nextInt(range) + minSentencesPer;
      isFirst = false;
    }
  }
}
